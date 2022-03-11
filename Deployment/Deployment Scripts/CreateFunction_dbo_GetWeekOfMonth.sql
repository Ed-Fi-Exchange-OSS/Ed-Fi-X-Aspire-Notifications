/****** Object:  UserDefinedFunction [dbo].[GetWeekOfMonth]    Script Date: 12/15/2020 5:33:53 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


/*=================================================================================================================
	Author:			Doris Ma
	Create date:	2019-10-16

	Description:	Get week number in the month

	COMMENTS:
	2020-3-16		DMa		original function created.
==================================================================================================================*/

CREATE FUNCTION [dbo].[GetWeekOfMonth]
(
	@date AS DATETIME
)
RETURNS INT

AS

BEGIN
	IF @date IS NULL
		SET @date = GETDATE()

	DECLARE @weekOfMonth INT
	SET @weekOfMonth = (DATEPART(WEEK, @date)- DATEPART(WEEK,DATEADD(m, DATEDIFF(m, 0, @date), 0))) + 1
	
	RETURN @weekOfMonth
END
GO

