USE [Playground]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[Account_AccountTypeDebitOrderSummary]
AS
	SELECT 
		ISNULL(AP.AccountTypeName, '') AS ParentAccountTypeName
		,ISNULL(A.AccountTypeName, '') AS AccountTypeName
		,CAST(ISNULL(ISNUMERIC(DO.DebitOrderId), 0) AS BIT) AS HasDebitOrder
		,CAST(COUNT(A.AccountId) AS INT) AS Total
	FROM Account AS A
	JOIN Account AS AP
		ON AP.AccountId = A.AccountParentId
	LEFT JOIN DebitOrder AS DO
		ON DO.CreditAccountId = A.AccountId
		OR DO.DebitAccountId = A.AccountId
	WHERE A.Hierarchy.GetLevel() = 4
		--WHERE AccountTypeName = 'Bank'
		--WHERE AccountTypeName = 'Organisation'
		--AND EXISTS (SELECT TOP (1) 1 FROM Account AS Z WHERE Z.Hierarchy = A.HierarchyRootContainer AND AccountTypeName = 'Organisation')
		--AND A.Hierarchy.GetAncestor(1) > A.HierarchyRootContainer
		--AND NOT EXISTS (SELECT TOP (1) 1 FROM DebitOrder AS Z WHERE Z.CreditAccountId = A.AccountId OR Z.DebitAccountId = A.AccountId)
	GROUP BY AP.AccountTypeName, A.AccountTypeName, ISNULL(ISNUMERIC(DO.DebitOrderId), 0)
	--ORDER BY AP.AccountTypeName, A.AccountTypeName, HasDebitOrder

GO
