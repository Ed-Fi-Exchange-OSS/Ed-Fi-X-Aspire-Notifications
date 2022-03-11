/****** Object:  Table [absentee].[lkNotificationFrequency]    Script Date: 12/15/2020 5:16:39 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [absentee].[lkNotificationFrequency](
	[FrequencyID] [int] IDENTITY(1,1) NOT NULL,
	[FrequencyDesc] [varchar](50) NOT NULL,
 CONSTRAINT [PK_lkNotificationFrequency] PRIMARY KEY CLUSTERED 
(
	[FrequencyID] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

