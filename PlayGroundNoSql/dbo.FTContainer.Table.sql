USE [PlaygroundNoSQL]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FTContainer](
	[FTContainerId] [bigint] IDENTITY(1,1) NOT NULL,
	[FTContainerKey] [varchar](128) NOT NULL,
	[SharedMetas] [nvarchar](max) NULL,
	[SharedProperties] [nvarchar](max) NULL,
	[SharedSettings] [nvarchar](max) NULL,
 CONSTRAINT [CX_FTContainer] UNIQUE CLUSTERED 
(
	[FTContainerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET IDENTITY_INSERT [dbo].[FTContainer] ON 

INSERT [dbo].[FTContainer] ([FTContainerId], [FTContainerKey], [SharedMetas], [SharedProperties], [SharedSettings]) VALUES (1, N'sysglobal', NULL, N'[{"Properties":{"ContentType":"application\/octet-stream"}}]', N'[{"Settings":{"AzCopy":{"ExePath":"%ProgramFiles(x86)%\\Microsoft SDKs\\Azure\\AzCopy\\AzCopy.exe","DestinationAccount":"http:\/\/127.0.0.1:10000\/devstoreaccount1\/","DestinationKey":"Eby8vdM02xNOcqFlqUwJPLlmEtlCDXJ1OUzFT50uSRZ6IFsuFq2UVErCz4I6tq\/K1SZFPTOtr\/KBHBeksoGMGw==","CmdTemplate":"%AzCopy% \/Source:%Source% \/Dest:%Destination% \/DestKey:%DestinationKey% \/destType:blob \/S \/XO \/A \/IA:C"}}}]')
INSERT [dbo].[FTContainer] ([FTContainerId], [FTContainerKey], [SharedMetas], [SharedProperties], [SharedSettings]) VALUES (2, N'blobcontainer', NULL, NULL, NULL)
SET IDENTITY_INSERT [dbo].[FTContainer] OFF
ALTER TABLE [dbo].[FTContainer] ADD  CONSTRAINT [PK_FTContainer] PRIMARY KEY NONCLUSTERED 
(
	[FTContainerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
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
