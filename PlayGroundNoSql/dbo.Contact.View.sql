USE [PlaygroundNoSQL]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[Contact] AS
	SELECT
		C.[ContactId]
		,C.[ContactKey]
		,C.[StateCode]
		,C.[StatusCode]
		,C.[FullName]
		,C.[Identity]
		,C.[Demographics]
		,CC.[EmailAddresses]
		,CC.[PhoneNumbers]
		,CC.[SocialHandles]
		,CA.[AddressInfo]
	FROM [dbo].[ContactPersonalInformation] AS C
	LEFT JOIN [dbo].[ContactChannels] AS CC
		ON CC.[ContactId] = C.ContactId
	LEFT JOIN [dbo].[ContactAddress] AS CA
		ON CA.[ContactId] = C.[ContactId]

GO
