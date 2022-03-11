/****** Object:  View [attendance].[vw_StudentSchool]    Script Date: 12/15/2020 5:29:24 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO







CREATE VIEW [attendance].[vw_StudentSchool]
AS
/*-------------------------------------------

Name: attendance.vw_StudentSchool

Usage: Retrieves Student School Association with the local PowerSchool School Number

Comments:
2020-02-28	DMa		Create
----------------------------------------------*/
	SELECT ssa.*, eoic.IdentificationCode AS SchoolNumber
	FROM edfi.StudentSchoolAssociation ssa
	JOIN edfi.EducationOrganizationIdentificationCode eoic
		ON eoic.EducationOrganizationId = ssa.SchoolId
	JOIN edfi.Descriptor eod
		ON eod.DescriptorId = eoic.EducationOrganizationIdentificationSystemDescriptorId
		AND eod.[Namespace] = 'uri://ed-fi.org/EducationOrganizationIdentificationSystemDescriptor'
		AND eod.CodeValue = 'LEA'
GO

