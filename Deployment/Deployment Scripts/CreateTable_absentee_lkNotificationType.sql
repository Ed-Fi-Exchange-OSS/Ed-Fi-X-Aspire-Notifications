/****** Object:  Table [absentee].[lkNotificationType]    Script Date: 12/15/2020 5:17:15 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [absentee].[lkNotificationType](
	[NotificationTypeID] [int] IDENTITY(1,1) NOT NULL,
	[NotificationTypeDesc] [varchar](50) NOT NULL,
 CONSTRAINT [PK_lkNotificationType] PRIMARY KEY CLUSTERED 
(
	[NotificationTypeID] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

