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
 CONSTRAINT [PK_ContactChannels] PRIMARY KEY NONCLUSTERED 
(
	[ContactId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UK_ContactChannels] UNIQUE CLUSTERED 
(
	[ContactKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING ON

GO
CREATE NONCLUSTERED COLUMNSTORE INDEX [IX_ContactChannels] ON [dbo].[ContactChannels]
(
	[ContactKey]
)WITH (DROP_EXISTING = OFF, COMPRESSION_DELAY = 0, DATA_COMPRESSION = COLUMNSTORE) ON [PRIMARY]
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
