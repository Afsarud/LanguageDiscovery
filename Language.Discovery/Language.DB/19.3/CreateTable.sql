SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[UserSavedMessage](
	[UserSavedMessageId] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [bigint] NULL,
	[CreateDate] [datetime] NULL,
	[LearningMessage] [nvarchar](max) NULL,
	[NativeMessage] [nvarchar](max) NULL,
	[OtherLanguageMessage] [nvarchar](max) NULL,
 CONSTRAINT [PK_UserSavedMessage] PRIMARY KEY CLUSTERED 
(
	[UserSavedMessageId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

