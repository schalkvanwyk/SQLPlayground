USE [PlaygroundNoSQL]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CREATEPARTITION] AS

CREATE PARTITION FUNCTION ArchiveStatusPF (int)  
    AS RANGE LEFT FOR VALUES (10001) ;  

CREATE PARTITION SCHEME ArchiveStatusPS
    AS PARTITION ArchiveStatusPF 
    TO ([PRIMARY], Archive) ;  

CREATE TABLE [dbo].[ContactPersonalInformation_Archive](
	[ContactId] [bigint] NOT NULL PRIMARY KEY,
	[ContactKey] [varchar](128) NOT NULL,
	[StateCode] [int] NOT NULL,
	[StatusCode] [int] NOT NULL,
	[Identity] [nvarchar](max) NULL,
	[Demographics] [nvarchar](max) NULL,
	[ModelVersion] [int] NOT NULL,
) ON ArchiveStatusPS ([StatusCode]);


GO
