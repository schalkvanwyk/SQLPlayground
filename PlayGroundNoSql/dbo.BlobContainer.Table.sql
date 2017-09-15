USE [PlaygroundNoSQL]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ARITHABORT ON
GO
CREATE TABLE [dbo].[BlobContainer] AS FILETABLE ON [PRIMARY] FILESTREAM_ON [PRIMARYFILESTREAM]
WITH
(
FILETABLE_DIRECTORY = N'ContainedBlobs', FILETABLE_COLLATE_FILENAME = Latin1_General_CI_AS
)

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[BlobContainer_BlobDelete]
	ON  [dbo].[BlobContainer]
	 -- INSTEAD OF NOT ALLOWED ON TABLE WITH FILESTREAM
	FOR DELETE
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

   UPDATE T SET
		T.[StreamId] = NULL
	FROM [dbo].[BlobContainerMeta] AS T
	WHERE NOT EXISTS(SELECT TOP (1) 1 FROM [dbo].[BlobContainer] AS Z WHERE Z.[stream_id] = T.[StreamId])

END



GO
ALTER TABLE [dbo].[BlobContainer] DISABLE TRIGGER [BlobContainer_BlobDelete]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[BlobContainer_BlobDeleted]
   ON  [dbo].[BlobContainer]
   AFTER DELETE
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    UPDATE T SET
		T.[StreamId] = NULL
	FROM [dbo].[BlobContainerMeta] AS T
	JOIN deleted AS S
		ON S.[stream_id] = T.[StreamId]

END


GO
ALTER TABLE [dbo].[BlobContainer] DISABLE TRIGGER [BlobContainer_BlobDeleted]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[BlobContainer_BlobInsert] --[BlobContainer_BlobUpload]
   ON  [dbo].[BlobContainer]
   AFTER INSERT--,UPDATE
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	/*
    UPDATE T SET
		T.[FileMetaData] = NULL
	FROM [dbo].[BlobContainerMeta] AS T
	JOIN inserted AS I
		ON I.[stream_id] = T.[StreamId]
		--JSON_MODIFY
	*/
	INSERT INTO [dbo].[BlobContainerMeta]
	(
		[StreamId]
		,[FileMetaData]
		,[InputMetaData]
	)
	SELECT
		A.[stream_id] AS [StreamId]
		,(SELECT 
			Z.[name] AS [Name]
			,FileTableRootPath() + Z.[file_stream].GetFileNamespacePath() AS [FullPath]
			,Z.[name]
			,Z.[path_locator]
			,Z.[parent_path_locator]
			,Z.[file_type]
			,Z.[cached_file_size]
			,Z.[creation_time]
			,Z.[last_write_time]
			,Z.[last_access_time]
			,Z.[is_directory]
			,Z.[is_offline]
			,Z.[is_hidden]
			,Z.[is_readonly]
			,Z.[is_archive]
			,Z.[is_system]
			,Z.[is_temporary]
		FROM inserted AS Z
		WHERE Z.[stream_id] = A.[stream_id]
		FOR JSON AUTO, WITHOUT_ARRAY_WRAPPER) AS [FileMetaData]
		,(SELECT 
			Z.[name] AS [Name]
		FROM inserted AS Z
		WHERE Z.[stream_id] = A.[stream_id]
		FOR JSON AUTO, WITHOUT_ARRAY_WRAPPER) AS [InputMetaData]
	FROM inserted AS A

END


GO
ALTER TABLE [dbo].[BlobContainer] ENABLE TRIGGER [BlobContainer_BlobInsert]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[BlobContainer_BlobUpdate]
   ON  [dbo].[BlobContainer]
   AFTER UPDATE
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	;WITH currentInserted AS
	(
		SELECT
			I.[stream_id] AS [StreamId]
			,(SELECT 
				Z.[name] AS [Name]
				,FileTableRootPath() + Z.[file_stream].GetFileNamespacePath() AS [FullPath]
				,Z.[name]
				,Z.[path_locator]
				,Z.[parent_path_locator]
				,Z.[file_type]
				,Z.[cached_file_size]
				,Z.[creation_time]
				,Z.[last_write_time]
				,Z.[last_access_time]
				,Z.[is_directory]
				,Z.[is_offline]
				,Z.[is_hidden]
				,Z.[is_readonly]
				,Z.[is_archive]
				,Z.[is_system]
				,Z.[is_temporary]
			FROM inserted AS Z
			WHERE Z.[stream_id] = I.[stream_id]
			FOR JSON AUTO, WITHOUT_ARRAY_WRAPPER) AS [FileMetaData]
			,(SELECT 
				Z.[name] AS [Name]
			FROM inserted AS Z
			WHERE Z.[stream_id] = I.[stream_id]
			FOR JSON AUTO, WITHOUT_ARRAY_WRAPPER) AS [InputMetaData]
		FROM inserted AS I
		JOIN deleted AS D
			ON D.[stream_id] = I.[stream_id]
	)
    UPDATE T SET
		T.[FileMetaData] = S.FileMetaData
		,T.[InputMetaData] = S.InputMetaData
	FROM [dbo].[BlobContainerMeta] AS T
	JOIN currentInserted AS S
		ON S.[StreamId] = T.[StreamId]

END


GO
ALTER TABLE [dbo].[BlobContainer] ENABLE TRIGGER [BlobContainer_BlobUpdate]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[BlobContainer_BlobUpload]
   ON  [dbo].[BlobContainer]
   AFTER INSERT--,UPDATE
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	/*
    UPDATE T SET
		T.[FileMetaData] = NULL
	FROM [dbo].[BlobContainerMeta] AS T
	JOIN inserted AS I
		ON I.[stream_id] = T.[StreamId]
		--JSON_MODIFY
	*/
	INSERT INTO [dbo].[BlobContainerMeta]
	(
		[StreamId]
		,[FileMetaData]
		,[InputMetaData]
	)
	SELECT
		A.[stream_id] AS [StreamId]
		,(SELECT 
			Z.[name] AS [Name]
			,FileTableRootPath() + Z.[file_stream].GetFileNamespacePath() AS [FullPath]
			,Z.[name]
			,Z.[path_locator]
			,Z.[parent_path_locator]
			,Z.[file_type]
			,Z.[cached_file_size]
			,Z.[creation_time]
			,Z.[last_write_time]
			,Z.[last_access_time]
			,Z.[is_directory]
			,Z.[is_offline]
			,Z.[is_hidden]
			,Z.[is_readonly]
			,Z.[is_archive]
			,Z.[is_system]
			,Z.[is_temporary]
		FROM inserted AS Z
		WHERE Z.[stream_id] = A.[stream_id]
		FOR JSON AUTO, WITHOUT_ARRAY_WRAPPER) AS [FileMetaData]
		,(SELECT 
			Z.[name] AS [Name]
		FROM inserted AS Z
		WHERE Z.[stream_id] = A.[stream_id]
		FOR JSON AUTO, WITHOUT_ARRAY_WRAPPER) AS [InputMetaData]
	FROM inserted AS A

END


GO
ALTER TABLE [dbo].[BlobContainer] DISABLE TRIGGER [BlobContainer_BlobUpload]
GO
