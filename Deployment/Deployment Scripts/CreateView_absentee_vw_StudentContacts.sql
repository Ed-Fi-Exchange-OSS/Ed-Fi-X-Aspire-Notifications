/****** Object:  View [absentee].[vw_StudentContacts]    Script Date: 12/15/2020 5:28:20 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO









CREATE VIEW [absentee].[vw_StudentContacts]
AS
/*-------------------------------------------

Name: absentee.vw_StudentContacts

Usage:	Retrieves Student Contacts (Father/Mother) with their Mobile Number;
		Currently Ed-Fi ODS does not have a student's primary language, so
		defaulting to English. If in the future the student's primary language
		is available, the view can be updated to pull the primary language.

Comments:
2020-02-28	DMa		original sproc created.
----------------------------------------------*/
SELECT s.StudentNumber
	, 'English' AS StudentPrimaryLanguage
	, p.LastSurname AS LastName
	, p.FirstName AS FirstName
	, pt.TelephoneNumber AS CellPhone
	, rtd.CodeValue AS ContactType
	, IIF(rtd.CodeValue = 'Father','Mr.','Mrs.') AS Salutation
FROM attendance.vw_Students s
JOIN edfi.StudentParentAssociation sps
	ON sps.StudentUSI = s.StudentUSI
JOIN edfi.Parent p
	ON p.ParentUSI = sps.ParentUSI
JOIN edfi.Descriptor rtd
	ON rtd.DescriptorId = sps.RelationDescriptorId
		AND rtd.[Namespace] = 'uri://ed-fi.org/RelationDescriptor'
		AND rtd.CodeValue IN ('Mother', 'Father')
JOIN edfi.ParentTelephone pt
	ON pt.ParentUSI = p.ParentUSI
JOIN edfi.Descriptor ptd
	ON ptd.DescriptorId = pt.TelephoneNumberTypeDescriptorId
		AND ptd.[Namespace] = 'uri://ed-fi.org/TelephoneNumberTypeDescriptor'
		AND ptd.CodeValue = 'Mobile'



GO

