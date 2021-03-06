USE [PlaygroundNoSQL]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[ContactAddress_InsertDummy]
AS

DECLARE @JsonResult AS NVARCHAR(MAX)

SET @JsonResult =
(
SELECT 
'19800802JoeSoap' AS [ContactKey]
,'Postal Address' AS [Address.Name]
,'14 Edward Place' AS [Address.Line1]
,'The Greens' AS [Address.Line2]
,'1 Some Street' AS [Address.Line3]
,'First Suburb' AS [Address.Suburb]
,'Far Far Away' AS [Address.Country]
,'1234567890' AS [Address.PostalCode]
FOR JSON PATH
)

PRINT @JsonResult

INSERT INTO [dbo].[ContactAddress]
(
	[ContactAddressKey]
	,[ContactId]
	,[ContactKey]
	,[AddressInfo]
)
SELECT 
	C.[ContactKey] + LTRIM(RTRIM(REPLACE([Address.Name], ' ', ''))) AS [ContactAddressKey]
	,C.[ContactId]
	,C.[ContactKey]
	,[Address]
FROM OPENJSON(@JsonResult)
	WITH
	(
		[ContactKey] VARCHAR(128),
		[Address.Name] VARCHAR(64) 'strict $.Address.Name',
		[Address] NVARCHAR(MAX) AS JSON
	) AS A
JOIN [dbo].[ContactPersonalInformation] AS C
	ON C.[ContactKey] = A.[ContactKey]

GO
