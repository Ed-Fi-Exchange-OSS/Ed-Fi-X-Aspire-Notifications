/****** Object:  View [attendance].[vw_Students]    Script Date: 12/15/2020 5:29:14 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO







CREATE VIEW [attendance].[vw_Students]
AS
/*-------------------------------------------

Name: attendance.vw_Students

Usage: Retrieves Students with the local PowerSchool Student Number

Comments:
2020-02-27	DMa		Create
----------------------------------------------*/
SELECT TRY_CONVERT(INT,sic.IdentificationCode) AS StudentNumber, s.*, LEFT(gender.CodeValue,1) AS Gender
	FROM [edfi].[Student] s
	JOIN (SELECT ROW_NUMBER() OVER (PARTITION BY ic.IdentificationCode ORDER BY ic.CreateDate DESC) RowNum
		, ic.*
	FROM [edfi].[StudentEducationOrganizationAssociationStudentIdentificationCode] ic
	JOIN edfi.Descriptor sd
		ON sd.DescriptorId = ic.StudentIdentificationSystemDescriptorId
			AND sd.[Namespace] = 'uri://ed-fi.org/StudentIdentificationSystemDescriptor'
			AND sd.CodeValue = 'District') sic
		ON sic.StudentUSI = s.StudentUSI
			AND RowNum = 1
	JOIN edfi.Descriptor gender
		ON gender.DescriptorId = s.BirthSexDescriptorId
		AND gender.[Namespace] = 'uri://ed-fi.org/SexDescriptor'
GO

