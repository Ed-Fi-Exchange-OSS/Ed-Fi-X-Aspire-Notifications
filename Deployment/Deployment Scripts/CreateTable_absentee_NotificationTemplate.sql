/****** Object:  Table [absentee].[NotificationTemplate]    Script Date: 12/15/2020 5:18:38 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [absentee].[NotificationTemplate](
	[TemplateID] [int] IDENTITY(1,1) NOT NULL,
	[TemplateName] [varchar](100) NOT NULL,
	[SendEmail] [bit] NOT NULL,
	[SendText] [bit] NOT NULL,
	[FrequencyID] [int] NOT NULL,
	[Message] [nvarchar](4000) NOT NULL,
	[ChronicAbsenceDays] [int] NULL,
	[IsActive] [bit] NOT NULL,
	[TableOrViewName] [varchar](100) NULL,
 CONSTRAINT [PK_NotificationTemplate] PRIMARY KEY CLUSTERED 
(
	[TemplateID] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [absentee].[NotificationTemplate] ADD  CONSTRAINT [DF_NotificationTemplate_SendEmail]  DEFAULT ((0)) FOR [SendEmail]
GO

ALTER TABLE [absentee].[NotificationTemplate] ADD  CONSTRAINT [DF_NotificationTemplate_SendText]  DEFAULT ((0)) FOR [SendText]
GO

ALTER TABLE [absentee].[NotificationTemplate] ADD  CONSTRAINT [DF_NotificationTemplate_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO

ALTER TABLE [absentee].[NotificationTemplate]  WITH CHECK ADD  CONSTRAINT [FK_NotificationTemplate_NotificationFrequency] FOREIGN KEY([FrequencyID])
REFERENCES [absentee].[lkNotificationFrequency] ([FrequencyID])
GO

ALTER TABLE [absentee].[NotificationTemplate] CHECK CONSTRAINT [FK_NotificationTemplate_NotificationFrequency]
GO

