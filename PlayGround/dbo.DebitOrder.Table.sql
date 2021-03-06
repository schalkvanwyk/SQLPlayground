USE [Playground]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DebitOrder](
	[DebitOrderId] [int] IDENTITY(1,1) NOT NULL,
	[DebitOrderTypeId] [int] NOT NULL,
	[StateCode] [int] NOT NULL,
	[StatusCode] [int] NOT NULL,
	[DebitAccountId] [int] NOT NULL,
	[CreditAccountId] [int] NOT NULL,
	[SysStartTime] [datetime2](0) GENERATED ALWAYS AS ROW START NOT NULL,
	[SysEndTime] [datetime2](0) GENERATED ALWAYS AS ROW END NOT NULL,
 CONSTRAINT [PK_DebitOrder] PRIMARY KEY NONCLUSTERED 
(
	[DebitOrderId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
	PERIOD FOR SYSTEM_TIME ([SysStartTime], [SysEndTime])
) ON [PRIMARY]
WITH
(
SYSTEM_VERSIONING = ON (HISTORY_TABLE = [History].[DebitOrderHistory] , DATA_CONSISTENCY_CHECK = ON )
)

GO
CREATE UNIQUE CLUSTERED INDEX [CX_DebitOrder] ON [dbo].[DebitOrder]
(
	[CreditAccountId] ASC,
	[DebitOrderTypeId] ASC,
	[DebitAccountId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[DebitOrder] ADD  CONSTRAINT [DF_DebitOrder_StateCode]  DEFAULT ((1)) FOR [StateCode]
GO
ALTER TABLE [dbo].[DebitOrder] ADD  CONSTRAINT [DF_DebitOrder_StatusCode]  DEFAULT ((1000001)) FOR [StatusCode]
GO
ALTER TABLE [dbo].[DebitOrder] ADD  CONSTRAINT [DF_DebitOrder_SysStart]  DEFAULT (sysutcdatetime()) FOR [SysStartTime]
GO
ALTER TABLE [dbo].[DebitOrder] ADD  CONSTRAINT [DF_DebitOrder_SysEnd]  DEFAULT (CONVERT([datetime2](0),'9999-12-31 23:59:59')) FOR [SysEndTime]
GO
ALTER TABLE [dbo].[DebitOrder]  WITH CHECK ADD  CONSTRAINT [FK_DebitOrder_CreditAccount] FOREIGN KEY([CreditAccountId])
REFERENCES [dbo].[Account] ([AccountId])
GO
ALTER TABLE [dbo].[DebitOrder] CHECK CONSTRAINT [FK_DebitOrder_CreditAccount]
GO
ALTER TABLE [dbo].[DebitOrder]  WITH CHECK ADD  CONSTRAINT [FK_DebitOrder_DebitAccount] FOREIGN KEY([DebitAccountId])
REFERENCES [dbo].[Account] ([AccountId])
GO
ALTER TABLE [dbo].[DebitOrder] CHECK CONSTRAINT [FK_DebitOrder_DebitAccount]
GO
ALTER TABLE [dbo].[DebitOrder]  WITH CHECK ADD  CONSTRAINT [FK_DebitOrder_DebitOrderType] FOREIGN KEY([DebitOrderTypeId])
REFERENCES [dbo].[DebitOrderType] ([DebitOrderTypeId])
GO
ALTER TABLE [dbo].[DebitOrder] CHECK CONSTRAINT [FK_DebitOrder_DebitOrderType]
GO
