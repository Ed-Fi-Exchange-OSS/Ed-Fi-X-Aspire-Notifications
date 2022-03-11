/****** Object:  StoredProcedure [attendance].[sproc_ExtractDailyAttendance]    Script Date: 12/15/2020 5:33:11 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/****************************************************************************************************
NAME: [attendance].[sproc_ExtractDailyAttendance]

USE: Extract Daily Attendance based on absentee data

COMMENTS:
2020-02-27			DMa		original sproc created.
****************************************************************************************************/

CREATE PROCEDURE [attendance].[sproc_ExtractDailyAttendance]
AS
BEGIN
	TRUNCATE TABLE attendance.StudentDailyAttendance

	SELECT *
	INTO #StudentSchoolAssociation
	FROM edfi.StudentSchoolAssociation

	SELECT *
	INTO #InstructionalCalendar
	FROM attendance.vw_InstructionalDay

	SELECT *
	INTO #Student
	FROM attendance.vw_Students

	SELECT *
	INTO #StudentSchoolAttendanceEvent
	FROM edfi.StudentSchoolAttendanceEvent

	INSERT INTO attendance.StudentDailyAttendance
	SELECT ic.[Date] AS FullDate
		, s.StudentUniqueId AS SSID
		, s.StudentNumber
		, ic.SchoolId
		, ic.SchoolNumber
		, IIF(ssae.StudentUSI IS NULL,1,0) AS AttendanceValue
		, ic.SchoolYear
	FROM #StudentSchoolAssociation ssa
	JOIN #InstructionalCalendar ic
		ON ic.SchoolId = ssa.SchoolId
	JOIN #Student s
		ON s.StudentUSI = ssa.StudentUSI
	LEFT JOIN #StudentSchoolAttendanceEvent ssae
		ON ssae.StudentUSI = ssa.StudentUSI
			AND ssae.EventDate = ic.[Date]
	WHERE 1=1
		AND ic.[Date] BETWEEN ssa.EntryDate AND COALESCE(ssa.ExitWithdrawDate,GETDATE())
		AND ssa.EntryDate <> COALESCE(ssa.ExitWithdrawDate,GETDATE())
		AND ssa.EntryDate < COALESCE(ssa.ExitWithdrawDate,GETDATE())
		AND ic.Date <= GETDATE()

	DROP TABLE #InstructionalCalendar
	DROP TABLE #Student
	DROP TABLE #StudentSchoolAssociation
	DROP TABLE #StudentSchoolAttendanceEvent

END
GO

