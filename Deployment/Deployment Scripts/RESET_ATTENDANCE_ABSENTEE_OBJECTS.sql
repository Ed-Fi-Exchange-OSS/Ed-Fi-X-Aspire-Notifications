/* SCRIPT: RESET_ATTENDANCE_ABSENTEE_OBJECTS.sql*/

PRINT 'DROPPING FUNCTIONS AND SPROCS...'
IF EXISTS (SELECT 1 FROM sys.objects o JOIN sys.schemas s ON s.schema_id = o.schema_id
	WHERE TYPE = 'P' AND o.name = 'sproc_PrepareData' AND s.name = 'absentee')
	DROP PROC absentee.sproc_PrepareData

IF EXISTS (SELECT 1 FROM sys.objects o JOIN sys.schemas s ON s.schema_id = o.schema_id
	WHERE TYPE = 'P' AND o.name = 'sproc_GenerateDataForNotificationMaster' AND s.name = 'absentee')
	DROP PROC absentee.sproc_GenerateDataForNotificationMaster

IF EXISTS (SELECT 1 FROM sys.objects o JOIN sys.schemas s ON s.schema_id = o.schema_id
	WHERE TYPE = 'P' AND o.name = 'sproc_GenerateDataForNotification' AND s.name = 'absentee')
	DROP PROC absentee.sproc_GenerateDataForNotification

IF EXISTS (SELECT 1 FROM sys.objects o JOIN sys.schemas s ON s.schema_id = o.schema_id
	WHERE TYPE = 'P' AND o.name = 'sproc_ExtractAbsenceStats' AND s.name = 'attendance')
	DROP PROC attendance.sproc_ExtractAbsenceStats

IF EXISTS (SELECT 1 FROM sys.objects o JOIN sys.schemas s ON s.schema_id = o.schema_id
	WHERE TYPE = 'P' AND o.name = 'sproc_ExtractDailyAttendance' AND s.name = 'attendance')
	DROP PROC attendance.sproc_ExtractDailyAttendance

IF EXISTS (SELECT 1 FROM sys.objects o JOIN sys.schemas s ON s.schema_id = o.schema_id
	WHERE TYPE = 'FN' AND o.name = 'GetWeekOfMonth' AND s.name = 'dbo')
	DROP FUNCTION dbo.GetWeekOfMonth
PRINT 'FUNCTIONS AND SPROCS RESET COMPLETE'
GO

PRINT 'DROPPING VIEWS...'
IF EXISTS (SELECT 1 FROM sys.objects o JOIN sys.schemas s ON s.schema_id = o.schema_id
	WHERE TYPE = 'V' AND o.name = 'vw_OpsOutOfText' AND s.name = 'absentee')
	DROP VIEW absentee.vw_OpsOutOfText

IF EXISTS (SELECT 1 FROM sys.objects o JOIN sys.schemas s ON s.schema_id = o.schema_id
	WHERE TYPE = 'V' AND o.name = 'vw_NoAbsencesSinceLastText' AND s.name = 'absentee')
	DROP VIEW absentee.vw_NoAbsencesSinceLastText

IF EXISTS (SELECT 1 FROM sys.objects o JOIN sys.schemas s ON s.schema_id = o.schema_id
	WHERE TYPE = 'V' AND o.name = 'vw_MonthlyFewerThan3AbsencesThanPriorMonth' AND s.name = 'absentee')
	DROP VIEW absentee.vw_MonthlyFewerThan3AbsencesThanPriorMonth

IF EXISTS (SELECT 1 FROM sys.objects o JOIN sys.schemas s ON s.schema_id = o.schema_id
	WHERE TYPE = 'V' AND o.name = 'vw_MissedSchoolSinceLastTextWeekly' AND s.name = 'absentee')
	DROP VIEW absentee.vw_MissedSchoolSinceLastTextWeekly

IF EXISTS (SELECT 1 FROM sys.objects o JOIN sys.schemas s ON s.schema_id = o.schema_id
	WHERE TYPE = 'V' AND o.name = 'vw_MissedSchoolSinceLastTextBiWeekly' AND s.name = 'absentee')
	DROP VIEW absentee.vw_MissedSchoolSinceLastTextBiWeekly

IF EXISTS (SELECT 1 FROM sys.objects o JOIN sys.schemas s ON s.schema_id = o.schema_id
	WHERE TYPE = 'V' AND o.name = 'vw_MissedSchoolLastQuarter' AND s.name = 'absentee')
	DROP VIEW absentee.vw_MissedSchoolLastQuarter

IF EXISTS (SELECT 1 FROM sys.objects o JOIN sys.schemas s ON s.schema_id = o.schema_id
	WHERE TYPE = 'V' AND o.name = 'vw_ChronicAbsencesWithThreshold' AND s.name = 'absentee')
	DROP VIEW absentee.vw_ChronicAbsencesWithThreshold

IF EXISTS (SELECT 1 FROM sys.objects o JOIN sys.schemas s ON s.schema_id = o.schema_id
	WHERE TYPE = 'V' AND o.name = 'vw_ChronicAbsences' AND s.name = 'absentee')
	DROP VIEW absentee.vw_ChronicAbsences

