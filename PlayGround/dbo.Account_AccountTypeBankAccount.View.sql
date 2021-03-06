USE [Playground]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[Account_AccountTypeBankAccount]
AS
	SELECT 
		A.AccountTypeName
		,A.DisplayName
		,ISNULL(ISNUMERIC(AC.AccountId), 0) AS HasBankAccount
	FROM Account AS A
	LEFT JOIN Account AS AC
		ON AC.AccountParentId = A.AccountId
		AND AC.AccountTypeName = 'Bank'
	WHERE A.AccountTypeName != 'Bank'
	AND A.Hierarchy.GetLevel() >1


GO
