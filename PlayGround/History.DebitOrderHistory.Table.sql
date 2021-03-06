USE [Playground]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [History].[DebitOrderHistory](
	[DebitOrderId] [int] NOT NULL,
	[DebitOrderTypeId] [int] NOT NULL,
	[StateCode] [int] NOT NULL,
	[StatusCode] [int] NOT NULL,
	[DebitAccountId] [int] NOT NULL,
	[CreditAccountId] [int] NOT NULL,
	[SysStartTime] [datetime2](0) NOT NULL,
	[SysEndTime] [datetime2](0) NOT NULL
) ON [PRIMARY]

GO
CREATE CLUSTERED INDEX [ix_DebitOrderHistory] ON [History].[DebitOrderHistory]
(
	[SysEndTime] ASC,
	[SysStartTime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
