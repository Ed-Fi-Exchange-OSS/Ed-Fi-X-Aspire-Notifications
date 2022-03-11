/****** Object:  View [attendance].[vw_InstructionalDay]    Script Date: 12/15/2020 5:28:50 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO





CREATE VIEW [attendance].[vw_InstructionalDay]
AS
/*-------------------------------------------

Name: attendance.vw_InstructionalDay

Usage: Retrieves All Instructional Days for the Current Year for Each School

Comments:
2020-02-27	DMa		Created
----------------------------------------------*/
SELECT DISTINCT
      [Date]
      ,[SchoolId]
	  ,eoic.IdentificationCode AS SchoolNumber
      ,cdce.[SchoolYear]
  FROM [edfi].[CalendarDateCalendarEvent] cdce
  JOIN edfi.Descriptor cd
	ON cd.DescriptorId = cdce.CalendarEventDescriptorId
		AND cd.[Namespace] = 'uri://ed-fi.org/CalendarEventDescriptor'
		AND cd.CodeValue = 'Instructional day'
  JOIN edfi.SchoolYearType syt
	ON syt.SchoolYear = cdce.SchoolYear
		AND syt.CurrentSchoolYear = 1
  JOIN edfi.EducationOrganizationIdentificationCode eoic
	ON eoic.EducationOrganizationId = cdce.SchoolId
  JOIN edfi.Descriptor eod
	ON eod.DescriptorId = eoic.EducationOrganizationIdentificationSystemDescriptorId
		AND eod.[Namespace] = 'uri://ed-fi.org/EducationOrganizationIdentificationSystemDescriptor'
		AND eod.CodeValue = 'SEA'
  WHERE 1=1
GO

