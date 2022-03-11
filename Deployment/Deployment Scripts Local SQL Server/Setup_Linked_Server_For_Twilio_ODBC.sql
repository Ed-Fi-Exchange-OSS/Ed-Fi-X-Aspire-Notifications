USE [master]
GO

/****** Object:  LinkedServer [TWILIO_DB]    Script Date: 10/5/2021 11:08:58 AM ******/
EXEC master.dbo.sp_addlinkedserver @server = N'TWILIO_DB', @srvproduct=N'', @provider=N'SQLNCLI11', @datasrc=N'localhost, 1999', @catalog=N'REPLACE_WITH_ODBC_NAME'
 /* For security reasons the linked server remote logins password is changed with ######## */
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'TWILIO_DB',@useself=N'False',@locallogin=NULL,@rmtuser=N'REPLACE_WITH_USERNAME',@rmtpassword='REPLACE_WITH_PASSWORD'
GO

EXEC master.dbo.sp_serveroption @server=N'TWILIO_DB', @optname=N'collation compatible', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'TWILIO_DB', @optname=N'data access', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'TWILIO_DB', @optname=N'dist', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'TWILIO_DB', @optname=N'pub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'TWILIO_DB', @optname=N'rpc', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'TWILIO_DB', @optname=N'rpc out', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'TWILIO_DB', @optname=N'sub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'TWILIO_DB', @optname=N'connect timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'TWILIO_DB', @optname=N'collation name', @optvalue=NULL
GO

EXEC master.dbo.sp_serveroption @server=N'TWILIO_DB', @optname=N'lazy schema validation', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'TWILIO_DB', @optname=N'query timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'TWILIO_DB', @optname=N'use remote collation', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'TWILIO_DB', @optname=N'remote proc transaction promotion', @optvalue=N'true'
GO


