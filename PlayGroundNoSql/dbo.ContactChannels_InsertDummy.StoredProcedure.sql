USE [PlaygroundNoSQL]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[ContactChannels_InsertDummy]
AS

DECLARE @JsonResult AS NVARCHAR(MAX)

SET @JsonResult =
(
SELECT 
'19800802JoeSoap' AS [ContactKey]
,'Work' AS [EmailAddress.PrimaryName]
,'joes@fakework.mail' AS [EmailAddress.Work]
,'joe.soap@fake.mail' AS [EmailAddress.Personal]
,'Work' AS [PhoneNumber.PrimaryName]
,'0121234567890' AS [PhoneNumber.Work]
,'2100987654321' AS [PhoneNumber.Home]
,'0123456789' AS [PhoneNumber.Mobile]
,'@soapyjoe' AS [SocialHandle.Twitter]
,'joesoap' AS [SocialHandle.Facebook]
FOR JSON PATH
)

PRINT @JsonResult

INSERT INTO [dbo].[ContactChannels]
(
	[ContactId]
	,[ContactKey]
	,[EmailAddresses]
	,[PhoneNumbers]
	,[SocialHandles]
)
SELECT 
	C.[ContactId]
	,C.[ContactKey]
	,[EmailAddresses]
	,[PhoneNumbers]
	,[SocialHandles]
FROM OPENJSON(@JsonResult)
	WITH
	(
		[ContactKey] VARCHAR(128),
		[EmailAddresses] NVARCHAR(MAX) '$.EmailAddress' AS JSON,
		[PhoneNumbers] NVARCHAR(MAX) '$.PhoneNumber' AS JSON,
		[SocialHandles] NVARCHAR(MAX) '$.SocialHandle' AS JSON
	) AS A
JOIN [dbo].[ContactPersonalInformation] AS C
	ON C.[ContactKey] = A.[ContactKey]


GO
