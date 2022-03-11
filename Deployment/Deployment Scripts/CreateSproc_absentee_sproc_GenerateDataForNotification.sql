/****** Object:  StoredProcedure [absentee].[sproc_GenerateDataForNotification]    Script Date: 12/15/2020 5:30:28 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO







/*=================================================================================================================
	Author:			Doris Ma
	Create date:	2019-10-16

	Description:	Generate data for the notification queue

	COMMENTS:
	2019-10-16			DMa		original sproc created.
==================================================================================================================*/

CREATE PROCEDURE [absentee].[sproc_GenerateDataForNotification]
	@TemplateName VARCHAR(100)

AS
BEGIN
	DECLARE @TemplateID INT
		, @SendMail BIT
		, @SendText BIT
		, @Message NVARCHAR(4000)
		, @TableName VARCHAR(100)
		, @ChornicAbsenceDays INT

	SELECT @TemplateID = TemplateID
		, @SendMail = SendEmail
		, @SendText = SendText
		, @Message = [Message]
		, @TableName = TableOrViewName
		, @ChornicAbsenceDays = ChronicAbsenceDays
	FROM absentee.NotificationTemplate
	WHERE TemplateName = @TemplateName

	IF @SendText = 1
	BEGIN
		DECLARE @sql NVARCHAR(4000)
		DECLARE @NotificationTypeID INT, @SchoolYearInt INT
		SELECT TOP 1 @NotificationTypeID = NotificationTypeID 
		FROM absentee.lkNotificationType
		WHERE NotificationTypeDesc = 'Text Message'

		SELECT TOP 1 @SchoolYearInt = SchoolYear
		FROM edfi.SchoolYearType
		WHERE CurrentSchoolYear = 1

		DECLARE @FieldList VARCHAR(500)

		SELECT @FieldList = COALESCE(@FieldList + ', ', '') + FieldName
		FROM absentee.NotificationTemplateVariables ntv
		JOIN absentee.NotificationTemplate t
			ON t.TemplateID = ntv.TemplateID
		  WHERE t.TemplateName = @TemplateName
		  ORDER BY VariableID

		SET @sql = CONCAT('SELECT DISTINCT Student_Number, CellPhone, ContactTypeID, ', @FieldList,
			 ' INTO ##tmpDataTable FROM ', @TableName)
		IF @ChornicAbsenceDays IS NOT NULL
			SET @sql = CONCAT(@sql, ' WHERE DaysAbsent = ', @ChornicAbsenceDays)
		EXEC (@sql)
		ALTER TABLE ##tmpDataTable
		ADD MESSAGE NVARCHAR(4000)
		
		UPDATE ##tmpDataTable SET Message = @Message

		DECLARE @UpdateSQL NVARCHAR(4000)
		DECLARE @VariableString VARCHAR(50)
		DECLARE @VariableNumber INT
		DECLARE @FieldName VARCHAR(100)

		DECLARE curVariable CURSOR
		FOR 
		SELECT VariableID, FieldName
		FROM absentee.NotificationTemplateVariables
		WHERE TemplateID = @TemplateID
		ORDER BY VariableID

		OPEN curVariable
		FETCH NEXT FROM curVariable INTO @VariableNumber, @FieldName
		WHILE @@FETCH_STATUS = 0
			BEGIN
				SET @VariableString = CONCAT('''{',@VariableNumber,'}''')

				SET @UpdateSQL = CONCAT('UPDATE ##tmpDataTable
					SET Message = REPLACE(Message, ',@VariableString,',',@FieldName,')')

				EXEC(@UpdateSQL)

				FETCH NEXT FROM curVariable INTO @VariableNumber, @FieldName
			END

		CLOSE curVariable
		DEALLOCATE curVariable

		SELECT @SchoolYearInt AS SchoolYearInt
			, Student_Number
			, CellPhone
			--,'510-925-3314' AS CellPhone --Hard Code Cell Phone for Testing Purpose
			, [Message]
			, @TemplateID AS TemplateID
			, @NotificationTypeID AS NotificationTypeID
			, ContactTypeID
		FROM ##tmpDataTable
		WHERE CellPhone IS NOT NULL

		DROP TABLE ##tmpDataTable
	END
END
GO

