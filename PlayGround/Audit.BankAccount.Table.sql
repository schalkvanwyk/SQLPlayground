USE [Playground]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Audit].[BankAccount](
	[AppliesOn] [datetime] NOT NULL,
	[Event] [varchar](64) NOT NULL,
	[BankAccountId] [int] NOT NULL,
	[Name] [nvarchar](120) NOT NULL,
	[DisplayName] [nvarchar](120) NOT NULL,
	[StateCode] [int] NOT NULL,
	[StatusCode] [int] NOT NULL,
	[AccountNumber] [varchar](130) NULL,
	[BranchCode] [varchar](50) NULL,
	[BankName] [nvarchar](130) NULL
) ON [PRIMARY]

GO
ALTER TABLE [Audit].[BankAccount] SET (LOCK_ESCALATION = DISABLE)
GO
ALTER TABLE [Audit].[BankAccount] ADD  DEFAULT (getdate()) FOR [AppliesOn]
GO
