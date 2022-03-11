/****** Object:  View [absentee].[vw_ChronicAbsences]    Script Date: 12/15/2020 5:23:27 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




/****************************************************************************************************
NAME: [absentee].[vw_ChronicAbsenses]

USE: Students with 6, 12 or 18 days of absenses in the school year

COMMENTS:
2019-10-17			DMa		original sproc created.
****************************************************************************************************/


CREATE VIEW [absentee].[vw_ChronicAbsences]
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
		, sas.DaysAbsentYTD AS DaysAbsent
		, scp.CellPhone
	FROM attendance.StudentAbsenceStats sas
	LEFT JOIN absentee.vw_StudentContactsPref scp
		ON scp.STUDENT_NUMBER = sas.Student_Number
	LEFT JOIN absentee.lkContactType ct
		ON ct.ContactTypeDesc = scp.ContactType
	WHERE 1=1
		AND sas.NotificationLastSentDate IS NULL
		AND sas.DaysAbsentYTD IN (6,12,18)
		AND scp.OptOut = 0
		AND scp.FewerMessages = 0


GO

