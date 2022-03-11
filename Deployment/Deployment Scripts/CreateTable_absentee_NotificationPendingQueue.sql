/****** Object:  Table [absentee].[NotificationPendingQueue]    Script Date: 12/15/2020 5:17:42 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [absentee].[NotificationPendingQueue](
	[SchoolYear] [int] NOT NULL,
	[Student_Number] [int] NOT NULL,
	[CellPhone] [varchar](50) NOT NULL,
	[Message] [nvarchar](4000) NOT NULL,
	[TemplateID] [int] NOT NULL,
	[NotificationTypeID] [int] NOT NULL,
	[ContactTypeID] [int] NOT NULL,
	[ID] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_YourTable] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

