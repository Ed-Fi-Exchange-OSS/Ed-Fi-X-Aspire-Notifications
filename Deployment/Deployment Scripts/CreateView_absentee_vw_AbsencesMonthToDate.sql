/****** Object:  View [absentee].[vw_AbsencesMonthToDate]    Script Date: 12/15/2020 5:22:32 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO






/****************************************************************************************************
NAME: [absentee].[vw_AbsencesMonthToDate]

USE: Students with Month To Date Absence > 0

COMMENTS:
2019-10-16			DMa		original sproc created.
****************************************************************************************************/


CREATE VIEW [absentee].[vw_AbsencesMonthToDate]
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
		, sas.DaysAbsentMTD AS DaysAbsent
		, scp.CellPhone
		, sas.StudentPossessivePronoun
		, 'here <http://YourCustomAttendanceLink>' AS AttendanceLink
	FROM attendance.StudentAbsenceStats sas
	LEFT JOIN absentee.vw_StudentContactsPref scp
		ON scp.STUDENT_NUMBER = sas.Student_Number
	LEFT JOIN absentee.lkContactType ct
		ON ct.ContactTypeDesc = scp.ContactType
	WHERE 1=1
		AND sas.NotificationLastSentDate IS NULL
		AND sas.DaysAbsentMTD > 0
		AND scp.OptOut = 0
		AND scp.FewerMessages = 0


GO

