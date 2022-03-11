/****** Object:  Table [absentee].[StudentContacts]    Script Date: 12/15/2020 5:19:54 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [absentee].[StudentContacts](
	[STUDENT_NUMBER] [int] NULL,
	[StudentPrimaryLanguage] [varchar](100) NULL,
	[LastName] [varchar](100) NULL,
	[FirstName] [varchar](100) NULL,
	[CellPhone] [varchar](50) NULL,
	[ContactType] [varchar](50) NULL,
	[Salutation] [varchar](50) NULL
) ON [PRIMARY]
GO

