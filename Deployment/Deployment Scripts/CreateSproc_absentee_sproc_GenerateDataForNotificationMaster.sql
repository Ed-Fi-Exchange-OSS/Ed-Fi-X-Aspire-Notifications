/****** Object:  StoredProcedure [absentee].[sproc_GenerateDataForNotificationMaster]    Script Date: 12/15/2020 5:30:40 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


/*=================================================================================================================
	Author:			Doris Ma
	Create date:	2020-03-05

	Description:	Process Data Generation Based on Frequency

	COMMENTS:
	2020-03-05			DMa		original sproc created.
	2020-07-21          arramos fixing bi-weekly code to use week number of month and not of year
==================================================================================================================*/

CREATE PROCEDURE [absentee].[sproc_GenerateDataForNotificationMaster]

AS
BEGIN
	DECLARE @TemplateID INT
		, @TemplateName VARCHAR(100)
		, @Frequency VARCHAR(50)

	TRUNCATE TABLE absentee.NotificationPendingQueue

	DECLARE curTemplates CURSOR 
	FOR 
	SELECT TemplateID
		, TemplateName
		, FrequencyDesc
	FROM absentee.NotificationTemplate nt
	JOIN absentee.lkNotificationFrequency f
		ON f.FrequencyID = nt.FrequencyID
	WHERE nt.IsActive = 1
	ORDER BY TemplateID

	OPEN curTemplates
	FETCH NEXT FROM curTemplates INTO @TemplateID, @TemplateName, @Frequency
	WHILE @@FETCH_STATUS = 0
		BEGIN
			IF @Frequency = 'Daily'
				OR (@Frequency = 'Monthly' AND DAY(GETDATE()) = 1)
				OR (@Frequency = 'Quarterly' AND DATEADD(qq, DATEDIFF(qq, 0, GETDATE()), 0) = CONVERT(DATETIME,CONVERT(DATE,GETDATE())))
				OR (@Frequency = 'Weekly' AND DATEPART(WEEKDAY, GETDATE()) = 1)
				OR (@Frequency = 'Bi-Weekly' AND DATEPART(WEEKDAY, GETDATE()) = 1 AND dbo.GetWeekOfMonth(GETDATE()) IN (2, 4))
				INSERT INTO absentee.NotificationPendingQueue
				EXEC absentee.sproc_GenerateDataForNotification @TemplateName
			
			FETCH NEXT FROM curTemplates INTO @TemplateID, @TemplateName, @Frequency
        END 

CLOSE curTemplates
DEALLOCATE curTemplates

END
GO

