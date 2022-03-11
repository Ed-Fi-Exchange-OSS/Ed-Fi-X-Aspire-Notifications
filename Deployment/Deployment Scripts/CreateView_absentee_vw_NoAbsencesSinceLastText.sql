/****** Object:  View [absentee].[vw_NoAbsencesSinceLastText]    Script Date: 12/15/2020 5:27:39 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




/****************************************************************************************************
NAME: [absentee].[vw_NoAbsencesSinceLastText]

USE: Students with No Absences In Prior Month Since Last Text

COMMENTS:
2020-03-05			DMa		original sproc created.
****************************************************************************************************/

CREATE VIEW [absentee].[vw_NoAbsencesSinceLastText]
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
		, sas.DaysAbsentPriorMonth AS DaysAbsent
		, scp.CellPhone
		, sas.StudentPossessivePronoun
	FROM attendance.StudentAbsenceStats sas
	LEFT JOIN absentee.vw_StudentContactsPref scp
		ON scp.STUDENT_NUMBER = sas.Student_Number
	LEFT JOIN absentee.lkContactType ct
		ON ct.ContactTypeDesc = scp.ContactType
	WHERE 1=1
		AND sas.NotificationLastSentDate IS NOT NULL
		AND sas.DaysAbsentPriorMonth = 0
		AND scp.OptOut = 0
		AND scp.FewerMessages = 0

GO

