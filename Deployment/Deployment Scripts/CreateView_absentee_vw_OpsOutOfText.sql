/****** Object:  View [absentee].[vw_OpsOutOfText]    Script Date: 12/15/2020 5:28:02 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO






/****************************************************************************************************
NAME: [absentee].[vw_OpsOutOfText]

USE: Students contacts who opt of for receiving text messages

COMMENTS:
2020-03-05			DMa		original sproc created.
****************************************************************************************************/


CREATE VIEW [absentee].[vw_OpsOutOfText]
AS

	SELECT 
		sas.STUDENT_NUMBER
		, sas.StudentLast
		, sas.StudentFirst
		, ct.ContactTypeID
		, scp.ContactType
		, scp.Salutation
		, scp.LastName ContactLastName
		, scp.FirstName ContactFirstName
		, IIF(COALESCE(scp.LastName,'') <> '', CONCAT(scp.Salutation, ' ', scp.LastName),'') AS ContactLast
		, CellPhone
	FROM attendance.StudentAbsenceStats sas
	JOIN absentee.vw_StudentContactsPref scp
		ON scp.STUDENT_NUMBER = sas.Student_Number
	LEFT JOIN absentee.lkContactType ct
		ON ct.ContactTypeDesc = scp.ContactType
	WHERE scp.OptOut = 1


GO

