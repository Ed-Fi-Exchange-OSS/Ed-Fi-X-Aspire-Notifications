/****** Object:  StoredProcedure [absentee].[sproc_PrepareData]    Script Date: 12/15/2020 5:32:24 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



/*=================================================================================================================
	Author:			Doris Ma
	Create date:	2019-10-17

	Description:	Prepare Data for the notifications

	COMMENTS:
	2019-10-17			DMa		original sproc created.
==================================================================================================================*/

CREATE PROCEDURE [absentee].[sproc_PrepareData]

AS
BEGIN
	-- Extract the Student Contacts
	TRUNCATE TABLE absentee.StudentContacts
	INSERT INTO absentee.StudentContacts
	SELECT * FROM absentee.vw_StudentContacts

	-- Add students to notification settings table; update ActiveStudent Status if student is inactive
	MERGE absentee.StudentNotificationSetting sns
	USING attendance.vw_Students si
	ON si.StudentNumber = sns.Student_Number
	WHEN NOT MATCHED THEN
		INSERT (Student_Number, FatherOptOut, FatherFewerMessages,MotherOptOut,MotherFewerMessages,ActiveStudent)
		VALUES (si.StudentNumber, 0, 0, 0, 0, 1)
	WHEN NOT MATCHED BY SOURCE AND sns.ActiveStudent = 1 THEN
		UPDATE SET sns.ActiveStudent = 0;

	-- Create the student absence statistics data
	EXEC attendance.sproc_ExtractDailyAttendance
	EXEC attendance.sproc_ExtractAbsenceStats
	EXEC absentee.sproc_GenerateDataForNotificationMaster
END
GO