IF EXISTS (SELECT 1 FROM sys.objects o JOIN sys.schemas s ON s.schema_id = o.schema_id
	WHERE TYPE = 'V' AND o.name = 'vw_AbsencesMonthToDate' AND s.name = 'absentee')
	DROP VIEW absentee.vw_AbsencesMonthToDate

IF EXISTS (SELECT 1 FROM sys.objects o JOIN sys.schemas s ON s.schema_id = o.schema_id
	WHERE TYPE = 'V' AND o.name = 'vw_StudentContactsPref' AND s.name = 'absentee')
	DROP VIEW absentee.vw_StudentContactsPref

IF EXISTS (SELECT 1 FROM sys.objects o JOIN sys.schemas s ON s.schema_id = o.schema_id
	WHERE TYPE = 'V' AND o.name = 'vw_StudentSchool' AND s.name = 'attendance')
	DROP VIEW attendance.vw_StudentSchool

IF EXISTS (SELECT 1 FROM sys.objects o JOIN sys.schemas s ON s.schema_id = o.schema_id
	WHERE TYPE = 'V' AND o.name = 'vw_StudentContacts' AND s.name = 'absentee')
	DROP VIEW absentee.vw_StudentContacts

IF EXISTS (SELECT 1 FROM sys.objects o JOIN sys.schemas s ON s.schema_id = o.schema_id
	WHERE TYPE = 'V' AND o.name = 'vw_Students' AND s.name = 'attendance')
	DROP VIEW attendance.vw_Students

IF EXISTS (SELECT 1 FROM sys.objects o JOIN sys.schemas s ON s.schema_id = o.schema_id
	WHERE TYPE = 'V' AND o.name = 'vw_InstructionalDay' AND s.name = 'attendance')
	DROP VIEW attendance.vw_InstructionalDay

PRINT 'VIEWS RESET COMPLETE'
GO

PRINT 'DROPPING TABLES...'
IF EXISTS (SELECT 1 FROM sys.objects o JOIN sys.schemas s ON s.schema_id = o.schema_id
	WHERE TYPE = 'U' AND o.name = 'StudentAbsenceStats' AND s.name = 'attendance')
	DROP TABLE attendance.StudentAbsenceStats

IF EXISTS (SELECT 1 FROM sys.objects o JOIN sys.schemas s ON s.schema_id = o.schema_id
	WHERE TYPE = 'U' AND o.name = 'StudentContacts' AND s.name = 'absentee')
	DROP TABLE absentee.StudentContacts

IF EXISTS (SELECT 1 FROM sys.objects o JOIN sys.schemas s ON s.schema_id = o.schema_id
	WHERE TYPE = 'U' AND o.name = 'StudentNotificationSetting' AND s.name = 'absentee')
	DROP TABLE absentee.StudentNotificationSetting

IF EXISTS (SELECT 1 FROM sys.objects o JOIN sys.schemas s ON s.schema_id = o.schema_id
	WHERE TYPE = 'U' AND o.name = 'NotificationTemplateVariables' AND s.name = 'absentee')
	DROP TABLE absentee.NotificationTemplateVariables

IF EXISTS (SELECT 1 FROM sys.objects o JOIN sys.schemas s ON s.schema_id = o.schema_id
	WHERE TYPE = 'U' AND o.name = 'NotificationPendingQueue' AND s.name = 'absentee')
	DROP TABLE absentee.NotificationPendingQueue

IF EXISTS (SELECT 1 FROM sys.objects o JOIN sys.schemas s ON s.schema_id = o.schema_id
	WHERE TYPE = 'U' AND o.name = 'NotificationSentLog' AND s.name = 'absentee')
	DROP TABLE absentee.NotificationSentLog

IF EXISTS (SELECT 1 FROM sys.objects o JOIN sys.schemas s ON s.schema_id = o.schema_id
	WHERE TYPE = 'U' AND o.name = 'NotificationTemplate' AND s.name = 'absentee')
	DROP TABLE absentee.NotificationTemplate

IF EXISTS (SELECT 1 FROM sys.objects o JOIN sys.schemas s ON s.schema_id = o.schema_id
	WHERE TYPE = 'U' AND o.name = 'lkNotificationFrequency' AND s.name = 'absentee')
	DROP TABLE absentee.lkNotificationFrequency

IF EXISTS (SELECT 1 FROM sys.objects o JOIN sys.schemas s ON s.schema_id = o.schema_id
	WHERE TYPE = 'U' AND o.name = 'lkNotificationType' AND s.name = 'absentee')
	DROP TABLE absentee.lkNotificationType

IF EXISTS (SELECT 1 FROM sys.objects o JOIN sys.schemas s ON s.schema_id = o.schema_id
	WHERE TYPE = 'U' AND o.name = 'lkContactType' AND s.name = 'absentee')
	DROP TABLE absentee.lkContactType

IF EXISTS (SELECT 1 FROM sys.objects o JOIN sys.schemas s ON s.schema_id = o.schema_id
	WHERE TYPE = 'U' AND o.name = 'SchoolSetup' AND s.name = 'absentee')
	DROP TABLE absentee.SchoolSetup

IF EXISTS (SELECT 1 FROM sys.objects o JOIN sys.schemas s ON s.schema_id = o.schema_id
	WHERE TYPE = 'U' AND o.name = 'StudentDailyAttendance' AND s.name = 'attendance')
	DROP TABLE attendance.StudentDailyAttendance

PRINT 'TABLES RESET COMPLETE'
GO