USE [Palaygo.11222018]
GO

/****** Object:  Table [dbo].[MyPalette]    Script Date: 9/9/2020 1:49:08 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[MyPalette](
	[MyPaletteID] [bigint] IDENTITY(1,1) NOT NULL,
	[PaletteID] [bigint] NOT NULL,
	[SchoolID] [int] NULL,
	[PhraseCategoryID] [bigint] NULL,
	[CreateDate] [datetime] NOT NULL,
	[CreatedBy] [bigint] NOT NULL,
	[ApprovedDate] [datetime] NULL,
	[ApprovedBy] [bigint] NULL,
	[Approved] [bit] NULL,
	[DefaultLanguageCode] [nvarchar](10) NULL,
	[GroupID] [int] NULL,
	[LanguageCode] [nvarchar](10) NULL,
	[LevelID] [int] NULL,
	[ModifiedDate] [datetime] NULL,
	[ModifiedBy] [bigint] NULL,
	[OrderID] [int] NULL,
	[UserID] [bigint] NULL,
 CONSTRAINT [PK_MyPalette] PRIMARY KEY CLUSTERED 
(
	[MyPaletteID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO



--------------------------------------------



/****** Object:  Table [dbo].[MySentence]    Script Date: 9/9/2020 1:49:26 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[MySentence](
	[MySentenceID] [bigint] IDENTITY(1,1) NOT NULL,
	[SentenceID] [bigint] NOT NULL,
	[PaletteID] [bigint] NULL,
	[CreateDate] [datetime] NOT NULL,
	[CreatedBy] [bigint] NOT NULL,
	[SentenceSoundFile] [nvarchar](50) NULL,
	[SentenceImageFile] [nvarchar](50) NULL,
	[SentenceLanguageCode] [nvarchar](10) NULL,
	[Keyword] [nvarchar](50) NULL,
	[UserID] [bigint] NULL,
 CONSTRAINT [PK_MySentence] PRIMARY KEY CLUSTERED 
(
	[MySentenceID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO




-------------------------------------------

/****** Object:  Table [dbo].[MyPhrase]    Script Date: 9/9/2020 1:49:44 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[MyPhrase](
	[MyPhraseID] [bigint] IDENTITY(1,1) NOT NULL,
	[PhraseID] [bigint] NOT NULL,
	[SentenceID] [bigint] NULL,
	[WordMapID] [bigint] NULL,
	[Word] [nvarchar](50) NOT NULL,
	[Keyword] [nvarchar](50) NULL,
	[PluralForm] [nvarchar](50) NULL,
	[WordSoundFile] [nvarchar](250) NULL,
	[WordImageFile] [nvarchar](250) NULL,
	[Ordinal] [int] NOT NULL,
	[ParentID] [bigint] NULL,
	[WordType] [nvarchar](50) NULL,
	[UserID] [bigint] NULL,
 CONSTRAINT [PK_MyPhrase] PRIMARY KEY CLUSTERED 
(
	[MyPhraseID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

