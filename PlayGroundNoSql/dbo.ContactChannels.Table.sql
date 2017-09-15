USE [PlaygroundNoSQL]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ContactChannels](
	[ContactId] [bigint] NOT NULL,
	[ContactKey] [varchar](128) NOT NULL,
	[StateCode] [int] NOT NULL,
	[StatusCode] [int] NOT NULL,
	[EmailAddresses] [nvarchar](max) NULL,
	[PhoneNumbers] [nvarchar](max) NULL,
	[SocialHandles] [nvarchar](max) NULL,
 CONSTRAINT [UK_ContactChannels] UNIQUE CLUSTERED 
(
	[ContactKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
INSERT [dbo].[ContactChannels] ([ContactId], [ContactKey], [StateCode], [StatusCode], [EmailAddresses], [PhoneNumbers], [SocialHandles]) VALUES (1, N'19800802JoeSoap', 1, 1001, N'{"PrimaryName":"Work","Work":"joes@fakework.mail","Personal":"joe.soap@fake.mail"}', N'{"PrimaryName":"Work","Work":"0121234567890","Home":"2100987654321","Mobile":"0123456789"}', N'{"Twitter":"@soapyjoe","Facebook":"joesoap"}')
ALTER TABLE [dbo].[ContactChannels] ADD  CONSTRAINT [PK_ContactChannels] PRIMARY KEY NONCLUSTERED 
(
	[ContactId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ContactChannels] ADD  CONSTRAINT [DF_ContactChannels_StateCode]  DEFAULT ((1)) FOR [StateCode]
GO
ALTER TABLE [dbo].[ContactChannels] ADD  CONSTRAINT [DF_ContactChannelss_StatusCode]  DEFAULT ((1001)) FOR [StatusCode]
GO
ALTER TABLE [dbo].[ContactChannels]  WITH CHECK ADD  CONSTRAINT [CK_ContactChannels_EmailAddressesIsJson] CHECK  ((isjson([EmailAddresses])>(0)))
GO
ALTER TABLE [dbo].[ContactChannels] CHECK CONSTRAINT [CK_ContactChannels_EmailAddressesIsJson]
GO
ALTER TABLE [dbo].[ContactChannels]  WITH CHECK ADD  CONSTRAINT [CK_ContactChannels_PhoneNumbers_IsJson] CHECK  ((isjson([PhoneNumbers])>(0)))
GO
ALTER TABLE [dbo].[ContactChannels] CHECK CONSTRAINT [CK_ContactChannels_PhoneNumbers_IsJson]
GO
ALTER TABLE [dbo].[ContactChannels]  WITH CHECK ADD  CONSTRAINT [CK_ContactChannels_SocialHandles_IsJson] CHECK  ((isjson([SocialHandles])>(0)))
GO
ALTER TABLE [dbo].[ContactChannels] CHECK CONSTRAINT [CK_ContactChannels_SocialHandles_IsJson]
GO
