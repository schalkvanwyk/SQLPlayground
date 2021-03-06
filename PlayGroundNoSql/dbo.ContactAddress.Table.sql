USE [PlaygroundNoSQL]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ContactAddress](
	[ContactAddressId] [bigint] IDENTITY(1,1) NOT NULL,
	[ContactAddressKey] [varchar](128) NOT NULL,
	[ContactId] [bigint] NOT NULL,
	[ContactKey] [varchar](128) NOT NULL,
	[StateCode] [int] NOT NULL,
	[StatusCode] [int] NOT NULL,
	[AddressInfo] [nvarchar](max) NULL,
 CONSTRAINT [PK_ContactAddress] PRIMARY KEY NONCLUSTERED 
(
	[ContactAddressId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UK_ContactAddress] UNIQUE CLUSTERED 
(
	[ContactAddressKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING ON

GO
CREATE NONCLUSTERED INDEX [IX_ContactAddress_ContactId] ON [dbo].[ContactAddress]
(
	[ContactId] ASC
)
INCLUDE ( 	[ContactAddressId],
	[ContactAddressKey],
	[StateCode],
	[StatusCode],
	[AddressInfo]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ContactAddress] ADD  CONSTRAINT [DF_ContactAddress_StateCode]  DEFAULT ((1)) FOR [StateCode]
GO
ALTER TABLE [dbo].[ContactAddress] ADD  CONSTRAINT [DF_ContactAddress_StatusCode]  DEFAULT ((1001)) FOR [StatusCode]
GO
ALTER TABLE [dbo].[ContactAddress]  WITH CHECK ADD  CONSTRAINT [FK_ContactAddress_ContactPersonalInformation] FOREIGN KEY([ContactId])
REFERENCES [dbo].[ContactPersonalInformation] ([ContactId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ContactAddress] CHECK CONSTRAINT [FK_ContactAddress_ContactPersonalInformation]
GO
ALTER TABLE [dbo].[ContactAddress]  WITH CHECK ADD  CONSTRAINT [CK_ContactAddress_AddressInfoIsJson] CHECK  ((isjson([AddressInfo])>(0)))
GO
ALTER TABLE [dbo].[ContactAddress] CHECK CONSTRAINT [CK_ContactAddress_AddressInfoIsJson]
GO
