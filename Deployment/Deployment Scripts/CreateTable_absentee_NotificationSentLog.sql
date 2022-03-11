/****** Object:  Table [absentee].[NotificationSentLog]    Script Date: 12/15/2020 5:18:10 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [absentee].[NotificationSentLog](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[SchoolYear] [int] NOT NULL,
	[Student_Number] [int] NOT NULL,
	[TemplateID] [int] NOT NULL,
	[MessageSent] [datetime] NOT NULL,
	[NotificationTypeID] [int] NOT NULL,
	[ContactTypeID] [int] NOT NULL,
	[NotificationStatus] [varchar](500) NULL,
	[Message] [nvarchar](4000) NULL,
 CONSTRAINT [PK_NotificationSentLog] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [absentee].[NotificationSentLog] ADD  CONSTRAINT [DF_NotificationSentLog_MessageSent]  DEFAULT (getdate()) FOR [MessageSent]
GO

ALTER TABLE [absentee].[NotificationSentLog] ADD  CONSTRAINT [DF_NotificationSentLog_SentToFather]  DEFAULT ((0)) FOR [NotificationTypeID]
GO

ALTER TABLE [absentee].[NotificationSentLog]  WITH CHECK ADD  CONSTRAINT [FK_NotificationSentLog_lkContactType1] FOREIGN KEY([ContactTypeID])
REFERENCES [absentee].[lkContactType] ([ContactTypeID])
GO

ALTER TABLE [absentee].[NotificationSentLog] CHECK CONSTRAINT [FK_NotificationSentLog_lkContactType1]
GO

ALTER TABLE [absentee].[NotificationSentLog]  WITH CHECK ADD  CONSTRAINT [FK_NotificationSentLog_lkNotificationType] FOREIGN KEY([NotificationTypeID])
REFERENCES [absentee].[lkNotificationType] ([NotificationTypeID])
GO

ALTER TABLE [absentee].[NotificationSentLog] CHECK CONSTRAINT [FK_NotificationSentLog_lkNotificationType]
GO

ALTER TABLE [absentee].[NotificationSentLog]  WITH CHECK ADD  CONSTRAINT [FK_NotificationSentLog_NotificationTemplate] FOREIGN KEY([TemplateID])
REFERENCES [absentee].[NotificationTemplate] ([TemplateID])
GO

ALTER TABLE [absentee].[NotificationSentLog] CHECK CONSTRAINT [FK_NotificationSentLog_NotificationTemplate]
GO

