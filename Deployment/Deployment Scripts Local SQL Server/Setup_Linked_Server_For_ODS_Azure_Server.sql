USE [master]
GO

/****** Object:  LinkedServer [EDFI_PRODUCTION]    Script Date: 10/5/2021 11:03:57 AM ******/
EXEC master.dbo.sp_addlinkedserver @server = N'EDFI_PRODUCTION', @srvproduct=N'', @provider=N'SQLNCLI', @datasrc=N'REPLACE_WITH_AZURE_SERVER_NAME', @catalog=N'EdFi_Ods_Production'
 /* For security reasons the linked server remote logins password is changed with ######## */
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'EDFI_PRODUCTION',@useself=N'False',@locallogin=NULL,@rmtuser=N'REPLACE_WITH_USER_NAME',@rmtpassword='REPLACE_WITH_PASSWORD'
GO

EXEC master.dbo.sp_serveroption @server=N'EDFI_PRODUCTION', @optname=N'collation compatible', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'EDFI_PRODUCTION', @optname=N'data access', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'EDFI_PRODUCTION', @optname=N'dist', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'EDFI_PRODUCTION', @optname=N'pub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'EDFI_PRODUCTION', @optname=N'rpc', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'EDFI_PRODUCTION', @optname=N'rpc out', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'EDFI_PRODUCTION', @optname=N'sub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'EDFI_PRODUCTION', @optname=N'connect timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'EDFI_PRODUCTION', @optname=N'collation name', @optvalue=NULL
GO

EXEC master.dbo.sp_serveroption @server=N'EDFI_PRODUCTION', @optname=N'lazy schema validation', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'EDFI_PRODUCTION', @optname=N'query timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'EDFI_PRODUCTION', @optname=N'use remote collation', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'EDFI_PRODUCTION', @optname=N'remote proc transaction promotion', @optvalue=N'true'
GO


