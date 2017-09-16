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
SET IDENTITY_INSERT [dbo].[BlobContainerMeta] ON 

INSERT [dbo].[BlobContainerMeta] ([BlobContainerMetaId], [StreamId], [StateCode], [StatusCode], [ModelVersion], [FileMetaData], [InputMetaData]) VALUES (2, NULL, 0, 10000, 1, N'{"Name":"New Text Document.zip","FullPath":"\\\\PLANET9\\SQLXPRS2016\\PlaygroundNoSQLFS\\ContainedBlobs\\New Text Document.zip","InferedContentType":"zip","FileAttributes":"Archive|","name":"New Text Document.zip","path_locator":"\/210707590489202.171866243947043.2214457055\/","file_type":"zip","cached_file_size":0,"creation_time":"2017-09-16T22:11:48.0765525+02:00","last_write_time":"2017-09-16T22:11:48.3734912+02:00","last_access_time":"2017-09-16T22:11:48.3734912+02:00","is_directory":false,"is_offline":false,"is_hidden":false,"is_readonly":false,"is_archive":true,"is_system":false,"is_temporary":false}', N'{"Properties":{"Name":"New Text Document.zip","ContentType":"zip"}}')
INSERT [dbo].[BlobContainerMeta] ([BlobContainerMetaId], [StreamId], [StateCode], [StatusCode], [ModelVersion], [FileMetaData], [InputMetaData]) VALUES (4, NULL, 0, 10000, 1, N'{"Name":"New Text Document.zip","FullPath":"\\\\PLANET9\\SQLXPRS2016\\PlaygroundNoSQLFS\\ContainedBlobs\\New Text Document.zip","InferedContentType":"zip","FileAttributes":"Archive|","name":"New Text Document.zip","path_locator":"\/193688544444820.83874836857402.3052822628\/","file_type":"zip","cached_file_size":140,"creation_time":"2017-09-16T22:11:58.5766102+02:00","last_write_time":"2017-09-16T22:11:58.7953797+02:00","last_access_time":"2017-09-16T22:11:58.7953797+02:00","is_directory":false,"is_offline":false,"is_hidden":false,"is_readonly":false,"is_archive":true,"is_system":false,"is_temporary":false}', N'{"Properties":{"Name":"New Text Document.zip","ContentType":"zip"}}')
INSERT [dbo].[BlobContainerMeta] ([BlobContainerMetaId], [StreamId], [StateCode], [StatusCode], [ModelVersion], [FileMetaData], [InputMetaData]) VALUES (6, NULL, 0, 10000, 1, N'{"Name":"New Text Document.txt","FullPath":"\\\\PLANET9\\SQLXPRS2016\\PlaygroundNoSQLFS\\ContainedBlobs\\New Text Document.txt","InferedContentType":"TEXT","FileAttributes":"Archive|","name":"New Text Document.txt","path_locator":"\/172516517209614.52002374303505.1836517911\/","file_type":"txt","cached_file_size":0,"creation_time":"2017-09-16T22:12:51.6908511+02:00","last_write_time":"2017-09-16T22:12:51.8472691+02:00","last_access_time":"2017-09-16T22:16:57.2583331+02:00","is_directory":false,"is_offline":false,"is_hidden":false,"is_readonly":false,"is_archive":true,"is_system":false,"is_temporary":false}', N'{"Properties":{"Name":"New Text Document.txt","ContentType":"TEXT"}}')
SET IDENTITY_INSERT [dbo].[BlobContainerMeta] OFF
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
