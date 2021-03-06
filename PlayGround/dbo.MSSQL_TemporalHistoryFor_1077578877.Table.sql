USE [Playground]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MSSQL_TemporalHistoryFor_1077578877](
	[AccountId] [int] NOT NULL,
	[AccountParentId] [int] NULL,
	[Name] [nvarchar](120) NOT NULL,
	[DisplayName] [nvarchar](120) NOT NULL,
	[StateCode] [int] NOT NULL,
	[StatusCode] [int] NOT NULL,
	[AccountTypeName] [varchar](50) NULL,
	[Hierarchy] [hierarchyid] NULL,
	[SysStartTime] [datetime2](0) NOT NULL,
	[SysEndTime] [datetime2](0) NOT NULL,
	[HierarchyRootContainer] [hierarchyid] NULL
) ON [PRIMARY]

GO
CREATE CLUSTERED INDEX [ix_MSSQL_TemporalHistoryFor_1077578877] ON [dbo].[MSSQL_TemporalHistoryFor_1077578877]
(
	[SysEndTime] ASC,
	[SysStartTime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
