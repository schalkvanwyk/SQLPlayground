USE [Playground]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Account](
	[AccountId] [int] IDENTITY(1,1) NOT NULL,
	[AccountParentId] [int] NULL,
	[Name] [nvarchar](120) NOT NULL,
	[DisplayName] [nvarchar](120) NOT NULL,
	[StateCode] [int] NOT NULL,
	[StatusCode] [int] NOT NULL,
	[AccountTypeName] [varchar](50) NULL,
	[Hierarchy] [hierarchyid] NULL,
	[SysStartTime] [datetime2](0) GENERATED ALWAYS AS ROW START NOT NULL,
	[SysEndTime] [datetime2](0) GENERATED ALWAYS AS ROW END NOT NULL,
	[HierarchyRootContainer]  AS ([Hierarchy].[GetAncestor]([Hierarchy].[GetLevel]()-(1))) PERSISTED,
 CONSTRAINT [PK_Account] PRIMARY KEY NONCLUSTERED 
(
	[AccountId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
	PERIOD FOR SYSTEM_TIME ([SysStartTime], [SysEndTime])
) ON [PRIMARY]
WITH
(
SYSTEM_VERSIONING = ON (HISTORY_TABLE = [dbo].[MSSQL_TemporalHistoryFor_1077578877] , DATA_CONSISTENCY_CHECK = ON )
)

GO
SET ANSI_PADDING ON

GO
CREATE UNIQUE CLUSTERED INDEX [CX_Account] ON [dbo].[Account]
(
	[Name] ASC,
	[AccountTypeName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ARITHABORT ON
SET CONCAT_NULL_YIELDS_NULL ON
SET QUOTED_IDENTIFIER ON
SET ANSI_NULLS ON
SET ANSI_PADDING ON
SET ANSI_WARNINGS ON
SET NUMERIC_ROUNDABORT OFF

GO
CREATE NONCLUSTERED INDEX [IX_Account_TypeName] ON [dbo].[Account]
(
	[AccountTypeName] ASC,
	[Name] ASC,
	[AccountParentId] ASC,
	[AccountId] ASC
)
INCLUDE ( 	[DisplayName],
	[StateCode],
	[StatusCode],
	[Hierarchy],
	[HierarchyRootContainer]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
CREATE UNIQUE NONCLUSTERED INDEX [UX_Account_Hierarchy] ON [dbo].[Account]
(
	[Hierarchy] ASC
)
INCLUDE ( 	[AccountId],
	[AccountParentId],
	[Name],
	[DisplayName],
	[StateCode],
	[StatusCode],
	[AccountTypeName]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
CREATE UNIQUE NONCLUSTERED INDEX [UX_AccountBank] ON [dbo].[Account]
(
	[AccountId] ASC,
	[Name] ASC
)
INCLUDE ( 	[AccountParentId],
	[DisplayName],
	[StateCode],
	[StatusCode],
	[AccountTypeName],
	[Hierarchy]) 
WHERE ([AccountTypeName]='Bank')
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
CREATE UNIQUE NONCLUSTERED INDEX [UX_AccountOrganisation] ON [dbo].[Account]
(
	[AccountId] ASC,
	[Name] ASC
)
INCLUDE ( 	[AccountParentId],
	[DisplayName],
	[StateCode],
	[StatusCode],
	[AccountTypeName],
	[Hierarchy]) 
WHERE ([AccountTypeName]='Organisation')
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
CREATE UNIQUE NONCLUSTERED INDEX [UX_AccountStore] ON [dbo].[Account]
(
	[AccountId] ASC,
	[Name] ASC
)
INCLUDE ( 	[AccountParentId],
	[DisplayName],
	[StateCode],
	[StatusCode],
	[AccountTypeName],
	[Hierarchy]) 
WHERE ([AccountTypeName]='Store')
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Account] ADD  CONSTRAINT [DF_Account_StateCode]  DEFAULT ((1)) FOR [StateCode]
GO
ALTER TABLE [dbo].[Account] ADD  CONSTRAINT [DF_Account_StatusCode]  DEFAULT ((1000001)) FOR [StatusCode]
GO
ALTER TABLE [dbo].[Account] ADD  CONSTRAINT [DF_Account_SysStart]  DEFAULT (sysutcdatetime()) FOR [SysStartTime]
GO
ALTER TABLE [dbo].[Account] ADD  CONSTRAINT [DF_Account_SysEnd]  DEFAULT (CONVERT([datetime2](0),'9999-12-31 23:59:59')) FOR [SysEndTime]
GO
ALTER TABLE [dbo].[Account]  WITH CHECK ADD  CONSTRAINT [FK_Account_ParentAccount] FOREIGN KEY([AccountParentId])
REFERENCES [dbo].[Account] ([AccountId])
GO
ALTER TABLE [dbo].[Account] CHECK CONSTRAINT [FK_Account_ParentAccount]
GO
