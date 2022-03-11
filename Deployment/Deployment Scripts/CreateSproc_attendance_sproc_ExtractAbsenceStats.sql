/****** Object:  StoredProcedure [attendance].[sproc_ExtractAbsenceStats]    Script Date: 12/15/2020 5:32:43 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/****************************************************************************************************
NAME: [attendance].[sproc_ExtractAbsenceStats]

USE: Absence statistics for students

COMMENTS:
2020-02-28			DMa		original sproc created.
****************************************************************************************************/

CREATE PROCEDURE [attendance].[sproc_ExtractAbsenceStats]
AS

DECLARE @LastDateOfPriorMonth DATETIME = DATEADD(MONTH, DATEDIFF(MONTH, -1, GETDATE())-1, -1) --Last Day of previous month

DECLARE @Quarter INT = DATENAME(Quarter, CAST(CONVERT(VARCHAR(8), @LastDateOfPriorMonth, 112) AS DATETIME))

SELECT DISTINCT
    CONVERT(DATETIME,AD.[FullDate]) AS FullDate
    , AD.[StudentNumber]
    , AD.[SchoolNumber]
    , [AttendanceValue]
	, AD.[SSID]
	, ad.SchoolYear
INTO #ad
FROM attendance.StudentDailyAttendance AD
WHERE 1=1
	AND ad.SchoolYear = (SELECT SchoolYear FROM edfi.SchoolYearType WHERE CurrentSchoolYear = 1)
	AND ad.FullDate < CONVERT(DATETIME, CONVERT(DATE,GETDATE()))

SELECT *
INTO #Student
FROM attendance.vw_Students

SELECT ad.*
	, s.LastSurname AS LastName
	, s.FirstName
INTO #ads
FROM #ad ad
JOIN #Student s
ON s.StudentNumber = ad.StudentNumber

SELECT *
INTO #StudentSchoolAssociation
FROM attendance.vw_StudentSchool

SELECT si.*, ssa.SchoolNumber AS SchoolNumber
INTO #si
FROM #Student si
JOIN #StudentSchoolAssociation ssa
	ON ssa.StudentUSI = si.StudentUSI
JOIN absentee.SchoolSetup ss
	ON ss.SchoolId = ssa.SchoolId
WHERE 1=1
	AND ss.NotificationOn = 1
	AND (ssa.ExitWithdrawDate IS NULL OR ssa.ExitWithdrawDate > GETDATE() -1)
	

TRUNCATE TABLE attendance.StudentAbsenceStats

INSERT INTO attendance.StudentAbsenceStats
(
    SchoolYear
    , Student_Number
    , StudentLast
    , StudentFirst
    , DaysAbsentYTD
    , DaysAbsentMTD
    , DaysAbsentPriorMonth
    , DaysAbsentPriorPriorMonth
    , DaysAbsentPast7DaysSinceLastNotification
    , DaysAbsentPast14DaysSinceLastNotification
	, DaysAbsentLastQuarter
    , DaysAbsentSinceLastNotification
	, DaysPresentYTD
	, StudentSubjectPronoun
    , StudentPossessivePronoun
    , NotificationLastSentDate
)
SELECT ad.SchoolYear
	, ad.StudentNumber
	, ad.LastName StudentLast
	, ad.FirstName StudentFirst
	, SUM(IIF(AttendanceValue=0,1,0)) DaysAbsentYTD
	, SUM(IIF(AttendanceValue=0 
		AND YEAR(ad.FullDate) = YEAR(GETDATE()) 
		AND MONTH(ad.FullDate) = MONTH(GETDATE()),1,0)) DaysAbsentMTD
	, SUM(IIF(AttendanceValue=0 
		AND YEAR(ad.FullDate) = YEAR(GETDATE()) 
		AND MONTH(ad.FullDate) = MONTH(GETDATE())-1,1,0)) DaysAbsentPriorMonth
	, SUM(IIF(AttendanceValue=0 
		AND YEAR(ad.FullDate) = YEAR(GETDATE()) 
		AND MONTH(ad.FullDate) = MONTH(GETDATE())-2,1,0)) DaysAbsentPriorPriorMonth
	, IIF(nsl.NotificationLastSentDate IS NULL, 0,
			SUM(IIF(AttendanceValue=0
				AND ad.FullDate BETWEEN DATEADD(DD, -7, GETDATE()) AND GETDATE(),1,0))) AS DaysAbsentPast7DaysSinceLastNotification
	, IIF(nsl.NotificationLastSentDate IS NULL, 0,
			SUM(IIF(AttendanceValue=0
				AND ad.FullDate BETWEEN DATEADD(DD, -14, GETDATE()) AND GETDATE(),1,0))) AS DaysAbsentPast14DaysSinceLastNotification
	, SUM(IIF(AttendanceValue=0
				AND DATENAME(QUARTER, CAST(CONVERT(VARCHAR(8), FullDate) AS DATETIME)) = @Quarter,1,0)) AS DaysAbsentLastQuarter
	, IIF(nsl.NotificationLastSentDate IS NULL, 0,
			SUM(IIF(AttendanceValue=0
				AND ad.FullDate > nsl.NotificationLastSentDate,1,0))) AS DaysAbsentSinceLastNotification
	, SUM(IIF(AttendanceValue=1,1,0)) DaysPresentYTD
	, CASE si.Gender
		WHEN 'F' THEN 'She'
		WHEN 'M' THEN 'He'
		ELSE 's/he' END ASStudentSubjectPronoun
	, CASE si.Gender
		WHEN 'F' THEN 'her'
		WHEN 'M' THEN 'his'
		ELSE 'his/her' END AS StudentPossessivePronoun
	, nsl.NotificationLastSentDate
FROM #ads ad
JOIN #si si
	ON si.StudentNumber = ad.StudentNumber
	AND si.SchoolNumber = ad.SchoolNumber
LEFT JOIN 
	(SELECT Student_Number, MAX(MessageSent) NotificationLastSentDate
	FROM absentee.NotificationSentLog
	WHERE SchoolYear = (SELECT SchoolYear FROM edfi.SchoolYearType WHERE CurrentSchoolYear =1)
	GROUP BY Student_Number) nsl
	ON nsl.Student_Number = ad.StudentNumber
  WHERE 1=1
  AND ad.SchoolYear = (SELECT SchoolYear FROM edfi.SchoolYearType WHERE CurrentSchoolYear =1)
  AND ad.FullDate < CONVERT(DATETIME,CONVERT(DATE,GETDATE()))
  GROUP BY ad.SchoolYear
           , ad.StudentNumber
		   , ad.LastName
		   , ad.FirstName
		   , si.Gender
		   , nsl.NotificationLastSentDate

DROP TABLE #Student
DROP TABLE #StudentSchoolAssociation
DROP TABLE #ad
DROP TABLE #ads
DROP TABLE #si

GO

