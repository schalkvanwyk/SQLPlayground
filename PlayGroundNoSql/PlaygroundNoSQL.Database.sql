USE [master]
GO
CREATE DATABASE [PlaygroundNoSQL]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'PlaygroundNoSQL', FILENAME = N'D:\SQL\PlaygroundNoSQL.mdf' , SIZE = 73728KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB ), 
 FILEGROUP [Archive] 
( NAME = N'PlaygroundNoSQLArchive', FILENAME = N'D:\SQL\PlaygroundNoSQLArchive.ndf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB ), 
 FILEGROUP [ArchiveFileStream] CONTAINS FILESTREAM 
( NAME = N'PlaygroundNoSQLFSArchive', FILENAME = N'D:\SQL\PlaygroundNoSQLFSArchive' , MAXSIZE = UNLIMITED), 
 FILEGROUP [PRIMARYFILESTREAM] CONTAINS FILESTREAM  DEFAULT
( NAME = N'PlaygroundNoSQLFS', FILENAME = N'D:\SQL\PlaygroundNoSQLFS' , MAXSIZE = UNLIMITED)
 LOG ON 
( NAME = N'PlaygroundNoSQL_log', FILENAME = N'D:\SQL\PlaygroundNoSQL_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [PlaygroundNoSQL] SET COMPATIBILITY_LEVEL = 130
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [PlaygroundNoSQL].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [PlaygroundNoSQL] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [PlaygroundNoSQL] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [PlaygroundNoSQL] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [PlaygroundNoSQL] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [PlaygroundNoSQL] SET ARITHABORT OFF 
GO
ALTER DATABASE [PlaygroundNoSQL] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [PlaygroundNoSQL] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [PlaygroundNoSQL] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [PlaygroundNoSQL] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [PlaygroundNoSQL] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [PlaygroundNoSQL] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [PlaygroundNoSQL] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [PlaygroundNoSQL] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [PlaygroundNoSQL] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [PlaygroundNoSQL] SET  ENABLE_BROKER 
GO
ALTER DATABASE [PlaygroundNoSQL] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [PlaygroundNoSQL] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [PlaygroundNoSQL] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [PlaygroundNoSQL] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [PlaygroundNoSQL] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [PlaygroundNoSQL] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [PlaygroundNoSQL] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [PlaygroundNoSQL] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [PlaygroundNoSQL] SET  MULTI_USER 
GO
ALTER DATABASE [PlaygroundNoSQL] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [PlaygroundNoSQL] SET DB_CHAINING OFF 
GO
ALTER DATABASE [PlaygroundNoSQL] SET FILESTREAM( NON_TRANSACTED_ACCESS = FULL, DIRECTORY_NAME = N'PlaygroundNoSQLFS' ) 
GO
ALTER DATABASE [PlaygroundNoSQL] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [PlaygroundNoSQL] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [PlaygroundNoSQL] SET CHANGE_TRACKING = ON (CHANGE_RETENTION = 2 DAYS,AUTO_CLEANUP = ON)
GO
ALTER DATABASE [PlaygroundNoSQL] SET QUERY_STORE = OFF
GO
USE [PlaygroundNoSQL]
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
GO
ALTER DATABASE [PlaygroundNoSQL] SET  READ_WRITE 
GO
