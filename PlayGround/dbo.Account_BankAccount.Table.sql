USE [Playground]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Account_BankAccount](
	[AccountId] [int] NOT NULL,
	[BankAccountId] [int] NOT NULL,
 CONSTRAINT [PK_Account_BankAccount] PRIMARY KEY CLUSTERED 
(
	[AccountId] ASC,
	[BankAccountId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
ALTER TABLE [dbo].[Account_BankAccount]  WITH CHECK ADD  CONSTRAINT [FK_Account_BankAccount_Account] FOREIGN KEY([AccountId])
REFERENCES [dbo].[Account] ([AccountId])
GO
ALTER TABLE [dbo].[Account_BankAccount] CHECK CONSTRAINT [FK_Account_BankAccount_Account]
GO
ALTER TABLE [dbo].[Account_BankAccount]  WITH CHECK ADD  CONSTRAINT [FK_Account_BankAccount_BankAccount] FOREIGN KEY([BankAccountId])
REFERENCES [dbo].[BankAccount] ([BankAccountId])
GO
ALTER TABLE [dbo].[Account_BankAccount] CHECK CONSTRAINT [FK_Account_BankAccount_BankAccount]
GO
