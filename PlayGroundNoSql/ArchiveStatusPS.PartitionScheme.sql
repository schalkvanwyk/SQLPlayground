USE [PlaygroundNoSQL]
GO
CREATE PARTITION SCHEME [ArchiveStatusPS] AS PARTITION [ArchiveStatus] TO ([PRIMARY], [Archive])
GO
