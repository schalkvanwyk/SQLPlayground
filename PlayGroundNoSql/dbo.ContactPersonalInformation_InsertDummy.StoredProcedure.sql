USE [PlaygroundNoSQL]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ContactPersonalInformation_InsertDummy]
AS

DECLARE @JsonResult AS NVARCHAR(MAX)

SET @JsonResult =
(
SELECT 
'Soap' AS [Identity.LastName]
,'Joe' AS [Identity.FirstName]
,'Joe Soap' AS [Identity.FullName]
,'1980-08-02' AS [Demographics.BirthDate]
,'Male' AS [Demographics.Gender]
FOR JSON PATH
)

PRINT @JsonResult

INSERT INTO [dbo].[ContactPersonalInformation]
(
	[ContactKey]
	,[Identity]
	,[Demographics]
)
SELECT 
	CONVERT(VARCHAR(8), [ContactKey.BirthDate], 112) + LTRIM(RTRIM(REPLACE([ContactKey.FullName], ' ', ''))) AS [ContactKey]
	,[Identity]
	,[Demographics]
FROM OPENJSON(@JsonResult)
	WITH
	(
		[ContactKey.FullName] VARCHAR(128) N'strict $.Identity.FullName',
		[ContactKey.BirthDate] DATE N'strict $.Demographics.BirthDate',
		[Identity] NVARCHAR(MAX) AS JSON,
		[Demographics] NVARCHAR(MAX) AS JSON
	)
GO
