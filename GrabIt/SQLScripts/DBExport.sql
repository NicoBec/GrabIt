USE [master]
GO
/****** Object:  Database [GrabIt]    Script Date: 28/10/2014 17:41:28 ******/
CREATE DATABASE [GrabIt]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'GrabIt', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\GrabIt.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'GrabIt_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\GrabIt_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [GrabIt] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [GrabIt].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [GrabIt] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [GrabIt] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [GrabIt] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [GrabIt] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [GrabIt] SET ARITHABORT OFF 
GO
ALTER DATABASE [GrabIt] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [GrabIt] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [GrabIt] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [GrabIt] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [GrabIt] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [GrabIt] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [GrabIt] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [GrabIt] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [GrabIt] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [GrabIt] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [GrabIt] SET  DISABLE_BROKER 
GO
ALTER DATABASE [GrabIt] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [GrabIt] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [GrabIt] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [GrabIt] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [GrabIt] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [GrabIt] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [GrabIt] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [GrabIt] SET RECOVERY FULL 
GO
ALTER DATABASE [GrabIt] SET  MULTI_USER 
GO
ALTER DATABASE [GrabIt] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [GrabIt] SET DB_CHAINING OFF 
GO
ALTER DATABASE [GrabIt] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [GrabIt] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
EXEC sys.sp_db_vardecimal_storage_format N'GrabIt', N'ON'
GO
USE [GrabIt]
GO
/****** Object:  StoredProcedure [dbo].[GetProcessesByDate]    Script Date: 28/10/2014 17:41:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetProcessesByDate]
	-- Add the parameters for the stored procedure here
	@Date NVARCHAR(10) 
AS
BEGIN
	IF @Date = ''
	BEGIN
	  SET  @Date = REPLACE(CONVERT(NVARCHAR(10), GETDATE(), 101), '/', '-')  
	END
	ELSE
		SET @Date = REPLACE(CONVERT(NVARCHAR(10),CONVERT(smalldatetime, REPLACE(@Date, '-', '/'), 103), 101), '/', '-')  
		
	SELECT TOP 1000 [ProcessID]
      ,[Shift]
      ,[Date]
      ,[StartTime]
      ,[EndTime]
      ,[Desc]
      ,[UserName]
  FROM [GrabIt].[dbo].[ProcessesView]
	  WHERE [Date] = RTRIM(LTRIM(@Date))  

END

GO
/****** Object:  StoredProcedure [dbo].[GetProcessesByDates]    Script Date: 28/10/2014 17:41:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetProcessesByDates]
	@Date NVARCHAR(10) 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

   IF @Date = ''
	BEGIN
	  SET  @Date = REPLACE(CONVERT(NVARCHAR(10), GETDATE(), 101), '/', '-')  
	END
	ELSE
		SET @Date = REPLACE(CONVERT(NVARCHAR(10),CONVERT(smalldatetime, REPLACE(@Date, '-', '/'), 103), 101), '/', '-')  
		
	SELECT TOP 1000 [ProcessID]
      ,[Shift]
      ,[Date]
      ,[StartTime]
      ,[EndTime]
      ,[Desc]
      ,[UserName]
  FROM [GrabIt].[dbo].[ProcessesView]
	  WHERE [Date] = RTRIM(LTRIM(@Date))  
END

GO
/****** Object:  Table [dbo].[__MigrationHistory]    Script Date: 28/10/2014 17:41:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[__MigrationHistory](
	[MigrationId] [nvarchar](150) NOT NULL,
	[ContextKey] [nvarchar](300) NOT NULL,
	[Model] [varbinary](max) NOT NULL,
	[ProductVersion] [nvarchar](32) NOT NULL,
 CONSTRAINT [PK_dbo.__MigrationHistory] PRIMARY KEY CLUSTERED 
(
	[MigrationId] ASC,
	[ContextKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[AspNetRoles]    Script Date: 28/10/2014 17:41:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetRoles](
	[Id] [nvarchar](128) NOT NULL,
	[Name] [nvarchar](256) NOT NULL,
 CONSTRAINT [PK_dbo.AspNetRoles] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AspNetUserClaims]    Script Date: 28/10/2014 17:41:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserClaims](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [nvarchar](128) NOT NULL,
	[ClaimType] [nvarchar](max) NULL,
	[ClaimValue] [nvarchar](max) NULL,
 CONSTRAINT [PK_dbo.AspNetUserClaims] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AspNetUserLogins]    Script Date: 28/10/2014 17:41:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserLogins](
	[LoginProvider] [nvarchar](128) NOT NULL,
	[ProviderKey] [nvarchar](128) NOT NULL,
	[UserId] [nvarchar](128) NOT NULL,
 CONSTRAINT [PK_dbo.AspNetUserLogins] PRIMARY KEY CLUSTERED 
(
	[LoginProvider] ASC,
	[ProviderKey] ASC,
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AspNetUserRoles]    Script Date: 28/10/2014 17:41:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserRoles](
	[UserId] [nvarchar](128) NOT NULL,
	[RoleId] [nvarchar](128) NOT NULL,
 CONSTRAINT [PK_dbo.AspNetUserRoles] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC,
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AspNetUsers]    Script Date: 28/10/2014 17:41:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUsers](
	[Id] [nvarchar](128) NOT NULL,
	[Hometown] [nvarchar](max) NULL,
	[Email] [nvarchar](256) NULL,
	[EmailConfirmed] [bit] NOT NULL,
	[PasswordHash] [nvarchar](max) NULL,
	[SecurityStamp] [nvarchar](max) NULL,
	[PhoneNumber] [nvarchar](max) NULL,
	[PhoneNumberConfirmed] [bit] NOT NULL,
	[TwoFactorEnabled] [bit] NOT NULL,
	[LockoutEndDateUtc] [datetime] NULL,
	[LockoutEnabled] [bit] NOT NULL,
	[AccessFailedCount] [int] NOT NULL,
	[UserName] [nvarchar](256) NOT NULL,
 CONSTRAINT [PK_dbo.AspNetUsers] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CATEGORIES]    Script Date: 28/10/2014 17:41:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CATEGORIES](
	[CategoryID] [int] IDENTITY(1,1) NOT NULL,
	[Desc] [nchar](50) NULL,
 CONSTRAINT [PK_CATEGORIES] PRIMARY KEY CLUSTERED 
(
	[CategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[MEASUREMENTLINK]    Script Date: 28/10/2014 17:41:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MEASUREMENTLINK](
	[ProcessTypeID] [int] NOT NULL,
	[MeasurementTypeID] [int] NOT NULL,
	[LowerLimit] [float] NULL,
	[UpperLimit] [float] NULL,
 CONSTRAINT [PK_MEASUREMENTLINK] PRIMARY KEY CLUSTERED 
(
	[ProcessTypeID] ASC,
	[MeasurementTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[MEASUREMENTS]    Script Date: 28/10/2014 17:41:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MEASUREMENTS](
	[MeasurementID] [int] IDENTITY(1,1) NOT NULL,
	[ProcessID] [int] NOT NULL,
	[MeasurementTypeID] [int] NOT NULL,
	[Value] [float] NOT NULL,
 CONSTRAINT [PK_MEASUREMENTS] PRIMARY KEY CLUSTERED 
(
	[MeasurementID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[MEASUREMENTTYPES]    Script Date: 28/10/2014 17:41:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MEASUREMENTTYPES](
	[MeasurementTypeID] [int] IDENTITY(1,1) NOT NULL,
	[Desc] [nchar](50) NOT NULL,
	[CategoryID] [int] NOT NULL,
	[ProcessTypeID] [int] NOT NULL,
 CONSTRAINT [PK_MEASUREMENTTYPES] PRIMARY KEY CLUSTERED 
(
	[MeasurementTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PROCESSCATEGORIES]    Script Date: 28/10/2014 17:41:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PROCESSCATEGORIES](
	[ProcessCategoryID] [int] IDENTITY(1,1) NOT NULL,
	[Desc] [nchar](50) NULL,
 CONSTRAINT [PK_PROCESSCATEGORIES] PRIMARY KEY CLUSTERED 
(
	[ProcessCategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PROCESSES]    Script Date: 28/10/2014 17:41:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PROCESSES](
	[ProcessID] [int] IDENTITY(1,1) NOT NULL,
	[ShiftTypeID] [int] NOT NULL,
	[Date] [date] NOT NULL,
	[StartTime] [nchar](10) NOT NULL,
	[EndTime] [nchar](10) NOT NULL,
	[ProcessTypeID] [int] NOT NULL,
	[UserID] [int] NOT NULL,
 CONSTRAINT [PK_PROCESSES] PRIMARY KEY CLUSTERED 
(
	[ProcessID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PROCESSLINK]    Script Date: 28/10/2014 17:41:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PROCESSLINK](
	[ProcessCategoryID] [int] NOT NULL,
	[ProcessTypeID] [int] NOT NULL,
 CONSTRAINT [PK_PROCESSLINK] PRIMARY KEY CLUSTERED 
(
	[ProcessCategoryID] ASC,
	[ProcessTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PROCESSTYPES]    Script Date: 28/10/2014 17:41:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PROCESSTYPES](
	[ProcessTypeID] [int] IDENTITY(1,1) NOT NULL,
	[Desc] [nchar](50) NULL,
	[ProcessCategoryID] [int] NOT NULL,
 CONSTRAINT [PK_PROCESSTYPES] PRIMARY KEY CLUSTERED 
(
	[ProcessTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[SHIFTTYPES]    Script Date: 28/10/2014 17:41:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SHIFTTYPES](
	[ShiftTypeID] [int] IDENTITY(1,1) NOT NULL,
	[Desc] [nchar](50) NULL,
 CONSTRAINT [PK_SHIFTTYPES] PRIMARY KEY CLUSTERED 
(
	[ShiftTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[USERS]    Script Date: 28/10/2014 17:41:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[USERS](
	[UserID] [int] IDENTITY(1,1) NOT NULL,
	[UserName] [nchar](50) NOT NULL,
	[Password] [nchar](100) NULL,
 CONSTRAINT [PK_USERS] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  View [dbo].[ProcessesView]    Script Date: 28/10/2014 17:41:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[ProcessesView]
AS
SELECT        pros.ProcessID, shifts.[Desc] AS Shift, pros.Date, pros.StartTime, pros.EndTime, protyp.[Desc], usr.UserName
FROM            dbo.PROCESSES AS pros INNER JOIN
                         dbo.SHIFTTYPES AS shifts ON pros.ShiftTypeID = shifts.ShiftTypeID INNER JOIN
                         dbo.PROCESSTYPES AS protyp ON pros.ProcessTypeID = protyp.ProcessTypeID INNER JOIN
                         dbo.USERS AS usr ON pros.UserID = usr.UserID

GO
INSERT [dbo].[__MigrationHistory] ([MigrationId], [ContextKey], [Model], [ProductVersion]) VALUES (N'201410262020183_init', N'GrabIt.Migrations.Configuration', 0x1F8B0800000000000400DD5CDB6EDC36107D2FD07F10F4D416EECA9726488DDD04EEDA6E8DC617649DA26F0157E2AE8548942A518E8DA25FD6877E527FA1A4445D7893A85DEDC54580C022876786C321391C0EF7DFBFFF19BF7B0A03EB1126A91FA1897D343AB42D88DCC8F3D172626778F1FD1BFBDDDBAFBF1A5F78E193F55B497742E9484B944EEC078CE353C749DD0718827414FA6E12A5D1028FDC2874801739C787873F3A47470E241036C1B2ACF1870C613F84F907F99C46C88531CE40701D7930485939A999E5A8D60D08611A03174EEC9F1330BFC2A382D0B6CE021F1021663058D8164028C20013114F3FA6708693082D67312900C1FD730C09DD02042964A29FD6E4A6BD383CA6BD70EA8625949BA5380A7B021E9D30B53862F395946B576A238ABB200AC6CFB4D7B9F226F69507F3A20F51401420323C9D0609259ED8D7158BB334BE817854361C1590970981FB12259F474DC403CBB8DD416546C7A343FAEFC09A6601CE12384130C309080EACBB6C1EF8EEAFF0F93EFA0CD1E4E468BE3879F3EA35F04E5EFF004F5E357B4AFA4AE8B80252749744314C886C7051F5DFB61CBE9D2336AC9A35DA145A21B64466846D5D83A7F7102DF103992BC76F6CEBD27F825E59C28CEB23F2C904228D709291CF9B2C08C03C8055BDD3CA93FEDFC2F5F8D5EB41B8DE80477F990FBDC09F4C9C84CCAB0F30C86BD3073F2EA61737DE9F18D9651285F49BB7AFA2F6D32CCA12977626D292DC836409312FDDD8A98DD7C8A429D4F0665DA2EEBF69534965F35692D20EAD32134A16DB9E0DA5BC9BE56B6C7167714C062F372DAA913683E3F6A991D0F0C02AAA6B8339323518443AF27F5EFF7E894288A32FA88533F9D388733BA38B10F8C1002BAD0117E2DF2CFC2484953A7F8A885D03D45B3977204DC942E3FD02D2878D2B6806DD2C21F63FC3208C37CEEDEE2142F0260BE7745A6D8FD7604373FF25BA042E8E920B445BAD8DF73E723F4719BE40DE39C0F023764B40FA79EF87E600838873E6BA304D2F8931436F1A11F7BD04BC42F8E4B8371C5D0477EDE94C03E0876A574758AE3F95A4B5BBA3A6905C1E0D99CAED6913F57DB4F49199A825A95ED482A2535446D657540A662629A3D40B9A1374CA59500DE648E62334BC2799C3EEBF2BB99E97A05B0B1A6A9C911512FE0C114CC832E6DD018C6182EA1130593776E195E4C347996E7C6FCA39FD06826C68562BCD867C11187E36E4B0FB3F1B723149F1A3EF51AFC4E07C55121378237AF5D1AD7BCE09926D7B3A70DDDC36F3EDAC01BAE97296A691EBE7B34011596371115E7EE2C359DD4192A23762A085748C18BA4FB73C5242FA668B46758BCE610031B4CEDC22F23805A90B3C598DA4435E0FC1CA1D5521581D70E185FB4EE2492C1D26B411A087A094CC541F61795AF8C8F56310746A496869B885D1BE573CC49A7318434419766AC284B93ABE4205A8F80883D2A5A1B1D3B0B87643D478ADBA31EF7261EB7197C21E5BB1C90EDF596397CC7FDB8861B66B6C0BC6D9AE121301B4B1C25D18283BAB981A807870D93703154E4C1A03652ED5560C94D7D80E0C9457C98B33D0E2886A3AFEC27975DFCC933F286F7F5B6F55D70E6C93D3C79E9966E17B923698B480896C9EE7735A099FB0E27046E464E7B394B9BAA28950F019C47CC8A6F677957EA8D30E221A511B606D681DA0EC9651029226540FE1CA585EAB74CC8BE8015BC6DD5A61D9DA2FC0366C40C66EDEB63608F577B2A2711A9D3EAA9E55D62019B9D161A181A3300871F1E23B6EA0145D5C56568C892FDCC71B6E748C0D468B823A3C578D92CACE0CAEA5D234BBB5A472C8FAB8646B6949709F345A2A3B33B896988D762B49E114F4700BD65211BF850F34D9CA4847B5DB547563A7C8BF6205634793A835BE0671ECA36523718B9558B3226B6BFAFDAC7F4E535860386EAA486DAAA4AD38E128014B28D412D644D24B3F49F139C0600E689C67EA851299726FD52CFF25CBE6F6290F62B90F94D4F4EFA2059F1BC06DB3B21FC29A5F92CE85D499C923E88AA15737B7680E1D0840A208DA4FA3200B91DEB7D2B72EAEEE9AED8B121961EC08F24BBE93A428C9C3E5B56E3426F27C587F7C2AAF65F531D243E8345DFA9C4D5DEBFC503D4A19966AA2E842553B1B339DFB623A4EA253D87F983A1136339BEA949726465D6A8EC4725A9A30ACA82746232D42026BD499A3F2992B4D4CBEC61C51484F69420A553DA46C26A17042362B56C2D368544D61CE414E3B69A2CBB5E6C88A049426B4A27A056C85CC629D39AA2247A509ACA836C7AE1356C495788F773EEDA16795ADAF3812AFB7F7693036B3AC0EB375366EFE9B408DE29E58EC6E5F0263E57B6948DA73E12A86540441D633240D867EBDE1AECBF9E5A6F58E5F8FC9DD81734B7A5B0E801EAF9FB96ED428A413A1485271AF4E86C20970CC4E63DDEF79A4E35941625BA51AC976FE9C62188E28C168F647300D7C4817EF92E01A207F01535CE47DD8C78747C7C2BBA0FD79A3E3A4A917284EB3BA873AFC986D21850B3D82C47D00899C50B1C63B961A548A555F210F3E4DEC3FF356A779D883FE95171F5857E947E4FF91918AFB2483D65F7282E83079FDEDE7B33D7D8561AED5ABDF3F154D0FACDB84CC9853EB50D0E52A23CCBFCDE8254DD1740D69567EB1F1722794F830A204FE26044FDF36D17A3F7E508A28CCAED5DF3ACC7D3CC83B87B5FAAB7CCBB016A2E2BDC2507883A850F71E61152CED5B048F7CE2FC2D42BFCEAADF26AC229AF65D828FFA8389AF12CCD7B4B2E50EF72DC5D96A1BEB5BAEE7CEACEEB5523C77BDD149C9DF6B4D7439C1BB07DC1A49DC2B58C60BCB7F1E6CAB55A4370F86BD4BD3DE784EF3BEA431D70926BBCD5EDE66C272CBF5D4FF2A4F790F32EB149942BBCF46DEB6ADE9E2C17B9ED2D92FE778CF8C8DE58FED3EB378DBC6A68B19EFB9B1F5CA1FDE335BDBD5FEB9634B33DE42779E0D2C273669EE755481E5AE6CDF220A4F4EF8F3881841E151168F34D5E9656DA9B11D0C6B123D537D5E9BC8589A38125F89A29D6DBFBEB20DBFB5B38CA69DAD261BB48D375BFF5B79339A76DE9A1CCB5DE4292BB31C55B9E31DEB585B32D64BCA4BE67AD29106DFE5B3B65ED2BFA434E44194C2CD1ECD85F3CBC93A1E4425434E9D1E59C6F2DD31D93B1BBF1849F6EFD45FD610F4F7231174B95DB3A2B9428BA8DCBC05894A122142730D31F0C8967A96607F015C4CAA698C397F659EC7EDE84DC71C7A57E836C37186499761380FB880177502DAF8E7A9D4BCCCE3DB38FFC19421BA40C4F4696CFE16FD94F98157C97DA988096920A877C122BA742C318DEC2E9F2BA49B08190231F5554ED13D0CE38080A5B768061EE12AB211F37B0F97C07DAE23803A90EE81E0D53E3EF7C1320161CA30EAF6E493D8B0173EBDFD0F27351DA938550000, N'6.1.1-30610')
INSERT [dbo].[AspNetUsers] ([Id], [Hometown], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName]) VALUES (N'd73741f3-41f5-4c2c-9703-395514a9c652', N'Ipswich', N'nicobec@gmail.com', 0, N'AElJKsCfuTkZL042JIRPq2p175oxFRsYRo6IGA8aW0P/rE/k6lOZmacKzx5Nvi9G1w==', N'039d1d53-6e76-4cbd-b817-d9d35c18c2f8', NULL, 0, 0, NULL, 1, 0, N'nicobec@gmail.com')
SET IDENTITY_INSERT [dbo].[CATEGORIES] ON 

INSERT [dbo].[CATEGORIES] ([CategoryID], [Desc]) VALUES (1, N'CABEÇA                                            ')
INSERT [dbo].[CATEGORIES] ([CategoryID], [Desc]) VALUES (2, N'MAGNÉTICO                                         ')
INSERT [dbo].[CATEGORIES] ([CategoryID], [Desc]) VALUES (3, N'Granulometria - (%) Retido Simples (mm)           ')
SET IDENTITY_INSERT [dbo].[CATEGORIES] OFF
SET IDENTITY_INSERT [dbo].[MEASUREMENTTYPES] ON 

INSERT [dbo].[MEASUREMENTTYPES] ([MeasurementTypeID], [Desc], [CategoryID], [ProcessTypeID]) VALUES (3, N'%V2O5                                             ', 1, 3)
INSERT [dbo].[MEASUREMENTTYPES] ([MeasurementTypeID], [Desc], [CategoryID], [ProcessTypeID]) VALUES (4, N'%SiO2                                             ', 1, 3)
INSERT [dbo].[MEASUREMENTTYPES] ([MeasurementTypeID], [Desc], [CategoryID], [ProcessTypeID]) VALUES (5, N'%Al2O3                                            ', 1, 3)
INSERT [dbo].[MEASUREMENTTYPES] ([MeasurementTypeID], [Desc], [CategoryID], [ProcessTypeID]) VALUES (6, N'%Fe                                               ', 1, 3)
INSERT [dbo].[MEASUREMENTTYPES] ([MeasurementTypeID], [Desc], [CategoryID], [ProcessTypeID]) VALUES (8, N'%TiO2                                             ', 1, 3)
INSERT [dbo].[MEASUREMENTTYPES] ([MeasurementTypeID], [Desc], [CategoryID], [ProcessTypeID]) VALUES (9, N'%CaO                                              ', 1, 3)
INSERT [dbo].[MEASUREMENTTYPES] ([MeasurementTypeID], [Desc], [CategoryID], [ProcessTypeID]) VALUES (10, N'MAG (%)                                           ', 2, 3)
INSERT [dbo].[MEASUREMENTTYPES] ([MeasurementTypeID], [Desc], [CategoryID], [ProcessTypeID]) VALUES (11, N'%V2O5                                             ', 2, 3)
INSERT [dbo].[MEASUREMENTTYPES] ([MeasurementTypeID], [Desc], [CategoryID], [ProcessTypeID]) VALUES (12, N'%SiO2                                             ', 2, 3)
INSERT [dbo].[MEASUREMENTTYPES] ([MeasurementTypeID], [Desc], [CategoryID], [ProcessTypeID]) VALUES (13, N'%Al2O3                                            ', 2, 3)
INSERT [dbo].[MEASUREMENTTYPES] ([MeasurementTypeID], [Desc], [CategoryID], [ProcessTypeID]) VALUES (14, N'%Fe                                               ', 2, 3)
INSERT [dbo].[MEASUREMENTTYPES] ([MeasurementTypeID], [Desc], [CategoryID], [ProcessTypeID]) VALUES (15, N'%TiO2                                             ', 2, 3)
INSERT [dbo].[MEASUREMENTTYPES] ([MeasurementTypeID], [Desc], [CategoryID], [ProcessTypeID]) VALUES (16, N'%CaO                                              ', 2, 3)
INSERT [dbo].[MEASUREMENTTYPES] ([MeasurementTypeID], [Desc], [CategoryID], [ProcessTypeID]) VALUES (17, N'>9,50                                             ', 3, 3)
INSERT [dbo].[MEASUREMENTTYPES] ([MeasurementTypeID], [Desc], [CategoryID], [ProcessTypeID]) VALUES (18, N'>4,75                                             ', 3, 3)
INSERT [dbo].[MEASUREMENTTYPES] ([MeasurementTypeID], [Desc], [CategoryID], [ProcessTypeID]) VALUES (19, N'>1,00                                             ', 3, 3)
INSERT [dbo].[MEASUREMENTTYPES] ([MeasurementTypeID], [Desc], [CategoryID], [ProcessTypeID]) VALUES (20, N'> 0,85                                            ', 3, 3)
INSERT [dbo].[MEASUREMENTTYPES] ([MeasurementTypeID], [Desc], [CategoryID], [ProcessTypeID]) VALUES (21, N'>0,60                                             ', 3, 3)
INSERT [dbo].[MEASUREMENTTYPES] ([MeasurementTypeID], [Desc], [CategoryID], [ProcessTypeID]) VALUES (22, N'>0,30                                             ', 3, 3)
INSERT [dbo].[MEASUREMENTTYPES] ([MeasurementTypeID], [Desc], [CategoryID], [ProcessTypeID]) VALUES (23, N'<0,30                                             ', 3, 3)
INSERT [dbo].[MEASUREMENTTYPES] ([MeasurementTypeID], [Desc], [CategoryID], [ProcessTypeID]) VALUES (24, N'%Umidade                                          ', 3, 3)
SET IDENTITY_INSERT [dbo].[MEASUREMENTTYPES] OFF
SET IDENTITY_INSERT [dbo].[PROCESSCATEGORIES] ON 

INSERT [dbo].[PROCESSCATEGORIES] ([ProcessCategoryID], [Desc]) VALUES (1, N'MOAGEM                                            ')
INSERT [dbo].[PROCESSCATEGORIES] ([ProcessCategoryID], [Desc]) VALUES (2, N'SEPARADOR MAGNETICO
                             ')
INSERT [dbo].[PROCESSCATEGORIES] ([ProcessCategoryID], [Desc]) VALUES (3, N'FORNO
                                           ')
INSERT [dbo].[PROCESSCATEGORIES] ([ProcessCategoryID], [Desc]) VALUES (4, N'LIXIVIAÇÃO                                        ')
INSERT [dbo].[PROCESSCATEGORIES] ([ProcessCategoryID], [Desc]) VALUES (5, N'REMOÇÃO SE SÍLICA                                 ')
INSERT [dbo].[PROCESSCATEGORIES] ([ProcessCategoryID], [Desc]) VALUES (6, N'PRECIPITAÇÃO                                      ')
INSERT [dbo].[PROCESSCATEGORIES] ([ProcessCategoryID], [Desc]) VALUES (7, N'EVAPORAÇÃO                                        ')
INSERT [dbo].[PROCESSCATEGORIES] ([ProcessCategoryID], [Desc]) VALUES (8, N'V2O5 - FINAL                                      ')
SET IDENTITY_INSERT [dbo].[PROCESSCATEGORIES] OFF
SET IDENTITY_INSERT [dbo].[PROCESSES] ON 

INSERT [dbo].[PROCESSES] ([ProcessID], [ShiftTypeID], [Date], [StartTime], [EndTime], [ProcessTypeID], [UserID]) VALUES (2, 1, CAST(0x2D390B00 AS Date), N'06:12     ', N'11:15     ', 3, 1)
INSERT [dbo].[PROCESSES] ([ProcessID], [ShiftTypeID], [Date], [StartTime], [EndTime], [ProcessTypeID], [UserID]) VALUES (4, 2, CAST(0x2D390B00 AS Date), N'14:00     ', N'21:45     ', 3, 1)
SET IDENTITY_INSERT [dbo].[PROCESSES] OFF
SET IDENTITY_INSERT [dbo].[PROCESSTYPES] ON 

INSERT [dbo].[PROCESSTYPES] ([ProcessTypeID], [Desc], [ProcessCategoryID]) VALUES (3, N'AMO (ALIMENTAÇÃO DO MOINHO)                       ', 1)
INSERT [dbo].[PROCESSTYPES] ([ProcessTypeID], [Desc], [ProcessCategoryID]) VALUES (4, N'RFI-350 (REJEITO)                                 ', 1)
INSERT [dbo].[PROCESSTYPES] ([ProcessTypeID], [Desc], [ProcessCategoryID]) VALUES (5, N'CFI-370 (CONCENTRADO)                             ', 1)
SET IDENTITY_INSERT [dbo].[PROCESSTYPES] OFF
SET IDENTITY_INSERT [dbo].[SHIFTTYPES] ON 

INSERT [dbo].[SHIFTTYPES] ([ShiftTypeID], [Desc]) VALUES (1, N'06:00                                             ')
INSERT [dbo].[SHIFTTYPES] ([ShiftTypeID], [Desc]) VALUES (2, N'14:00                                             ')
INSERT [dbo].[SHIFTTYPES] ([ShiftTypeID], [Desc]) VALUES (3, N'22:00                                             ')
SET IDENTITY_INSERT [dbo].[SHIFTTYPES] OFF
SET IDENTITY_INSERT [dbo].[USERS] ON 

INSERT [dbo].[USERS] ([UserID], [UserName], [Password]) VALUES (1, N'nico                                              ', N'something                                                                                           ')
SET IDENTITY_INSERT [dbo].[USERS] OFF
SET ANSI_PADDING ON

GO
/****** Object:  Index [RoleNameIndex]    Script Date: 28/10/2014 17:41:29 ******/
CREATE UNIQUE NONCLUSTERED INDEX [RoleNameIndex] ON [dbo].[AspNetRoles]
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_UserId]    Script Date: 28/10/2014 17:41:29 ******/
CREATE NONCLUSTERED INDEX [IX_UserId] ON [dbo].[AspNetUserClaims]
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_UserId]    Script Date: 28/10/2014 17:41:29 ******/
CREATE NONCLUSTERED INDEX [IX_UserId] ON [dbo].[AspNetUserLogins]
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_RoleId]    Script Date: 28/10/2014 17:41:29 ******/
CREATE NONCLUSTERED INDEX [IX_RoleId] ON [dbo].[AspNetUserRoles]
(
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_UserId]    Script Date: 28/10/2014 17:41:29 ******/
CREATE NONCLUSTERED INDEX [IX_UserId] ON [dbo].[AspNetUserRoles]
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UserNameIndex]    Script Date: 28/10/2014 17:41:29 ******/
CREATE UNIQUE NONCLUSTERED INDEX [UserNameIndex] ON [dbo].[AspNetUsers]
(
	[UserName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[AspNetUserClaims]  WITH CHECK ADD  CONSTRAINT [FK_dbo.AspNetUserClaims_dbo.AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserClaims] CHECK CONSTRAINT [FK_dbo.AspNetUserClaims_dbo.AspNetUsers_UserId]
GO
ALTER TABLE [dbo].[AspNetUserLogins]  WITH CHECK ADD  CONSTRAINT [FK_dbo.AspNetUserLogins_dbo.AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserLogins] CHECK CONSTRAINT [FK_dbo.AspNetUserLogins_dbo.AspNetUsers_UserId]
GO
ALTER TABLE [dbo].[AspNetUserRoles]  WITH CHECK ADD  CONSTRAINT [FK_dbo.AspNetUserRoles_dbo.AspNetRoles_RoleId] FOREIGN KEY([RoleId])
REFERENCES [dbo].[AspNetRoles] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserRoles] CHECK CONSTRAINT [FK_dbo.AspNetUserRoles_dbo.AspNetRoles_RoleId]
GO
ALTER TABLE [dbo].[AspNetUserRoles]  WITH CHECK ADD  CONSTRAINT [FK_dbo.AspNetUserRoles_dbo.AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserRoles] CHECK CONSTRAINT [FK_dbo.AspNetUserRoles_dbo.AspNetUsers_UserId]
GO
ALTER TABLE [dbo].[MEASUREMENTLINK]  WITH CHECK ADD  CONSTRAINT [FK_MEASUREMENTLINK_MEASUREMENTTYPES] FOREIGN KEY([MeasurementTypeID])
REFERENCES [dbo].[MEASUREMENTTYPES] ([MeasurementTypeID])
GO
ALTER TABLE [dbo].[MEASUREMENTLINK] CHECK CONSTRAINT [FK_MEASUREMENTLINK_MEASUREMENTTYPES]
GO
ALTER TABLE [dbo].[MEASUREMENTLINK]  WITH CHECK ADD  CONSTRAINT [FK_MEASUREMENTLINK_PROCESSTYPES] FOREIGN KEY([ProcessTypeID])
REFERENCES [dbo].[PROCESSTYPES] ([ProcessTypeID])
GO
ALTER TABLE [dbo].[MEASUREMENTLINK] CHECK CONSTRAINT [FK_MEASUREMENTLINK_PROCESSTYPES]
GO
ALTER TABLE [dbo].[MEASUREMENTS]  WITH CHECK ADD  CONSTRAINT [FK_MEASUREMENTS_MEASUREMENTTYPES] FOREIGN KEY([MeasurementTypeID])
REFERENCES [dbo].[MEASUREMENTTYPES] ([MeasurementTypeID])
GO
ALTER TABLE [dbo].[MEASUREMENTS] CHECK CONSTRAINT [FK_MEASUREMENTS_MEASUREMENTTYPES]
GO
ALTER TABLE [dbo].[MEASUREMENTS]  WITH CHECK ADD  CONSTRAINT [FK_MEASUREMENTS_PROCESSES] FOREIGN KEY([ProcessID])
REFERENCES [dbo].[PROCESSES] ([ProcessID])
GO
ALTER TABLE [dbo].[MEASUREMENTS] CHECK CONSTRAINT [FK_MEASUREMENTS_PROCESSES]
GO
ALTER TABLE [dbo].[MEASUREMENTTYPES]  WITH CHECK ADD  CONSTRAINT [FK_MEASUREMENTTYPES_CATEGORIES] FOREIGN KEY([CategoryID])
REFERENCES [dbo].[CATEGORIES] ([CategoryID])
GO
ALTER TABLE [dbo].[MEASUREMENTTYPES] CHECK CONSTRAINT [FK_MEASUREMENTTYPES_CATEGORIES]
GO
ALTER TABLE [dbo].[MEASUREMENTTYPES]  WITH CHECK ADD  CONSTRAINT [FK_MEASUREMENTTYPES_PROCESSTYPES] FOREIGN KEY([ProcessTypeID])
REFERENCES [dbo].[PROCESSTYPES] ([ProcessTypeID])
GO
ALTER TABLE [dbo].[MEASUREMENTTYPES] CHECK CONSTRAINT [FK_MEASUREMENTTYPES_PROCESSTYPES]
GO
ALTER TABLE [dbo].[PROCESSES]  WITH CHECK ADD  CONSTRAINT [FK_PROCESSES_PROCESSTYPES] FOREIGN KEY([ProcessTypeID])
REFERENCES [dbo].[PROCESSTYPES] ([ProcessTypeID])
GO
ALTER TABLE [dbo].[PROCESSES] CHECK CONSTRAINT [FK_PROCESSES_PROCESSTYPES]
GO
ALTER TABLE [dbo].[PROCESSES]  WITH CHECK ADD  CONSTRAINT [FK_PROCESSES_SHIFTTYPES] FOREIGN KEY([ShiftTypeID])
REFERENCES [dbo].[SHIFTTYPES] ([ShiftTypeID])
GO
ALTER TABLE [dbo].[PROCESSES] CHECK CONSTRAINT [FK_PROCESSES_SHIFTTYPES]
GO
ALTER TABLE [dbo].[PROCESSES]  WITH CHECK ADD  CONSTRAINT [FK_PROCESSES_USERS] FOREIGN KEY([UserID])
REFERENCES [dbo].[USERS] ([UserID])
GO
ALTER TABLE [dbo].[PROCESSES] CHECK CONSTRAINT [FK_PROCESSES_USERS]
GO
ALTER TABLE [dbo].[PROCESSLINK]  WITH CHECK ADD  CONSTRAINT [FK_PROCESSLINK_PROCESSCATEGORIES] FOREIGN KEY([ProcessCategoryID])
REFERENCES [dbo].[PROCESSCATEGORIES] ([ProcessCategoryID])
GO
ALTER TABLE [dbo].[PROCESSLINK] CHECK CONSTRAINT [FK_PROCESSLINK_PROCESSCATEGORIES]
GO
ALTER TABLE [dbo].[PROCESSLINK]  WITH CHECK ADD  CONSTRAINT [FK_PROCESSLINK_PROCESSTYPES] FOREIGN KEY([ProcessTypeID])
REFERENCES [dbo].[PROCESSTYPES] ([ProcessTypeID])
GO
ALTER TABLE [dbo].[PROCESSLINK] CHECK CONSTRAINT [FK_PROCESSLINK_PROCESSTYPES]
GO
ALTER TABLE [dbo].[PROCESSTYPES]  WITH CHECK ADD  CONSTRAINT [FK_PROCESSTYPES_PROCESSCATEGORIES] FOREIGN KEY([ProcessCategoryID])
REFERENCES [dbo].[PROCESSCATEGORIES] ([ProcessCategoryID])
GO
ALTER TABLE [dbo].[PROCESSTYPES] CHECK CONSTRAINT [FK_PROCESSTYPES_PROCESSCATEGORIES]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "pros"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 135
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "shifts"
            Begin Extent = 
               Top = 6
               Left = 246
               Bottom = 101
               Right = 416
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "protyp"
            Begin Extent = 
               Top = 6
               Left = 454
               Bottom = 118
               Right = 642
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "usr"
            Begin Extent = 
               Top = 6
               Left = 680
               Bottom = 118
               Right = 850
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ProcessesView'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ProcessesView'
GO
USE [master]
GO
ALTER DATABASE [GrabIt] SET  READ_WRITE 
GO
