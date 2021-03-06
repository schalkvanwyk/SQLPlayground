USE [Playground]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StoreAccount](
	[StoreAccountId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](120) NOT NULL,
	[DisplayName] [nvarchar](120) NOT NULL,
	[StateCode] [int] NOT NULL,
	[StatusCode] [int] NOT NULL,
	[BrandId] [int] NOT NULL,
 CONSTRAINT [PK_StoreAccount] PRIMARY KEY NONCLUSTERED 
(
	[StoreAccountId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
ALTER TABLE [dbo].[StoreAccount] ADD  CONSTRAINT [DF_StoreAccount_StateCode]  DEFAULT ((1)) FOR [StateCode]
GO
ALTER TABLE [dbo].[StoreAccount] ADD  CONSTRAINT [DF_StoreAccount_StatusCode]  DEFAULT ((1000001)) FOR [StatusCode]
GO
