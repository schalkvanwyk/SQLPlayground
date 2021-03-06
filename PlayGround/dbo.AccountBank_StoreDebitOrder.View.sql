USE [Playground]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[AccountBank_StoreDebitOrder]
AS
	SELECT
		AB.[HierarchyRootContainer]
		,AB.[HierarchyRootContainerPath]
		,AB.[Hierarchy]
		,AB.[HierarchyPath]
		,AB.[AccountId]
		,AB.[Name]
		,AB.[DisplayName]
		,AB.[AccountTypeName]
		,AB.[AccountParentId]
		,AB.[ParentName]
		,AB.[ParentDisplayName]
		,AB.[ParentAccountTypeName]
		,AB.[StateCode]
		,AB.[StatusCode]
		,AB.[StatusName]
		,AB.[StatusDisplayName]
		,NULLIF(DO.[DebitOrderId], -99999999) AS [DebitOrderId]
		,DO.[DebitOrderTypeId]
		,DO.[DebitAccountId]
		,DO.[StateCode] AS [DebitOrderStateCode]
		,DO.[StatusCode] AS [DebitOrderStatusCode]
		,CAST(ISNULL(ISNUMERIC(DO.[DebitOrderId]), 0) AS BIT) AS [HasDebitOrder]
	FROM [dbo].[AccountBank] AS AB
	LEFT JOIN [dbo].[DebitOrder] AS DO
		ON DO.[CreditAccountId] = AB.[AccountId]
	WHERE AB.[ParentAccountTypeName] = 'Store'


GO
