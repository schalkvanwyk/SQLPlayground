USE [Playground]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[DebitOrderHierarchy]
AS
SELECT
[DebitOrderId]
,dot.[Name] as [DebitOrderTypeName]
,[DebitAccountId]
,daba.Name as DebitAccountBank
--,das.Name as DebitAccountStore
,dabr.Name as DebitAccountBrand
,[CreditAccountId]
,caba.Name as CreditAccountBank
,cas.Name as CreditAccountStore
,cabr.Name as CreditAccountBrand
FROM [dbo].[DebitOrder] as do
join dbo.DebitOrderType as dot
	on dot.DebitOrderTypeId = do.DebitOrderTypeId
join [dbo].[AccountBank] as caba
	on caba.AccountId = do.CreditAccountId
join dbo.AccountStore as cas
	on cas.AccountId = caba.AccountParentId
join dbo.AccountBrand as cabr
	on cabr.AccountId = cas.AccountParentId
join [dbo].[AccountBank] as daba
	on daba.AccountId = do.DebitAccountId
--left join dbo.AccountStore as das
--	on das.AccountId = daba.AccountParentId
left join dbo.AccountBrand as dabr
	--on dabr.AccountId = daba.AccountParentId
	on dabr.Hierarchy = daba.HierarchyRootContainer


GO
