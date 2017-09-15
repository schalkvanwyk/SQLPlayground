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
 CONSTRAINT [UK_ContactAddress] UNIQUE CLUSTERED 
(
	[ContactAddressKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET IDENTITY_INSERT [dbo].[ContactAddress] ON 

INSERT [dbo].[ContactAddress] ([ContactAddressId], [ContactAddressKey], [ContactId], [ContactKey], [StateCode], [StatusCode], [AddressInfo]) VALUES (1, N'19800802JoeSoapPostalAddress', 1, N'19800802JoeSoap', 1, 1001, N'{"Name":"Postal Address","Line1":"14 Edward Place","Line2":"The Greens","Line3":"1 Some Street","Suburb":"First Suburb","Country":"Far Far Away","PostalCode":"1234567890"}')
SET IDENTITY_INSERT [dbo].[ContactAddress] OFF
ALTER TABLE [dbo].[ContactAddress] ADD  CONSTRAINT [PK_ContactAddress] PRIMARY KEY NONCLUSTERED 
(
	[ContactAddressId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
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
