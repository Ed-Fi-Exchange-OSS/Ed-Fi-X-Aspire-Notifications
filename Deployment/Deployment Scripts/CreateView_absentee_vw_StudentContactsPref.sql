/****** Object:  View [absentee].[vw_StudentContactsPref]    Script Date: 12/15/2020 5:28:40 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


/****************************************************************************************************
NAME: [absentee].[vw_StudentContactsPref]

USE: Student Contact's info & preferences

COMMENTS:
2019-10-16			DMa		original sproc created.
****************************************************************************************************/


CREATE VIEW [absentee].[vw_StudentContactsPref]
AS

SELECT sc.STUDENT_NUMBER
	, sc.LastName
	, sc.FirstName
	, sc.ContactType
	, sc.CellPhone
	, CASE WHEN sc.ContactType = 'Father' THEN sns.FatherOptOut
		WHEN sc.ContactType = 'Mother' THEN sns.MotherOptOut
		ELSE NULL END AS OptOut
	, CASE WHEN sc.ContactType = 'Father' THEN sns.FatherFewerMessages
		WHEN sc.ContactType = 'Mother' THEN sns.MotherFewerMessages
		ELSE NULL END AS FewerMessages
	, sc.Salutation
FROM absentee.StudentContacts sc
JOIN absentee.StudentNotificationSetting sns
	ON sns.Student_Number = sc.STUDENT_NUMBER
GO

