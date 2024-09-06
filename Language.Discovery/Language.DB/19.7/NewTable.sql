
/****** Object:  Table [dbo].[UserTalkSubscription]    Script Date: 06/15/2019 5:58:55 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[UserTalkSubscription](
	[UserTalkSubscriptionID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [bigint] NULL,
	[SessionTime] [int] NULL,
	[BalanceTime] [int] NULL,
	[TotalTime] [int] NULL,
	[CreateDate] [datetime] NULL,
	[IsActive] [bit] NULL,
 CONSTRAINT [PK_UserTalkSubscription] PRIMARY KEY CLUSTERED 
(
	[UserTalkSubscriptionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[UserTalkSubscription] ADD  DEFAULT ((0)) FOR [IsActive]
GO


SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[UserTalkHistory](
	[UserTalkHistoryID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [bigint] NULL,
	[StartDate] [datetime] NULL,
	[EndDate] [datetime] NULL,
	[TimeSpent] [int] NULL,
	[PartnerUserID] [bigint] NULL,
 CONSTRAINT [PK_UserTalkHistory] PRIMARY KEY CLUSTERED 
(
	[UserTalkHistoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO


