USE [Playground]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DebitOrderType](
	[DebitOrderTypeId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](120) NOT NULL,
	[DisplayName] [nvarchar](120) NOT NULL,
	[StateCode] [int] NOT NULL,
	[StatusCode] [int] NOT NULL,
	[SysStartTime] [datetime2](0) GENERATED ALWAYS AS ROW START NOT NULL,
	[SysEndTime] [datetime2](0) GENERATED ALWAYS AS ROW END NOT NULL,
 CONSTRAINT [PK_DebitOrderType] PRIMARY KEY NONCLUSTERED 
(
	[DebitOrderTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
	PERIOD FOR SYSTEM_TIME ([SysStartTime], [SysEndTime])
) ON [PRIMARY]
WITH
(
SYSTEM_VERSIONING = ON (HISTORY_TABLE = [History].[DebitOrderTypeHistory] , DATA_CONSISTENCY_CHECK = ON )
)

GO
SET ANSI_PADDING ON

GO
CREATE UNIQUE CLUSTERED INDEX [CX_DebitOrderType] ON [dbo].[DebitOrderType]
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[DebitOrderType] ADD  CONSTRAINT [DF_DebitOrderType_StateCode]  DEFAULT ((1)) FOR [StateCode]
GO
ALTER TABLE [dbo].[DebitOrderType] ADD  CONSTRAINT [DF_DebitOrderType_StatusCode]  DEFAULT ((1000001)) FOR [StatusCode]
GO
ALTER TABLE [dbo].[DebitOrderType] ADD  CONSTRAINT [DF_DebitOrderType_SysStart]  DEFAULT (sysutcdatetime()) FOR [SysStartTime]
GO
ALTER TABLE [dbo].[DebitOrderType] ADD  CONSTRAINT [DF_DebitOrderType_SysEnd]  DEFAULT (CONVERT([datetime2](0),'9999-12-31 23:59:59')) FOR [SysEndTime]
GO
