USE [PlaygroundNoSQL]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[ContactPersonalInformation_Unpacked] WITH SCHEMABINDING AS
	SELECT
		C.[ContactId]
		,C.[ContactKey]
		,C.[StateCode]
		,C.[StatusCode]
		,C.[FullName]
		,CAST(JSON_VALUE(C.[Identity], '$.LastName') AS NVARCHAR(128)) AS [LastName]
		,CAST(JSON_VALUE(C.[Identity], '$.FirstName') AS NVARCHAR(64)) AS [FirstName]
		,CAST(JSON_VALUE(C.[Demographics], '$.Gender') AS NVARCHAR(32)) AS [Gender]
		,CONVERT(DATE, JSON_VALUE(C.[Demographics], '$.BirthDate'), 111) AS [BirthDate]
		,C.[Identity]
		,C.[Demographics]
	FROM [dbo].[ContactPersonalInformation] AS C


GO
