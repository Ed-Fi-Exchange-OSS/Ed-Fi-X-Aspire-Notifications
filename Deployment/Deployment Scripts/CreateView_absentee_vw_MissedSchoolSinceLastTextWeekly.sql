/****** Object:  View [absentee].[vw_MissedSchoolSinceLastTextWeekly]    Script Date: 12/15/2020 5:26:49 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO








/****************************************************************************************************
NAME: [absentee].[vw_MissedSchoolSinceLastTextWeekly]

USE: Students with absences since last text Weekly

COMMENTS:
2020-03-05			DMa		original sproc created.
****************************************************************************************************/

CREATE VIEW [absentee].[vw_MissedSchoolSinceLastTextWeekly]
AS

	SELECT sas.Student_Number
		, sas.StudentLast
		, sas.StudentFirst
		, ct.ContactTypeID
		, scp.ContactType
		, scp.Salutation
		, scp.LastName ContactLastName
		, scp.FirstName ContactFirstName
		, IIF(COALESCE(scp.LastName,'') <> '', CONCAT(scp.Salutation, ' ', scp.LastName),'') AS ContactLast
		, sas.DaysAbsentPast7DaysSinceLastNotification AS DaysAbsent
		, scp.CellPhone
	FROM attendance.StudentAbsenceStats sas
	LEFT JOIN absentee.vw_StudentContactsPref scp
		ON scp.STUDENT_NUMBER = sas.Student_Number
	LEFT JOIN absentee.lkContactType ct
		ON ct.ContactTypeDesc = scp.ContactType
	WHERE 1=1
		AND sas.NotificationLastSentDate IS NOT NULL
		AND sas.DaysAbsentPast7DaysSinceLastNotification > 0
		AND scp.OptOut = 0
		AND scp.FewerMessages = 0

GO

