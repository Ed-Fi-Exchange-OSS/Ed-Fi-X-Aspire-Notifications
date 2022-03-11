/****** Object:  View [absentee].[vw_ChronicAbsencesWithThreshold]    Script Date: 12/15/2020 5:23:37 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO









/****************************************************************************************************
NAME: [absentee].[vw_ChronicAbsencesWithThreshold]

USE: Students with more than 18 days of absenses in the school year

COMMENTS:
2020-03-05			DMa		original sproc created.
****************************************************************************************************/


CREATE VIEW [absentee].[vw_ChronicAbsencesWithThreshold]
AS

WITH CTE_AvgAbsence
AS 
(SELECT AVG(sa.TotalAbsence) AS AvgAbsence
FROM 
(SELECT StudentNumber, SUM(IIF(AttendanceValue = 0, 1,0)) TotalAbsence 
FROM attendance.StudentDailyAttendance
WHERE 1=1
AND FullDate < CONVERT(DATETIME,CONVERT(DATE,GETDATE()))
GROUP BY StudentNumber
HAVING SUM(IIF(AttendanceValue = 0, 1,0)) > 0) sa)

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
		, CONVERT(INT,IIF(sas.DaysAbsentYTD + sas.DaysPresentYTD=0,1.0
			,TRY_CONVERT(DECIMAL(8,5),sas.DaysAbsentYTD)/(sas.DaysAbsentYTD +sas.DaysPresentYTD)) * 180) AS AnticipatedAbsentDays
		, CONVERT(INT,IIF(sas.DaysAbsentYTD + sas.DaysPresentYTD=0,1.0
			,TRY_CONVERT(DECIMAL(8,5),sas.DaysAbsentYTD)/(sas.DaysAbsentYTD +sas.DaysPresentYTD)) * 180 / TRY_CONVERT(DECIMAL(8,2),aa.AvgAbsence)) AS PeersAbsenceMultipler
		, scp.CellPhone
		, sas.StudentSubjectPronoun
		, sas.StudentPossessivePronoun
	FROM attendance.StudentAbsenceStats sas
	LEFT JOIN absentee.vw_StudentContactsPref scp
		ON scp.STUDENT_NUMBER = sas.Student_Number
	LEFT JOIN absentee.lkContactType ct
		ON ct.ContactTypeDesc = scp.ContactType
	CROSS JOIN CTE_AvgAbsence aa
	WHERE 1=1
		AND sas.NotificationLastSentDate IS NULL
		AND sas.DaysAbsentYTD > 18
		AND scp.OptOut = 0
		AND scp.FewerMessages = 0

GO

