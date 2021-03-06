USE [PlaygroundNoSQL]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FTContainer](
	[FTContainerId] [bigint] IDENTITY(1,1) NOT NULL,
	[FTContainerKey] [varchar](128) NOT NULL,
	[FTMetaContainerKey] [varchar](128) NULL,
	[StateCode] [int] NOT NULL,
	[StatusCode] [int] NOT NULL,
	[ModelVersion] [int] NOT NULL,
	[SharedMetas] [nvarchar](max) NULL,
	[SharedProperties] [nvarchar](max) NULL,
	[SharedSettings] [nvarchar](max) NULL,
 CONSTRAINT [PK_FTContainer] PRIMARY KEY NONCLUSTERED 
(
	[FTContainerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [CX_FTContainer] UNIQUE CLUSTERED 
(
	[FTContainerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
ALTER TABLE [dbo].[FTContainer] ADD  CONSTRAINT [DF_FTContainer_StateCode]  DEFAULT ((1)) FOR [StateCode]
GO
ALTER TABLE [dbo].[FTContainer] ADD  CONSTRAINT [DF_FTContainer_StatusCode]  DEFAULT ((1001)) FOR [StatusCode]
GO
ALTER TABLE [dbo].[FTContainer] ADD  CONSTRAINT [DF_FTContainer_ModelVersion]  DEFAULT ((1)) FOR [ModelVersion]
GO
ALTER TABLE [dbo].[FTContainer]  WITH CHECK ADD  CONSTRAINT [CK_FTContainer_Key] CHECK  ((lower([FTContainerKey])=([FTContainerKey]) collate Latin1_General_BIN2))
GO
ALTER TABLE [dbo].[FTContainer] CHECK CONSTRAINT [CK_FTContainer_Key]
GO
ALTER TABLE [dbo].[FTContainer]  WITH CHECK ADD  CONSTRAINT [CK_FTContainer_SharedProperties] CHECK  ((isjson([SharedProperties])>(0)))
GO
ALTER TABLE [dbo].[FTContainer] CHECK CONSTRAINT [CK_FTContainer_SharedProperties]
GO
ALTER TABLE [dbo].[FTContainer]  WITH CHECK ADD  CONSTRAINT [CK_FTContainer_SharedSettings] CHECK  ((isjson([SharedSettings])>(0)))
GO
ALTER TABLE [dbo].[FTContainer] CHECK CONSTRAINT [CK_FTContainer_SharedSettings]
GO
ALTER TABLE [dbo].[FTContainer]  WITH CHECK ADD  CONSTRAINT [CK_FTContainer_ShareMetas] CHECK  ((isjson([SharedMetas])>(0)))
GO
ALTER TABLE [dbo].[FTContainer] CHECK CONSTRAINT [CK_FTContainer_ShareMetas]
GO
