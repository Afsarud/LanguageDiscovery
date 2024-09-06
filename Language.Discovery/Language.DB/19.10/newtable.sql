USE [Palaygo.11222018]
GO

/****** Object:  Table [dbo].[UserRank]    Script Date: 10/28/2019 10:02:38 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[UserRank](
	[UserRankID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [bigint] NOT NULL,
	[Multiplier] [int] NOT NULL,
	[StarCount] [int] NOT NULL,
	[MessageCount] [int] NOT NULL,
	[Points] [int] NOT NULL,
 CONSTRAINT [PK_UserRank] PRIMARY KEY CLUSTERED 
(
	[UserRankID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[UserRank] ADD  CONSTRAINT [DF_UserRank_Multiplier]  DEFAULT ((0)) FOR [Multiplier]
GO

ALTER TABLE [dbo].[UserRank] ADD  CONSTRAINT [DF_UserRank_LikeCount]  DEFAULT ((0)) FOR [StarCount]
GO

ALTER TABLE [dbo].[UserRank] ADD  CONSTRAINT [DF_UserRank_MessageCount]  DEFAULT ((0)) FOR [MessageCount]
GO

ALTER TABLE [dbo].[UserRank] ADD  CONSTRAINT [DF_UserRank_Points]  DEFAULT ((0)) FOR [Points]
GO

