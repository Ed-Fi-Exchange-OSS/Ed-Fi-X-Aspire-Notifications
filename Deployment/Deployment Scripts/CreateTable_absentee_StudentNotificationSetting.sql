/****** Object:  Table [absentee].[StudentNotificationSetting]    Script Date: 12/15/2020 5:20:23 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [absentee].[StudentNotificationSetting](
	[Student_Number] [int] NOT NULL,
	[FatherOptOut] [bit] NOT NULL,
	[FatherFewerMessages] [bit] NOT NULL,
	[MotherOptOut] [bit] NOT NULL,
	[MotherFewerMessages] [bit] NOT NULL,
	[ActiveStudent] [bit] NOT NULL,
 CONSTRAINT [PK_StudentNotificationSetting] PRIMARY KEY CLUSTERED 
(
	[Student_Number] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [absentee].[StudentNotificationSetting] ADD  CONSTRAINT [DF_StudentNotificationSetting_OptOut]  DEFAULT ((0)) FOR [FatherOptOut]
GO

ALTER TABLE [absentee].[StudentNotificationSetting] ADD  CONSTRAINT [DF_StudentNotificationSetting_FewerMessages]  DEFAULT ((0)) FOR [FatherFewerMessages]
GO

ALTER TABLE [absentee].[StudentNotificationSetting] ADD  CONSTRAINT [DF_StudentNotificationSetting_MotherOptOut]  DEFAULT ((0)) FOR [MotherOptOut]
GO

ALTER TABLE [absentee].[StudentNotificationSetting] ADD  CONSTRAINT [DF_StudentNotificationSetting_MotherFewerMessages]  DEFAULT ((0)) FOR [MotherFewerMessages]
GO

ALTER TABLE [absentee].[StudentNotificationSetting] ADD  CONSTRAINT [DF_StudentNotificationSetting_ActiveStudent]  DEFAULT ((1)) FOR [ActiveStudent]
GO

