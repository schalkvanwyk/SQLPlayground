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

	PRINT '[BlobContainer_BlobDeleted]'

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

CREATE TRIGGER [dbo].[BlobContainer_BlobInserted] --[BlobContainer_BlobUpload]
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
			,(CASE 
				WHEN Z.[file_type] = 'pdf' THEN 'PDF'
				WHEN Z.[file_type] = 'doc' OR Z.[file_type] = 'docx' OR Z.[file_type] = 'dot' OR Z.[file_type] = 'dotx' THEN 'Word'
				WHEN Z.[file_type] = 'xls' OR Z.[file_type] = 'xlsx' OR Z.[file_type] = 'xlt' OR Z.[file_type] = 'xltx' THEN 'Excel'
				WHEN Z.[file_type] = 'ppt' OR Z.[file_type] = 'pptx' OR Z.[file_type] = 'pps' OR Z.[file_type] = 'ppsx' OR Z.[file_type] = 'ppt' OR Z.[file_type] = 'potx' THEN 'PowerPoint'
				WHEN Z.[file_type] = 'txt' THEN 'TEXT'
				ELSE Z.[file_type]
			 END) AS [InferedContentType]
			,IIF([is_directory] = 1, 'Directory|', '') 
			+ IIF([is_offline] = 1,'Offline|', '')
			+ IIF([is_hidden] = 1,'Hidden|', '')
			+ IIF([is_readonly] = 1,'Readonly|', '')
			+ IIF([is_archive] = 1,'Archive|', '')
			+ IIF([is_system] = 1,'System|', '')
			+ IIF([is_temporary] = 1,'Temporary|', '') AS [FileAttributes]
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
		FOR JSON PATH, WITHOUT_ARRAY_WRAPPER) AS [FileMetaData]
		,(SELECT 
			Z.[name] AS [Properties.Name]
			,(CASE 
				WHEN Z.[file_type] = 'pdf' THEN 'PDF'
				WHEN Z.[file_type] = 'doc' OR Z.[file_type] = 'docx' OR Z.[file_type] = 'dot' OR Z.[file_type] = 'dotx' THEN 'Word'
				WHEN Z.[file_type] = 'xls' OR Z.[file_type] = 'xlsx' OR Z.[file_type] = 'xlt' OR Z.[file_type] = 'xltx' THEN 'Excel'
				WHEN Z.[file_type] = 'ppt' OR Z.[file_type] = 'pptx' OR Z.[file_type] = 'pps' OR Z.[file_type] = 'ppsx' OR Z.[file_type] = 'ppt' OR Z.[file_type] = 'potx' THEN 'PowerPoint'
				WHEN Z.[file_type] = 'txt' THEN 'TEXT'
				ELSE Z.[file_type]
			 END) AS [Properties.ContentType]
		FROM inserted AS Z
		WHERE Z.[stream_id] = A.[stream_id]
		FOR JSON PATH, WITHOUT_ARRAY_WRAPPER) AS [InputMetaData]
	FROM inserted AS A
	WHERE A.[is_temporary] = 0
	AND A.[is_system] = 0
	AND A.[is_hidden] = 0
	AND A.[file_type] != 'tmp'

END


GO
ALTER TABLE [dbo].[BlobContainer] ENABLE TRIGGER [BlobContainer_BlobInserted]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[BlobContainer_BlobUpdated]
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
				,(CASE 
					WHEN Z.[file_type] = 'pdf' THEN 'PDF'
					WHEN Z.[file_type] = 'doc' OR Z.[file_type] = 'docx' OR Z.[file_type] = 'dot' OR Z.[file_type] = 'dotx' THEN 'Word'
					WHEN Z.[file_type] = 'xls' OR Z.[file_type] = 'xlsx' OR Z.[file_type] = 'xlt' OR Z.[file_type] = 'xltx' THEN 'Excel'
					WHEN Z.[file_type] = 'ppt' OR Z.[file_type] = 'pptx' OR Z.[file_type] = 'pps' OR Z.[file_type] = 'ppsx' OR Z.[file_type] = 'ppt' OR Z.[file_type] = 'potx' THEN 'PowerPoint'
					WHEN Z.[file_type] = 'txt' THEN 'TEXT'
					ELSE Z.[file_type]
				 END) AS [InferedContentType]
				,IIF([is_directory] = 1, 'Directory|', '') 
				+ IIF([is_offline] = 1,'Offline|', '')
				+ IIF([is_hidden] = 1,'Hidden|', '')
				+ IIF([is_readonly] = 1,'Readonly|', '')
				+ IIF([is_archive] = 1,'Archive|', '')
				+ IIF([is_system] = 1,'System|', '')
				+ IIF([is_temporary] = 1,'Temporary|', '') AS [FileAttributes]
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
			FOR JSON PATH, WITHOUT_ARRAY_WRAPPER) AS [FileMetaData]
			,(SELECT 
				Z.[name] AS [Properties.Name]
				,(CASE 
					WHEN Z.[file_type] = 'pdf' THEN 'PDF'
					WHEN Z.[file_type] = 'doc' OR Z.[file_type] = 'docx' OR Z.[file_type] = 'dot' OR Z.[file_type] = 'dotx' THEN 'Word'
					WHEN Z.[file_type] = 'xls' OR Z.[file_type] = 'xlsx' OR Z.[file_type] = 'xlt' OR Z.[file_type] = 'xltx' THEN 'Excel'
					WHEN Z.[file_type] = 'ppt' OR Z.[file_type] = 'pptx' OR Z.[file_type] = 'pps' OR Z.[file_type] = 'ppsx' OR Z.[file_type] = 'ppt' OR Z.[file_type] = 'potx' THEN 'PowerPoint'
					WHEN Z.[file_type] = 'txt' THEN 'TEXT'
					ELSE Z.[file_type]
				 END) AS [Properties.ContentType]
			FROM inserted AS Z
			WHERE Z.[stream_id] = I.[stream_id]
			FOR JSON PATH, WITHOUT_ARRAY_WRAPPER) AS [InputMetaData]
			,ISNULL(COALESCE(NULLIF(I.[is_hidden], 0), NULLIF(I.[is_system], 0), NULLIF(I.[is_temporary], 0)), 0) AS [Ignore]
			,I.[file_type]
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
	WHERE S.[Ignore] = 0
	AND S.[file_type] != 'tmp'

END


GO
ALTER TABLE [dbo].[BlobContainer] ENABLE TRIGGER [BlobContainer_BlobUpdated]
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
