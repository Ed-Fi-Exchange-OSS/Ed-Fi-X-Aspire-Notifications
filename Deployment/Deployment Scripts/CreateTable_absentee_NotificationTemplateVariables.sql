/****** Object:  Table [absentee].[NotificationTemplateVariables]    Script Date: 12/15/2020 5:19:12 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [absentee].[NotificationTemplateVariables](
	[TemplateID] [int] NOT NULL,
	[VariableID] [int] NOT NULL,
	[FieldName] [varchar](100) NOT NULL,
	[Description] [varchar](500) NOT NULL,
	[ID] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_NotificationTemplateVariables] PRIMARY KEY CLUSTERED 
(
	[TemplateID] ASC,
	[VariableID] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [absentee].[NotificationTemplateVariables]  WITH CHECK ADD  CONSTRAINT [FK_NotificationTemplateVariables_NotificationTemplate] FOREIGN KEY([TemplateID])
REFERENCES [absentee].[NotificationTemplate] ([TemplateID])
GO

ALTER TABLE [absentee].[NotificationTemplateVariables] CHECK CONSTRAINT [FK_NotificationTemplateVariables_NotificationTemplate]
GO

