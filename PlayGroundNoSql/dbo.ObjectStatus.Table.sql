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
 CONSTRAINT [CX_ObjectStatus] UNIQUE CLUSTERED 
(
	[Name] ASC,
	[ObjectId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
INSERT [dbo].[ObjectStatus] ([ObjectId], [StateCode], [StatusCode], [Name], [DisplayName]) VALUES (0, 1, 1001, N'Active', N'Active')
INSERT [dbo].[ObjectStatus] ([ObjectId], [StateCode], [StatusCode], [Name], [DisplayName]) VALUES (0, 1, 10010, N'Active-Pending', N'Pending (Active)')
INSERT [dbo].[ObjectStatus] ([ObjectId], [StateCode], [StatusCode], [Name], [DisplayName]) VALUES (0, 0, 1000, N'Inactive', N'Inactive')
INSERT [dbo].[ObjectStatus] ([ObjectId], [StateCode], [StatusCode], [Name], [DisplayName]) VALUES (0, 0, 10003, N'Inactive-Archived', N'Archived (Inactive)')
INSERT [dbo].[ObjectStatus] ([ObjectId], [StateCode], [StatusCode], [Name], [DisplayName]) VALUES (0, 0, 100031, N'Inactive-Archived-Compressed', N'Compressed Archived (Inactive)')
INSERT [dbo].[ObjectStatus] ([ObjectId], [StateCode], [StatusCode], [Name], [DisplayName]) VALUES (0, 0, 10000, N'Inactive-Deleted', N'Deleted (Inactive)')
INSERT [dbo].[ObjectStatus] ([ObjectId], [StateCode], [StatusCode], [Name], [DisplayName]) VALUES (0, 0, 100001, N'Inactive-Deleted-Compressed', N'Deleted (Inactive)')
INSERT [dbo].[ObjectStatus] ([ObjectId], [StateCode], [StatusCode], [Name], [DisplayName]) VALUES (0, 0, 10001, N'Inactive-Dormant', N'Dormant (Inactive)')
INSERT [dbo].[ObjectStatus] ([ObjectId], [StateCode], [StatusCode], [Name], [DisplayName]) VALUES (0, 0, 100011, N'Inactive-Dormant-Compressed', N'Compressed Dormant (Inactive)')
INSERT [dbo].[ObjectStatus] ([ObjectId], [StateCode], [StatusCode], [Name], [DisplayName]) VALUES (0, 0, 10002, N'Inactive-Suspended', N'Suspended (Inactive)')
ALTER TABLE [dbo].[ObjectStatus] ADD  CONSTRAINT [PK_ObjectStatus] PRIMARY KEY NONCLUSTERED 
(
	[ObjectId] ASC,
	[StateCode] ASC,
	[StatusCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ObjectStatus]  WITH CHECK ADD  CONSTRAINT [FK_ObjectStatus_ObjectState] FOREIGN KEY([ObjectId], [StateCode])
REFERENCES [dbo].[ObjectState] ([ObjectId], [StateCode])
GO
ALTER TABLE [dbo].[ObjectStatus] CHECK CONSTRAINT [FK_ObjectStatus_ObjectState]
GO
