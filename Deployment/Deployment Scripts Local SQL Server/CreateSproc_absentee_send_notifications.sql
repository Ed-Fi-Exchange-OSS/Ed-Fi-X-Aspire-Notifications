/****** Object:  StoredProcedure [absentee].[sproc_GenerateDataForNotification]    Script Date: 12/15/2020 5:30:28 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO







/*=================================================================================================================
	Author:			Doris Ma
	Create date:	2021-10-05

	Description:	Retrieve pending messages to be sent from the Ed-Fi ODS and insert into the Twilio Database
					Messages table for Twilio to send them. After the messages are sent, the records will be
					inserted to the NotificationSentLog table in the EdFi ODS and remove from the Pending messages
					table.

	COMMENTS:
	2021-10-05			DMa		original sproc created.
==================================================================================================================*/

CREATE PROCEDURE [absentee].[sproc_SendNotifications]

AS
BEGIN
	DECLARE @FromPhoneNumber VARCHAR(15) = '+1##########' -- REPLACE WITH Twilio's Sender Phone Number
	DECLARE @DateSent DATETIME = GETDATE()

	-- Pulling the Pending Messages From Ed-Fi ODS and INSERT INTO Twilio's Messages table
	INSERT INTO [TWILIO_DB].[CData Twilio Sys].[Twilio].[Messages]
				([To], [Sender], [Body])
	SELECT CONCAT('+1',CellPhone), @FromPhoneNumber, [Message]
	FROM [EDFI_PRODUCTION].[EdFi_Ods_Production].[absentee].[NotificationPendingQueue]

	WAITFOR DELAY '00:01:00' -- WAIT FOR 60 Seconds for Twilio to COMPLETE SENT OUT

	-- Logging the Messages Sent
	INSERT INTO [EDFI_PRODUCTION].[EdFi_Ods_Production].[absentee].[NotificationSentLog]
		([SchoolYear],[Student_Number],[TemplateID],[MessageSent],[NotificationTypeID]
			,[ContactTypeID],[NotificationStatus],[Message])
	SELECT DISTINCT [SchoolYear], [Student_Number], [TemplateID], COALESCE([DateSent],GETDATE()), [NotificationTypeID]
			,[ContactTypeID],T.[Status],[Message]
	FROM [EDFI_PRODUCTION].[EdFi_Ods_Production].[absentee].[NotificationPendingQueue] pq
	LEFT JOIN [TWILIO_DB].[CData Twilio Sys].[Twilio].[Messages] T
		ON T.[DateSent] >= @DateSent
		AND T.[To] = CONCAT('+1',pq.[CellPhone])
		AND T.[Sender] = @FromPhoneNumber
		AND T.[Direction] = 'outbound-api'

	-- Delete from the Pending Messages Table
	DELETE [EDFI_PRODUCTION].[EdFi_Ods_Production].[absentee].[NotificationPendingQueue]

END
GO

