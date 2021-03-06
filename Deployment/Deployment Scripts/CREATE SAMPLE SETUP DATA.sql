-- First remove current data from tables
DELETE [absentee].[NotificationTemplateVariables]
DELETE [absentee].[NotificationTemplate]
DELETE [absentee].[lkNotificationFrequency]
DELETE [absentee].[lkContactType]
DELETE [absentee].[lkNotificationType]

-- Insert Data for lkContactType Table
SET IDENTITY_INSERT [absentee].[lkContactType] ON
INSERT [absentee].[lkContactType] ([ContactTypeID], [ContactTypeDesc]) VALUES (1, N'Father')
INSERT [absentee].[lkContactType] ([ContactTypeID], [ContactTypeDesc]) VALUES (2, N'Mother')
SET IDENTITY_INSERT [absentee].[lkContactType] OFF
GO

-- Insert Data for lkNotificationType Table
SET IDENTITY_INSERT [absentee].[lkNotificationType] ON 
INSERT [absentee].[lkNotificationType] ([NotificationTypeID], [NotificationTypeDesc]) VALUES (1, N'Text Message')
INSERT [absentee].[lkNotificationType] ([NotificationTypeID], [NotificationTypeDesc]) VALUES (2, N'Email')
SET IDENTITY_INSERT [absentee].[lkNotificationType] OFF
GO

-- Insert Data for lkNotificationFrequency Table
SET IDENTITY_INSERT [absentee].[lkNotificationFrequency] ON 
INSERT [absentee].[lkNotificationFrequency] ([FrequencyID], [FrequencyDesc]) VALUES (1, N'Daily')
INSERT [absentee].[lkNotificationFrequency] ([FrequencyID], [FrequencyDesc]) VALUES (2, N'Monthly')
INSERT [absentee].[lkNotificationFrequency] ([FrequencyID], [FrequencyDesc]) VALUES (3, N'Quarterly')
INSERT [absentee].[lkNotificationFrequency] ([FrequencyID], [FrequencyDesc]) VALUES (4, N'Weekly')
INSERT [absentee].[lkNotificationFrequency] ([FrequencyID], [FrequencyDesc]) VALUES (5, N'Bi-Weekly')
INSERT [absentee].[lkNotificationFrequency] ([FrequencyID], [FrequencyDesc]) VALUES (6, N'Once')
SET IDENTITY_INSERT [absentee].[lkNotificationFrequency] OFF
GO

