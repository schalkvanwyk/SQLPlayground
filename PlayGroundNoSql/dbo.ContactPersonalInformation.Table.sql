USE [PlaygroundNoSQL]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ContactPersonalInformation](
	[ContactId] [bigint] IDENTITY(1,1) NOT NULL,
	[ContactKey] [varchar](128) NOT NULL,
	[StateCode] [int] NOT NULL,
	[StatusCode] [int] NOT NULL,
	[Identity] [nvarchar](max) NULL,
	[Demographics] [nvarchar](max) NULL,
	[ModelVersion] [int] NOT NULL,
	[FullName]  AS (json_value([Identity],'$.FullName')),
 CONSTRAINT [PK_ContactPersonalInformation] PRIMARY KEY NONCLUSTERED 
(
	[ContactId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UK_ContactPersonalInformation] UNIQUE CLUSTERED 
(
	[ContactKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ARITHABORT ON
SET CONCAT_NULL_YIELDS_NULL ON
SET QUOTED_IDENTIFIER ON
SET ANSI_NULLS ON
SET ANSI_PADDING ON
SET ANSI_WARNINGS ON
SET NUMERIC_ROUNDABORT OFF

GO
CREATE NONCLUSTERED INDEX [IX_ContactPersonalInformation_FullName] ON [dbo].[ContactPersonalInformation]
(
	[FullName] ASC
)
INCLUDE ( 	[ContactKey],
	[StateCode],
	[StatusCode],
	[Identity],
	[Demographics],
	[ModelVersion]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ContactPersonalInformation] ADD  CONSTRAINT [DF_ContactPersonalInformation_StateCode]  DEFAULT ((1)) FOR [StateCode]
GO
ALTER TABLE [dbo].[ContactPersonalInformation] ADD  CONSTRAINT [DF_ContactPersonalInformation_StatusCode]  DEFAULT ((1001)) FOR [StatusCode]
GO
ALTER TABLE [dbo].[ContactPersonalInformation] ADD  CONSTRAINT [DF_ContactPersonalInformation_ModelVersion]  DEFAULT ((1)) FOR [ModelVersion]
GO
ALTER TABLE [dbo].[ContactPersonalInformation]  WITH CHECK ADD  CONSTRAINT [CK_ContactPersonalInformation_Demographics_IsJson] CHECK  ((isjson([Demographics])>(0)))
GO
ALTER TABLE [dbo].[ContactPersonalInformation] CHECK CONSTRAINT [CK_ContactPersonalInformation_Demographics_IsJson]
GO
ALTER TABLE [dbo].[ContactPersonalInformation]  WITH CHECK ADD  CONSTRAINT [CK_ContactPersonalInformation_Identity_IsJson] CHECK  ((isjson([Identity])>(0)))
GO
ALTER TABLE [dbo].[ContactPersonalInformation] CHECK CONSTRAINT [CK_ContactPersonalInformation_Identity_IsJson]
GO
