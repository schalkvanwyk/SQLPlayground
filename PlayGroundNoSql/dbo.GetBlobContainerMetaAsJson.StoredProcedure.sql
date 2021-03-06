USE [PlaygroundNoSQL]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetBlobContainerMetaAsJson]
AS
SELECT
b.FTContainerKey as PartitionKey
,a.[BlobContainerMetaId] as RowKey
,a.[StreamId]
,a.[StateCode]
,a.[StatusCode]
,a.[ModelVersion]
,JSON_QUERY(a.[FileMetaData]) AS [FileMetaData]
,JSON_QUERY(a.[InputMetaData]) AS [InputMetaData]
,a.[FileName]
,a.[FullPath]
,a.[Name]
,a.[ContentType]
FROM [dbo].[BlobContainerMeta] as a
cross apply [dbo].[FTContainer] as b
where b.FTContainerKey = 'BlobContainer'
for json path,WITHOUT_ARRAY_WRAPPER
GO