-- Insert Data for NotifcationTemplate Table
SET IDENTITY_INSERT [absentee].[NotificationTemplate] ON 
INSERT [absentee].[NotificationTemplate] ([TemplateID], [TemplateName], [SendEmail], [SendText], [FrequencyID], [Message], [ChronicAbsenceDays], [IsActive], [TableOrViewName]) VALUES (1, N'First Text Message', 0, 1, 1, N'{0}: {1} missed {2} days of school this month. Students fall behind every day that they miss school - whether they are absent for excused or unexcused reasons. Thank you in advance for your help in making sure {1} is at school every day.

Click here to see {3} attendance trends compared to the peers
', NULL, 1, N'absentee.vw_AbsencesMonthToDate')
INSERT [absentee].[NotificationTemplate] ([TemplateID], [TemplateName], [SendEmail], [SendText], [FrequencyID], [Message], [ChronicAbsenceDays], [IsActive], [TableOrViewName]) VALUES (2, N'Missed 0 Days Since Last Text', 0, 1, 2, N'{0}: {1} missed 0 days of school this month.

We expect all of our scholars to be in school and ready to learn every day and we are proud of the perfect attendance this month
', NULL, 1, N'absentee.vw_NoAbsencesSinceLastText')
INSERT [absentee].[NotificationTemplate] ([TemplateID], [TemplateName], [SendEmail], [SendText], [FrequencyID], [Message], [ChronicAbsenceDays], [IsActive], [TableOrViewName]) VALUES (3, N'Missed School Since Last Text Bi-weekly', 0, 1, 1, N'{0}: {1} missed {2} days of school in the past 2 weeks. Students fall behind every day that they miss school - whether they are absent for excused or unexcused reasons. Thank you in advance for your help in making sure {1} is at school every day.
', NULL, 1, N'absentee.vw_MissedSchoolSinceLastTextBiWeekly')
INSERT [absentee].[NotificationTemplate] ([TemplateID], [TemplateName], [SendEmail], [SendText], [FrequencyID], [Message], [ChronicAbsenceDays], [IsActive], [TableOrViewName]) VALUES (4, N'Missed School Since Last Text Weekly', 0, 1, 1, N'{0}: {1} missed {2} days of school in the past week. Students fall behind every day that they miss school - whether they are absent for excused or unexcused reasons. Thank you in advance for your help in making sure {1} is at school every day.
', NULL, 1, N'absentee.vw_MissedSchoolSinceLastTextWeekly')
INSERT [absentee].[NotificationTemplate] ([TemplateID], [TemplateName], [SendEmail], [SendText], [FrequencyID], [Message], [ChronicAbsenceDays], [IsActive], [TableOrViewName]) VALUES (5, N'Ops Out of Text', 0, 1, 3, N'We noticed you chose to stop receiving {0} attendance updates. Would you like to receive fewer messages instead?', NULL, 1, N'absentee.vw_OpsOutOfText')
INSERT [absentee].[NotificationTemplate] ([TemplateID], [TemplateName], [SendEmail], [SendText], [FrequencyID], [Message], [ChronicAbsenceDays], [IsActive], [TableOrViewName]) VALUES (6, N'Fewer Text or Quarterly Celebration', 0, 1, 3, N'{0}: {1} missed {2) days of school this past quarter. Students fall behind every day that they miss school - whether they are absent for excused or unexcused reasons. Thank you in advance for your help in making sure (1) is at school every day.
', NULL, 1, N'absentee.vw_MissedSchoolLastQuarter')
INSERT [absentee].[NotificationTemplate] ([TemplateID], [TemplateName], [SendEmail], [SendText], [FrequencyID], [Message], [ChronicAbsenceDays], [IsActive], [TableOrViewName]) VALUES (7, N'Monthly For 3 Fewer Absent Days Than Prev Month', 0, 1, 2, N'{0}: {1} missed {2} days of school this month - an improvement! 🎉 
Keep helping to make sure {1} is at school every day - thank you!
', NULL, 1, N'absentee.vw_MonthlyFewerThan3AbsencesThanPriorMonth')
INSERT [absentee].[NotificationTemplate] ([TemplateID], [TemplateName], [SendEmail], [SendText], [FrequencyID], [Message], [ChronicAbsenceDays], [IsActive], [TableOrViewName]) VALUES (8, N'Chronic Absent 6 Days', 0, 1, 1, N'{0}: {1} is on track to miss 6 days of school this school year*. That’s more than a whole week of falling behind!

Let’s change this prediction by ensuring {1} is in school each day. Please contact the school principal, the student''s teacher or the communication outreach manager if you need support in getting {1} to school.
', 6, 1, N'absentee.vw_ChronicAbsences')
INSERT [absentee].[NotificationTemplate] ([TemplateID], [TemplateName], [SendEmail], [SendText], [FrequencyID], [Message], [ChronicAbsenceDays], [IsActive], [TableOrViewName]) VALUES (9, N'Chronic Absent 12 Days', 0, 1, 1, N'{0}: {1} is on track to miss 12 days of school this school year*. That’s two and a half weeks of falling behind!

Let’s change this prediction by ensuring {1} is in school each day. Please contact the school principal, the student''s teacher or the communication outreach manager if you need support in getting {1} to school.
', 12, 1, N'absentee.vw_ChronicAbsences')
INSERT [absentee].[NotificationTemplate] ([TemplateID], [TemplateName], [SendEmail], [SendText], [FrequencyID], [Message], [ChronicAbsenceDays], [IsActive], [TableOrViewName]) VALUES (10, N'Chronic Absent 18 Days', 0, 1, 1, N'{0}: {1} is on track to miss 18 days of school this school year*. That’s almost a whole month of falling behind!

Let’s change this prediction by ensuring {1} is in school each day. Please contact the school principal or the student''s teacher if you need support in getting {1} to school.
', 18, 1, N'absentee.vw_ChronicAbsences')
INSERT [absentee].[NotificationTemplate] ([TemplateID], [TemplateName], [SendEmail], [SendText], [FrequencyID], [Message], [ChronicAbsenceDays], [IsActive], [TableOrViewName]) VALUES (11, N'Met 18 Day/10 % Absent Threshold', 0, 1, 2, N'{0}: {1} is already considered chronically absent according to the State for missing over 18 days of school. {1} is on track to miss {2} days by the end of the school year! That is {3} times the number of absences compared to the peers. 

 Let’s work to improve {1}''s attendance going forward - every day matters. 
', NULL, 1, N'absentee.vw_ChronicAbsencesWithThreshold')
SET IDENTITY_INSERT [absentee].[NotificationTemplate] OFF
GO

-- Insert Data for NotificationTemplateVariables Table
SET IDENTITY_INSERT [absentee].[NotificationTemplateVariables] ON 
INSERT [absentee].[NotificationTemplateVariables] ([TemplateID], [VariableID], [FieldName], [Description], [ID]) VALUES (1, 0, N'ContactLast', N'Last Name with Salutation', 1)
INSERT [absentee].[NotificationTemplateVariables] ([TemplateID], [VariableID], [FieldName], [Description], [ID]) VALUES (1, 1, N'StudentFirst', N'Student First Name', 2)
INSERT [absentee].[NotificationTemplateVariables] ([TemplateID], [VariableID], [FieldName], [Description], [ID]) VALUES (1, 2, N'DaysAbsent', N'Days Absent', 3)
INSERT [absentee].[NotificationTemplateVariables] ([TemplateID], [VariableID], [FieldName], [Description], [ID]) VALUES (1, 3, N'AttendanceLink', N'Link for Attendance Trends', 4)
INSERT [absentee].[NotificationTemplateVariables] ([TemplateID], [VariableID], [FieldName], [Description], [ID]) VALUES (2, 0, N'ContactLast', N'Last Name with Salutation', 6)
INSERT [absentee].[NotificationTemplateVariables] ([TemplateID], [VariableID], [FieldName], [Description], [ID]) VALUES (2, 1, N'StudentFirst', N'Student First Name', 7)
INSERT [absentee].[NotificationTemplateVariables] ([TemplateID], [VariableID], [FieldName], [Description], [ID]) VALUES (3, 0, N'ContactLast', N'Last Name with Salutation', 9)
INSERT [absentee].[NotificationTemplateVariables] ([TemplateID], [VariableID], [FieldName], [Description], [ID]) VALUES (3, 1, N'StudentFirst', N'Student First Name', 10)
INSERT [absentee].[NotificationTemplateVariables] ([TemplateID], [VariableID], [FieldName], [Description], [ID]) VALUES (3, 2, N'DaysAbsent', N'Days Absent', 11)
INSERT [absentee].[NotificationTemplateVariables] ([TemplateID], [VariableID], [FieldName], [Description], [ID]) VALUES (4, 0, N'ContactLast', N'Last Name with Salutation', 12)
INSERT [absentee].[NotificationTemplateVariables] ([TemplateID], [VariableID], [FieldName], [Description], [ID]) VALUES (4, 1, N'StudentFirst', N'Student First Name', 13)
INSERT [absentee].[NotificationTemplateVariables] ([TemplateID], [VariableID], [FieldName], [Description], [ID]) VALUES (4, 2, N'DaysAbsent', N'Days Absent', 14)
INSERT [absentee].[NotificationTemplateVariables] ([TemplateID], [VariableID], [FieldName], [Description], [ID]) VALUES (5, 0, N'StudentFirst', N'Student First Name', 15)
INSERT [absentee].[NotificationTemplateVariables] ([TemplateID], [VariableID], [FieldName], [Description], [ID]) VALUES (6, 0, N'ContactLast', N'Last Name with Salutation', 16)
INSERT [absentee].[NotificationTemplateVariables] ([TemplateID], [VariableID], [FieldName], [Description], [ID]) VALUES (6, 1, N'StudentFirst', N'Student First Name', 17)
INSERT [absentee].[NotificationTemplateVariables] ([TemplateID], [VariableID], [FieldName], [Description], [ID]) VALUES (6, 2, N'DaysAbsent', N'Days Absent', 18)
INSERT [absentee].[NotificationTemplateVariables] ([TemplateID], [VariableID], [FieldName], [Description], [ID]) VALUES (7, 0, N'ContactLast', N'Last Name with Salutation', 19)
INSERT [absentee].[NotificationTemplateVariables] ([TemplateID], [VariableID], [FieldName], [Description], [ID]) VALUES (7, 1, N'StudentFirst', N'Student First Name', 20)
INSERT [absentee].[NotificationTemplateVariables] ([TemplateID], [VariableID], [FieldName], [Description], [ID]) VALUES (7, 2, N'DaysAbsent', N'Days Absent', 21)
INSERT [absentee].[NotificationTemplateVariables] ([TemplateID], [VariableID], [FieldName], [Description], [ID]) VALUES (8, 0, N'ContactLast', N'Last Name with Salutation', 22)
INSERT [absentee].[NotificationTemplateVariables] ([TemplateID], [VariableID], [FieldName], [Description], [ID]) VALUES (8, 1, N'StudentFirst', N'Student First Name', 23)
INSERT [absentee].[NotificationTemplateVariables] ([TemplateID], [VariableID], [FieldName], [Description], [ID]) VALUES (9, 0, N'ContactLast', N'Last Name with Salutation', 27)
INSERT [absentee].[NotificationTemplateVariables] ([TemplateID], [VariableID], [FieldName], [Description], [ID]) VALUES (9, 1, N'StudentFirst', N'Student First Name', 28)
INSERT [absentee].[NotificationTemplateVariables] ([TemplateID], [VariableID], [FieldName], [Description], [ID]) VALUES (10, 0, N'ContactLast', N'Last Name with Salutation', 32)
INSERT [absentee].[NotificationTemplateVariables] ([TemplateID], [VariableID], [FieldName], [Description], [ID]) VALUES (10, 1, N'StudentFirst', N'Student First Name', 33)
INSERT [absentee].[NotificationTemplateVariables] ([TemplateID], [VariableID], [FieldName], [Description], [ID]) VALUES (11, 0, N'ContactLast', N'Last Name with Salutation', 36)
INSERT [absentee].[NotificationTemplateVariables] ([TemplateID], [VariableID], [FieldName], [Description], [ID]) VALUES (11, 1, N'StudentFirst', N'Student First Name', 37)
INSERT [absentee].[NotificationTemplateVariables] ([TemplateID], [VariableID], [FieldName], [Description], [ID]) VALUES (11, 2, N'AnticipatedAbsentDays', N'Anticipated Absent Days by End of the School Year', 40)
INSERT [absentee].[NotificationTemplateVariables] ([TemplateID], [VariableID], [FieldName], [Description], [ID]) VALUES (11, 3, N'PeersAbsenceMultipler', N'Times the Number of Absenses to Peers', 41)
SET IDENTITY_INSERT [absentee].[NotificationTemplateVariables] OFF
GO

