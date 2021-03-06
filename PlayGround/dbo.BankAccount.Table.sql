USE [Playground]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BankAccount](
	[BankAccountId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](120) NOT NULL,
	[DisplayName] [nvarchar](120) NOT NULL,
	[StateCode] [int] NOT NULL,
	[StatusCode] [int] NOT NULL,
	[AccountNumber] [varchar](130) NULL,
	[BranchCode] [varchar](50) NULL,
	[BankName] [nvarchar](130) NULL,
 CONSTRAINT [PK_BankAccount] PRIMARY KEY NONCLUSTERED 
(
	[BankAccountId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING ON

GO
CREATE UNIQUE CLUSTERED INDEX [CX_BankAccount] ON [dbo].[BankAccount]
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[BankAccount] ADD  CONSTRAINT [DF_BankAccount_StateCode]  DEFAULT ((1)) FOR [StateCode]
GO
ALTER TABLE [dbo].[BankAccount] ADD  CONSTRAINT [DF_BankAccount_StatusCode]  DEFAULT ((1000001)) FOR [StatusCode]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE TRIGGER [dbo].[BankAccount_CreateUpdateAudit]
   ON  [dbo].[BankAccount]
   AFTER INSERT,UPDATE,DELETE
AS 
BEGIN
	SET NOCOUNT ON;

	IF (NOT UPDATE([Name]) 
	AND NOT UPDATE([DisplayName]) 
	AND NOT UPDATE([StateCode]) 
	AND NOT UPDATE([StatusCode]) 
	AND NOT UPDATE([AccountNumber]) 
	AND NOT UPDATE([BranchCode]) 
	AND NOT UPDATE([BankName])) RETURN; -- no changes so just exit

    INSERT INTO [Audit].[BankAccount]
	(
		[Event]
		,[BankAccountId]
		,[Name]
		,[DisplayName]
		,[StateCode]
		,[StatusCode]
		,[AccountNumber]
		,[BranchCode]
		,[BankName]
	)
	SELECT
		'deleted' AS [Event]
		,[BankAccountId]
		,[Name]
		,[DisplayName]
		,[StateCode]
		,[StatusCode]
		,[AccountNumber]
		,[BranchCode]
		,[BankName]
	FROM deleted

    INSERT INTO [Audit].[BankAccount]
	(
		[Event]
		,[BankAccountId]
		,[Name]
		,[DisplayName]
		,[StateCode]
		,[StatusCode]
		,[AccountNumber]
		,[BranchCode]
		,[BankName]
	)
	SELECT
		'inserted' AS [Event]
		,[BankAccountId]
		,[Name]
		,[DisplayName]
		,[StateCode]
		,[StatusCode]
		,[AccountNumber]
		,[BranchCode]
		,[BankName]
	FROM inserted

END


GO
ALTER TABLE [dbo].[BankAccount] ENABLE TRIGGER [BankAccount_CreateUpdateAudit]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[BankAccount_CreateUpdateAuditJSON]
   ON  [dbo].[BankAccount]
   AFTER INSERT,UPDATE,DELETE
AS 
BEGIN
	SET NOCOUNT ON;

    ;WITH cte AS
	(
		SELECT
			[Event]
			,(SELECT [BankAccountId], [deleted], [inserted] FOR JSON PATH, WITHOUT_ARRAY_WRAPPER) AS [EventData]
		FROM
		(
		SELECT
			(CASE WHEN D.[BankAccountId] IS NULL THEN 'inserted' WHEN I.[BankAccountId] IS NULL THEN 'deleted' ELSE 'updated' END) AS [Event]
			,JSON_QUERY((SELECT
				IIF(D.[BankAccountId] IS NULL, NULL, 'deleted') AS [Event]
				,D.[BankAccountId]
				,D.[Name]
				,D.[DisplayName]
				,D.[StateCode]
				,D.[StatusCode]
				,D.[AccountNumber]
				,D.[BranchCode]
				,D.[BankName]
				FOR JSON PATH, WITHOUT_ARRAY_WRAPPER)) AS [deleted]
			,JSON_QUERY((SELECT
				IIF(I.[BankAccountId] IS NULL, NULL, 'inserted') AS [Event]
				,I.[BankAccountId]
				,I.[Name]
				,I.[DisplayName]
				,I.[StateCode]
				,I.[StatusCode]
				,I.[AccountNumber]
				,I.[BranchCode]
				,I.[BankName]
				FOR JSON PATH, WITHOUT_ARRAY_WRAPPER)) AS [inserted]
			,COALESCE(I.[BankAccountId], D.[BankAccountId]) AS [BankAccountId]
		FROM inserted AS I
		FULL OUTER JOIN deleted AS D
			ON D.[BankAccountId] = I.[BankAccountId]
		) AS A
	)
	INSERT INTO [Audit].[BankAccountJSON]
	(
		[Event]
		,[EventDataCompressed]
	)
	SELECT
		[Event]
		,COMPRESS([EventData]) AS [EventDataCompressed]
	FROM cte

END


GO
ALTER TABLE [dbo].[BankAccount] ENABLE TRIGGER [BankAccount_CreateUpdateAuditJSON]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[BankAccount_CreateUpdateAuditJSON_V1]
   ON  [dbo].[BankAccount]
   AFTER INSERT,UPDATE,DELETE
AS 
BEGIN
	SET NOCOUNT ON;

	DECLARE @JSON NVARCHAR(MAX) = (SELECT * FROM deleted FOR JSON PATH)

    INSERT INTO [Audit].[BankAccountJSON]
	(
		[Event]
		,[EventDataCompressed]
		,[BankAccountId]
	)
	SELECT
		'deleted' AS [Event]
		,COMPRESS(@JSON) AS [EventDataCompressed]
		,[BankAccountId]
	FROM deleted AS A

	SET @JSON = (SELECT * FROM inserted FOR JSON PATH)

    INSERT INTO [Audit].[BankAccountJSON]
	(
		[Event]
		,[EventDataCompressed]
		,[BankAccountId]
	)
	SELECT
		'inserted' AS [Event]
		,COMPRESS(@JSON) AS [EventDataCompressed]
		,[BankAccountId]
	FROM inserted AS A

END


GO
ALTER TABLE [dbo].[BankAccount] DISABLE TRIGGER [BankAccount_CreateUpdateAuditJSON_V1]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE TRIGGER [dbo].[BankAccount_CreateUpdateAuditJSON_V2]
   ON  [dbo].[BankAccount]
   AFTER INSERT,UPDATE,DELETE
AS 
BEGIN
	SET NOCOUNT ON;

    ;WITH cte AS
	(
		SELECT
			CAST((SELECT 
				[BankAccountId]
				,[Name]
				,[DisplayName]
				,[StateCode]
				,[StatusCode]
				,[AccountNumber]
				,[BranchCode]
				,[BankName] 
			  FOR JSON PATH, WITHOUT_ARRAY_WRAPPER) AS varbinary(MAX)) AS [EventData]
			--,[BankAccountId]
		FROM deleted AS A
	)
	INSERT INTO [Audit].[BankAccountJSON]
	(
		[Event]
		,[EventDataCompressed]
		--,[BankAccountId]
	)
	SELECT
		'deleted' AS [Event]
		,COMPRESS([EventData]) AS [EventDataCompressed]
		--,[BankAccountId]
	FROM cte

    ;WITH cte AS
	(
		SELECT
			CAST((SELECT
				[BankAccountId]
				,[Name]
				,[DisplayName]
				,[StateCode]
				,[StatusCode]
				,[AccountNumber]
				,[BranchCode]
				,[BankName]
			  FOR JSON PATH, WITHOUT_ARRAY_WRAPPER) AS varbinary(MAX)) AS [EventData]
			--,[BankAccountId]
		FROM inserted AS A
	)
    INSERT INTO [Audit].[BankAccountJSON]
	(
		[Event]
		,[EventDataCompressed]
		--,[BankAccountId]
	)
	SELECT
		'inserted' AS [Event]
		,COMPRESS([EventData]) AS [EventDataCompressed]
		--,[BankAccountId]
	FROM cte

END



GO
ALTER TABLE [dbo].[BankAccount] DISABLE TRIGGER [BankAccount_CreateUpdateAuditJSON_V2]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[BankAccount_CreateUpdateAuditJSON_V3]
   ON  [dbo].[BankAccount]
   AFTER INSERT,UPDATE,DELETE
AS 
BEGIN
	SET NOCOUNT ON;

    ;WITH cte AS
	(
		SELECT
			[Event]
			,(SELECT [BankAccountId], JSON_QUERY('[' + [deleted] + ','  + [inserted] + ']') AS [EventData] FOR JSON PATH, WITHOUT_ARRAY_WRAPPER) AS [EventData]
		FROM
		(
		SELECT
			(CASE WHEN D.[BankAccountId] IS NULL THEN 'inserted' WHEN I.[BankAccountId] IS NULL THEN 'deleted' ELSE 'updated' END) AS [Event]
			,(SELECT
				'deleted' AS [Event]
				,D.[BankAccountId]
				,D.[Name]
				,D.[DisplayName]
				,D.[StateCode]
				,D.[StatusCode]
				,D.[AccountNumber]
				,D.[BranchCode]
				,D.[BankName]
				FOR JSON PATH, WITHOUT_ARRAY_WRAPPER) AS [deleted]
			,(SELECT
				'inserted' AS [Event]
				,I.[BankAccountId]
				,I.[Name]
				,I.[DisplayName]
				,I.[StateCode]
				,I.[StatusCode]
				,I.[AccountNumber]
				,I.[BranchCode]
				,I.[BankName]
				FOR JSON PATH, WITHOUT_ARRAY_WRAPPER) AS [inserted]
			,COALESCE(I.[BankAccountId], D.[BankAccountId]) AS [BankAccountId]
		FROM inserted AS I
		FULL OUTER JOIN deleted AS D
			ON D.[BankAccountId] = I.[BankAccountId]
		) AS A
	)
	INSERT INTO [Audit].[BankAccountJSON]
	(
		[Event]
		,[EventDataCompressed]
	)
	SELECT
		[Event]
		,COMPRESS([EventData]) AS [EventDataCompressed]
	FROM cte

END


GO
ALTER TABLE [dbo].[BankAccount] DISABLE TRIGGER [BankAccount_CreateUpdateAuditJSON_V3]
GO
