USE [Playground]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[AccountBank]
AS
	SELECT
		A.[HierarchyRootContainer]
		,A.[HierarchyRootContainer].ToString() AS [HierarchyRootContainerPath]
		,A.[Hierarchy]
		,A.[Hierarchy].ToString() AS [HierarchyPath]
		,A.[AccountId]
		,A.[Name]
		,A.[DisplayName]
		,A.[AccountTypeName]
		,A.[AccountParentId]
		,PA.[Name] AS [ParentName]
		,PA.[DisplayName] AS [ParentDisplayName]
		,PA.[AccountTypeName] AS [ParentAccountTypeName]
		,A.[StateCode]
		,A.[StatusCode]
		,ESs.[Name] AS [StatusName]
		,ESs.[DisplayName] AS [StatusDisplayName]
	FROM [dbo].[Account] AS A
	LEFT JOIN [dbo].[Account] AS PA
		ON PA.[AccountId] = A.[AccountParentId]
	LEFT JOIN [dbo].[AccountEntityStatus] AS ESs
		ON ESs.[StateCode] = A.[StateCode]
		AND ESs.[StatusCode] = A.[StatusCode]
	WHERE A.[AccountTypeName] = 'Bank'


GO
