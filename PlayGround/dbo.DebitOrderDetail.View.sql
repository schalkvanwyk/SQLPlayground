USE [Playground]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[DebitOrderDetail] AS
SELECT 
do.[DebitOrderId]
,dot.Name AS DebitOrderTypeName
,da.Name AS DebitAccoutName
,da.DisplayName AS DebitAccoutDisplayName
,da.AccountTypeName AS DebitAccountTypeName
,dba.BankName AS DebitBankName
,dba.BranchCode AS DebitBranchCode
,dba.AccountNumber AS DebitAccountNumber
,ca.Name AS CreditAccoutName
,ca.DisplayName AS CreditDisplayName
,ca.AccountTypeName AS CreditAccountTypeName
,cba.BankName AS CreditBankName
,cba.BranchCode AS CreditBranchCode
,cba.AccountNumber AS CreditAccountNumber
FROM [dbo].[DebitOrder] as do
join dbo.DebitOrderType as dot
	on dot.DebitOrderTypeId = do.DebitOrderTypeId
join dbo.Account as da
	on da.AccountId = do.DebitAccountId
left join dbo.Account_BankAccount as daba
	on daba.AccountId = da.AccountId
left join dbo.BankAccount as dba
	on dba.BankAccountId = daba.BankAccountId
join dbo.Account as ca
	on ca.AccountId = do.CreditAccountId
left join dbo.Account_BankAccount as caba
	on ca.AccountId = caba.AccountId
left join dbo.BankAccount as cba
	on cba.BankAccountId = caba.BankAccountId
GO
