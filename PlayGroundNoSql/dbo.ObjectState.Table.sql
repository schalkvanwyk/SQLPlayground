USE [PlaygroundNoSQL]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ObjectState](
	[ObjectId] [int] NOT NULL,
	[StateCode] [int] NOT NULL,
	[Name] [nvarchar](120) NOT NULL,
	[DisplayName] [nvarchar](120) NOT NULL,
 CONSTRAINT [CX_ObjectState] UNIQUE CLUSTERED 
(
	[Name] ASC,
	[ObjectId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
INSERT [dbo].[ObjectState] ([ObjectId], [StateCode], [Name], [DisplayName]) VALUES (0, 1, N'Active', N'Active')
INSERT [dbo].[ObjectState] ([ObjectId], [StateCode], [Name], [DisplayName]) VALUES (0, 0, N'Inactive', N'Inactive')
ALTER TABLE [dbo].[ObjectState] ADD  CONSTRAINT [PK_ObjectState] PRIMARY KEY NONCLUSTERED 
(
	[ObjectId] ASC,
	[StateCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
