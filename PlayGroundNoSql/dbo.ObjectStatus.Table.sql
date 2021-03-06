USE [PlaygroundNoSQL]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ObjectStatus](
	[ObjectId] [int] NOT NULL,
	[StateCode] [int] NOT NULL,
	[StatusCode] [int] NOT NULL,
	[Name] [nvarchar](120) NOT NULL,
	[DisplayName] [nvarchar](120) NOT NULL,
 CONSTRAINT [PK_ObjectStatus] PRIMARY KEY NONCLUSTERED 
(
	[ObjectId] ASC,
	[StateCode] ASC,
	[StatusCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [CX_ObjectStatus] UNIQUE CLUSTERED 
(
	[Name] ASC,
	[ObjectId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
ALTER TABLE [dbo].[ObjectStatus]  WITH CHECK ADD  CONSTRAINT [FK_ObjectStatus_ObjectState] FOREIGN KEY([ObjectId], [StateCode])
REFERENCES [dbo].[ObjectState] ([ObjectId], [StateCode])
GO
ALTER TABLE [dbo].[ObjectStatus] CHECK CONSTRAINT [FK_ObjectStatus_ObjectState]
GO
