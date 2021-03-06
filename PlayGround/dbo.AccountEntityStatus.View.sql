USE [Playground]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[AccountEntityStatus]
AS
	SELECT
		ISNULL(ES.[StateCode], DS.[StateCode]) AS [StateCode]
		,ISNULL(ES.[StatusCode], DS.[StatusCode]) AS [StatusCode]
		,ISNULL(ES.[Name], DS.[Name]) AS [Name]
		,ISNULL(ES.[DisplayName], DS.[DisplayName]) AS [DisplayName]
	FROM [dbo].[EntityStatus] AS [DS]
	LEFT JOIN [dbo].[EntityStatus] AS [ES]
		ON [ES].[StateCode] = [DS].[StateCode]
		AND [ES].[EntityId] = OBJECT_ID(N'dbo.Account')
		AND [ES].[Name] = [DS].[Name]
	WHERE [DS].[EntityId] = 0
GO
