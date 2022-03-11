/****** Object:  Table [absentee].[lkContactType]    Script Date: 12/15/2020 5:14:27 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [absentee].[lkContactType](
	[ContactTypeID] [int] IDENTITY(1,1) NOT NULL,
	[ContactTypeDesc] [varchar](50) NOT NULL,
 CONSTRAINT [PK_lkContactType] PRIMARY KEY CLUSTERED 
(
	[ContactTypeID] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

