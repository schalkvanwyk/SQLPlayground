USE [master]
GO
CREATE DATABASE [Playground]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Playground', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.SQLEXPRESS2016\MSSQL\DATA\Playground.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Playground_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.SQLEXPRESS2016\MSSQL\DATA\Playground_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [Playground] SET COMPATIBILITY_LEVEL = 130
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Playground].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Playground] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Playground] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Playground] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Playground] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Playground] SET ARITHABORT OFF 
GO
ALTER DATABASE [Playground] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Playground] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Playground] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Playground] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Playground] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Playground] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Playground] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Playground] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Playground] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Playground] SET  ENABLE_BROKER 
GO
ALTER DATABASE [Playground] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Playground] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Playground] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Playground] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Playground] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Playground] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Playground] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Playground] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Playground] SET  MULTI_USER 
GO
ALTER DATABASE [Playground] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Playground] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Playground] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Playground] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Playground] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Playground] SET QUERY_STORE = OFF
GO
USE [Playground]
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
ALTER DATABASE [Playground] SET  READ_WRITE 
GO
