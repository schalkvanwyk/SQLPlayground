USE [Playground]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EntityStatus](
	[EntityId] [int] NOT NULL,
	[StateCode] [int] NOT NULL,
	[StatusCode] [int] NOT NULL,
	[Name] [nvarchar](120) NOT NULL,
	[DisplayName] [nvarchar](120) NOT NULL,
 CONSTRAINT [PK_EntityStatus] PRIMARY KEY NONCLUSTERED 
(
	[EntityId] ASC,
	[StateCode] ASC,
	[StatusCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [CX_EntityStatus] UNIQUE CLUSTERED 
(
	[Name] ASC,
	[EntityId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING ON

GO
CREATE UNIQUE NONCLUSTERED INDEX [UX_EntityStatus] ON [dbo].[EntityStatus]
(
	[EntityId] ASC,
	[StatusCode] ASC
)
INCLUDE ( 	[StateCode],
	[Name],
	[DisplayName]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[EntityStatus]  WITH CHECK ADD  CONSTRAINT [FK_EntityStatus_EntityState] FOREIGN KEY([EntityId], [StateCode])
REFERENCES [dbo].[EntityState] ([EntityId], [StateCode])
GO
ALTER TABLE [dbo].[EntityStatus] CHECK CONSTRAINT [FK_EntityStatus_EntityState]
GO
