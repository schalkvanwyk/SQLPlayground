USE [PlaygroundNoSQL]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BlobContainerMeta](
	[BlobContainerMetaId] [bigint] IDENTITY(1,1) NOT NULL,
	[StreamId] [uniqueidentifier] NULL,
	[StateCode] [int] NOT NULL,
	[StatusCode] [int] NOT NULL,
	[ModelVersion] [int] NOT NULL,
	[FileMetaData] [nvarchar](max) NULL,
	[InputMetaData] [nvarchar](max) NULL,
	[FileName]  AS (json_value([FileMetaData],'$.Name')) PERSISTED,
	[FullPath]  AS (json_value([FileMetaData],'$.FullPath')) PERSISTED,
	[Name]  AS (json_value([InputMetaData],'$.Properties.Name')),
	[ContentType]  AS (json_value([InputMetaData],'$.Properties.ContentType')),
 CONSTRAINT [PK_BlobContainerMeta] PRIMARY KEY CLUSTERED 
(
	[BlobContainerMetaId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
ALTER TABLE [dbo].[BlobContainerMeta] ADD  CONSTRAINT [DF_BlobContainerMeta_StateCode]  DEFAULT ((1)) FOR [StateCode]
GO
ALTER TABLE [dbo].[BlobContainerMeta] ADD  CONSTRAINT [DF_BlobContainerMeta_StatusCode]  DEFAULT ((1001)) FOR [StatusCode]
GO
ALTER TABLE [dbo].[BlobContainerMeta] ADD  CONSTRAINT [DF_BlobContainerMeta_ModelVersion]  DEFAULT ((1)) FOR [ModelVersion]
GO
ALTER TABLE [dbo].[BlobContainerMeta]  WITH CHECK ADD  CONSTRAINT [FK_BlobContainerMeta_BlobContainer] FOREIGN KEY([StreamId])
REFERENCES [dbo].[BlobContainer] ([stream_id])
ON DELETE SET DEFAULT
GO
ALTER TABLE [dbo].[BlobContainerMeta] CHECK CONSTRAINT [FK_BlobContainerMeta_BlobContainer]
GO
ALTER TABLE [dbo].[BlobContainerMeta]  WITH NOCHECK ADD  CONSTRAINT [CK_BlobContainerMeta_FileMetaDataIsJson] CHECK  ((isjson([FileMetaData])>(0)))
GO
ALTER TABLE [dbo].[BlobContainerMeta] CHECK CONSTRAINT [CK_BlobContainerMeta_FileMetaDataIsJson]
GO
ALTER TABLE [dbo].[BlobContainerMeta]  WITH CHECK ADD  CONSTRAINT [CK_BlobContainerMeta_InputMetaDataIsJson] CHECK  ((isjson([InputMetaData])>(0)))
GO
ALTER TABLE [dbo].[BlobContainerMeta] CHECK CONSTRAINT [CK_BlobContainerMeta_InputMetaDataIsJson]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[BlobContainerMeta_Deleting]
   ON  [dbo].[BlobContainerMeta] 
   INSTEAD OF DELETE
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	UPDATE target SET 
		  [StateCode] = 0
		  ,[StatusCode] = 10000
	FROM [dbo].[BlobContainerMeta] AS target
	JOIN deleted AS source
		ON source.[BlobContainerMetaId] = target.[BlobContainerMetaId]
		AND NOT EXISTS(SELECT TOP (1) 1 FROM inserted AS Z WHERE Z.[BlobContainerMetaId] = source.[BlobContainerMetaId])
	WHERE target.[StateCode] != 0
	AND target.[StatusCode] != 10000

END


GO
ALTER TABLE [dbo].[BlobContainerMeta] ENABLE TRIGGER [BlobContainerMeta_Deleting]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[BlobContainerMeta_StreamDeleted]
   ON  [dbo].[BlobContainerMeta] 
   AFTER UPDATE
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	UPDATE target SET 
		  [StateCode] = 0
		  ,[StatusCode] = 10000
	FROM [dbo].[BlobContainerMeta] AS target
	JOIN deleted AS source
		ON source.[BlobContainerMetaId] = target.[BlobContainerMetaId]
		AND NOT EXISTS(SELECT TOP (1) 1 FROM inserted AS Z WHERE Z.[BlobContainerMetaId] = source.[BlobContainerMetaId] AND Z.[StreamId] = source.[StreamId])
	WHERE target.[StreamId] IS NULL

END


GO
ALTER TABLE [dbo].[BlobContainerMeta] ENABLE TRIGGER [BlobContainerMeta_StreamDeleted]
GO
