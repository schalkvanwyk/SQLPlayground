USE [Playground]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Audit].[BankAccountJSON](
	[AppliesOn] [datetime] NOT NULL,
	[Event] [varchar](64) NOT NULL,
	[EventDataCompressed] [varbinary](max) NOT NULL,
	[EventData]  AS (CONVERT([nvarchar](max),Decompress([EventDataCompressed]))),
	[BankAccountId]  AS (CONVERT([int],json_value(CONVERT([nvarchar](max),Decompress([EventDataCompressed])),'$.BankAccountId')))
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
ALTER TABLE [Audit].[BankAccountJSON] SET (LOCK_ESCALATION = DISABLE)
GO
CREATE CLUSTERED INDEX [CX_BankAccountJSON] ON [Audit].[BankAccountJSON]
(
	[AppliesOn] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ARITHABORT ON
SET CONCAT_NULL_YIELDS_NULL ON
SET QUOTED_IDENTIFIER ON
SET ANSI_NULLS ON
SET ANSI_PADDING ON
SET ANSI_WARNINGS ON
SET NUMERIC_ROUNDABORT OFF

GO
CREATE NONCLUSTERED INDEX [IX_BankAccountJSON] ON [Audit].[BankAccountJSON]
(
	[BankAccountId] ASC
)
INCLUDE ( 	[AppliesOn],
	[Event],
	[EventDataCompressed],
	[EventData]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [Audit].[BankAccountJSON] ADD  DEFAULT (getdate()) FOR [AppliesOn]
GO
