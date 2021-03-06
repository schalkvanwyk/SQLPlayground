USE [PlaygroundNoSQL]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[FTContainer_InsertSysGlobal]
AS
INSERT INTO [dbo].[FTContainer]
           ([FTContainerKey]
           --,[SharedMetas]
           ,[SharedProperties]
           ,[SharedSettings])
select
'sysglobal' AS [FTContainerKey]
,(
select
*
from
(
select
'application/octet-stream' AS [Properties.ContentType]
) as [Properties]
FOR JSON PATH--, WITHOUT_ARRAY_WRAPPER
) as [SharedProperties]
,(
select
*
from
(
select
'%ProgramFiles(x86)%\Microsoft SDKs\Azure\AzCopy\AzCopy.exe' AS [Settings.AzCopy.ExePath]
,'http://127.0.0.1:10000/devstoreaccount1/' AS [Settings.AzCopy.DestinationAccount]
,'Eby8vdM02xNOcqFlqUwJPLlmEtlCDXJ1OUzFT50uSRZ6IFsuFq2UVErCz4I6tq/K1SZFPTOtr/KBHBeksoGMGw==' AS [Settings.AzCopy.DestinationKey]
,'%AzCopy% /Source:%Source% /Dest:%Destination% /DestKey:%DestinationKey% /destType:blob /S /XO /A /IA:C' AS [Settings.AzCopy.CmdTemplate]
) as [Settings]
FOR JSON PATH--, WITHOUT_ARRAY_WRAPPER
) as [SharedSettings]


GO
