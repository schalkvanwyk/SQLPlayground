USE [Playground]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [History].[DebitOrderTypeHistory](
	[DebitOrderTypeId] [int] NOT NULL,
	[Name] [nvarchar](120) NOT NULL,
	[DisplayName] [nvarchar](120) NOT NULL,
	[StateCode] [int] NOT NULL,
	[StatusCode] [int] NOT NULL,
	[SysStartTime] [datetime2](0) NOT NULL,
	[SysEndTime] [datetime2](0) NOT NULL
) ON [PRIMARY]

GO
CREATE CLUSTERED INDEX [ix_DebitOrderTypeHistory] ON [History].[DebitOrderTypeHistory]
(
	[SysEndTime] ASC,
	[SysStartTime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
