/****** Object:  Table [attendance].[StudentAbsenceStats]    Script Date: 12/15/2020 5:20:38 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [attendance].[StudentAbsenceStats](
	[SchoolYear] [int] NOT NULL,
	[Student_Number] [int] NOT NULL,
	[StudentLast] [varchar](50) NOT NULL,
	[StudentFirst] [varchar](50) NOT NULL,
	[DaysAbsentYTD] [int] NOT NULL,
	[DaysAbsentMTD] [int] NOT NULL,
	[DaysAbsentPriorMonth] [int] NOT NULL,
	[DaysAbsentPriorPriorMonth] [int] NOT NULL,
	[DaysAbsentPast7DaysSinceLastNotification] [int] NOT NULL,
	[DaysAbsentPast14DaysSinceLastNotification] [int] NOT NULL,
	[DaysAbsentLastQuarter] [int] NOT NULL,
	[DaysAbsentSinceLastNotification] [int] NOT NULL,
	[DaysPresentYTD] [int] NOT NULL,
	[StudentSubjectPronoun] [varchar](50) NOT NULL,
	[StudentPossessivePronoun] [varchar](50) NOT NULL,
	[NotificationLastSentDate] [datetime] NULL,
 CONSTRAINT [PK_absentee_StudentAbsenceStats] PRIMARY KEY CLUSTERED 
(
	[SchoolYear] ASC,
	[Student_Number] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

