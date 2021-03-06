USE [Playground]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[EntityStateStatus]
AS
	SELECT
		ESs.[EntityId]
		,ESs.[StateCode]
		,ESs.[StatusCode]
		,E.[name] AS [EntityName]
		,ESe.[Name] AS [StateCodeName]
		,ESe.[DisplayName] AS [StateCodeDisplayName]
		,ESs.[Name] AS [StatusCodeName]
		,ESS.[DisplayName] AS [StatusCodeDisplayName]
	FROM [dbo].[EntityStatus] AS ESs
	LEFT JOIN [dbo].[EntityState] AS ESe
		ON ESe.[EntityId] = ESs.[EntityId]
		AND ESe.[StateCode] = ESs.[StateCode]
	LEFT JOIN [sys].[tables] AS E
		ON E.[object_id] = ESs.[EntityId]
GO
