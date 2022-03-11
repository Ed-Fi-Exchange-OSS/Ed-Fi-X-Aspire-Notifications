/* SCRIPT: CREATE_ATTENDANCE_ABSENTEE_OBJECTS.sql*/

-- Set Working Directory, Update this to the directory where the files are extracted
:SETVAR ScriptDir "C:\Scripts\"

-- THis is the main caller for each script
SET NOCOUNT ON
GO

PRINT 'CREATING SCHEMA...'
IF NOT EXISTS (SELECT 1 FROM sys.schemas WHERE name = 'attendance')
	EXEC ('CREATE SCHEMA attendance')
GO

IF NOT EXISTS (SELECT 1 FROM sys.schemas WHERE name = 'absentee')
	EXEC ('CREATE SCHEMA absentee')
GO	
PRINT 'SCHEMA CREATION IS COMPLETE'

:ON ERROR EXIT

PRINT 'CREATING TABLES...'
:r $(ScriptDir)"CreateTable_attendance_StudentDailyAttendance.sql"
:r $(ScriptDir)"CreateTable_absentee_SchoolSetup.sql"
:r $(ScriptDir)"CreateTable_absentee_lkContactType.sql"
:r $(ScriptDir)"CreateTable_absentee_lkNotificationType.sql"
:r $(ScriptDir)"CreateTable_absentee_lkNotificationFrequency.sql"
:r $(ScriptDir)"CreateTable_absentee_NotificationTemplate.sql"
:r $(ScriptDir)"CreateTable_absentee_NotificationSentLog.sql"
:r $(ScriptDir)"CreateTable_absentee_NotificationPendingQueue.sql"
:r $(ScriptDir)"CreateTable_absentee_NotificationTemplateVariables.sql"
:r $(ScriptDir)"CreateTable_absentee_StudentNotificationSetting.sql"
:r $(ScriptDir)"CreateTable_absentee_StudentContacts.sql"
:r $(ScriptDir)"CreateTable_attendance_StudentAbsenceStats.sql"

PRINT 'TABLE CREATION IS COMPLETE'
GO

PRINT 'CREATING VIEWS...'
:r $(ScriptDir)"CreateView_attendance_vw_InstructionDay.sql"
:r $(ScriptDir)"CreateView_attendance_vw_Students.sql"
:r $(ScriptDir)"CreateView_absentee_vw_StudentContacts.sql"
:r $(ScriptDir)"CreateView_attendance_vw_StudentSchool.sql"
:r $(ScriptDir)"CreateView_absentee_vw_StudentContactsPref.sql"
:r $(ScriptDir)"CreateView_absentee_vw_AbsencesMonthToDate.sql"
:r $(ScriptDir)"CreateView_absentee_vw_ChronicAbsences.sql"
:r $(ScriptDir)"CreateView_absentee_vw_ChronicAbsencesThreshold.sql"
:r $(ScriptDir)"CreateView_absentee_vw_MissedSchoolLastQuarter.sql"
:r $(ScriptDir)"CreateView_absentee_vw_MissedSchoolSinceLastTextBiWeekly.sql"
:r $(ScriptDir)"CreateView_absentee_vw_MissedSchoolSinceLastTextWeekly.sql"
:r $(ScriptDir)"CreateView_absentee_vw_MonthlyFewerThan3AbsencesThanPriorMonth.sql"
:r $(ScriptDir)"CreateView_absentee_vw_NoAbsencesSinceLastText.sql"
:r $(ScriptDir)"CreateView_absentee_vw_OpsOutOfText.sql"

PRINT 'VIEW CREATION IS COMPLETE'
GO

PRINT 'CREATING FUNCTIONS AND SPROCS...'
:r $(ScriptDir)"CreateFunction_dbo_GetWeekOfMonth.sql"
:r $(ScriptDir)"CreateSproc_attendance_sproc_ExtractDailyAttendance.sql"
:r $(ScriptDir)"CreateSproc_attendance_sproc_ExtractAbsenceStats.sql"
:r $(ScriptDir)"CreateSproc_absentee_sproc_GenerateDataForNotification.sql"
:r $(ScriptDir)"CreateSproc_absentee_sproc_GenerateDataForNotificationMaster.sql"
:r $(ScriptDir)"CreateSproc_absentee_sproc_PrepareData.sql"

PRINT 'FUNCTION AND SPROC CREATION IS COMPLETE'
GO