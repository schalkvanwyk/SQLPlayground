USE [PlaygroundNoSQL]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[Contact_Unpacked] AS
	SELECT
		C.[ContactId]
		,C.[ContactKey]
		,C.[StateCode]
		,C.[StatusCode]
		,C.[FullName]
		,C.[LastName]
		,C.[FirstName]
		,C.[Gender]
		,C.[BirthDate]
		,CAST(JSON_VALUE(CC.[EmailAddresses], '$.PrimaryName') AS VARCHAR(50)) AS [PrimaryEmailAddressName]
		,CAST(JSON_VALUE(CC.[EmailAddresses], '$.Personal') AS VARCHAR(256)) AS [PersonalEmailAddress]
		,CAST(JSON_VALUE(CC.[EmailAddresses], '$.Work') AS VARCHAR(256)) AS [WorkEmailAddress]
		,CAST(JSON_VALUE(CC.[PhoneNumbers], '$.PrimaryName') AS VARCHAR(50)) AS [PrimaryPhoneNumberName]
		,CAST(JSON_VALUE(CC.[PhoneNumbers], '$.Mobile') AS VARCHAR(30)) AS [MobilePhoneNumber]
		,CAST(JSON_VALUE(CC.[PhoneNumbers], '$.Home') AS VARCHAR(30)) AS [HomePhoneNumber]
		,CAST(JSON_VALUE(CC.[PhoneNumbers], '$.Work') AS VARCHAR(30)) AS [WorkPhoneNumber]
		,CAST(JSON_VALUE(CC.[SocialHandles], '$.Twitter') AS VARCHAR(256)) AS [TwitterSocialHandle]
		,CAST(JSON_VALUE(CC.[SocialHandles], '$.Facebook') AS VARCHAR(256)) AS [FacebookSocialHandle]
		,C.[Identity]
		,C.[Demographics]
		,CC.[EmailAddresses]
		,CC.[PhoneNumbers]
		,CC.[SocialHandles]
		,CA.[AddressInfo]
	FROM [dbo].[ContactPersonalInformation_Unpacked] AS C
	LEFT JOIN [dbo].[ContactChannels] AS CC
		ON CC.[ContactId] = C.ContactId
	LEFT JOIN [dbo].[ContactAddress] AS CA
		ON CA.[ContactId] = C.[ContactId]


GO
