/****** Object:  Table [attendance].[StudentDailyAttendance]    Script Date: 12/15/2020 5:21:03 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [attendance].[StudentDailyAttendance](
	[FullDate] [datetime] NOT NULL,
	[SSID] [varchar](50) NOT NULL,
	[StudentNumber] [int] NOT NULL,
	[SchoolId] [int] NOT NULL,
	[SchoolNumber] [varchar](50) NOT NULL,
	[AttendanceValue] [int] NOT NULL,
	[SchoolYear] [int] NOT NULL
) ON [PRIMARY]
GO

