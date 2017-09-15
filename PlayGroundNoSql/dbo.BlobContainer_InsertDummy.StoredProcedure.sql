USE [PlaygroundNoSQL]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BlobContainer_InsertDummy]
	@FileName VARCHAR(255) = 'InsertedTextFile.txt'
	,@Data VARBINARY(MAX) = 0x
AS

--INSERT INTO [dbo].[BlobContainer] SELECT * FROM OPENROWSET(BULK 'd:\test.txt.txt', SINGLE_BLOB)

INSERT INTO dbo.[BlobContainer](name, file_stream)
SELECT @FileName, @Data;
GO
