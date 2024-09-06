USE [Palaygo_04242021]
GO

/****** Object:  Table [dbo].[UserAttendance]    Script Date: 3/10/2022 8:37:54 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[UserOtherPoints](
	[UserOtherPointsId] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NOT NULL,
	[Type] nvarchar(10) NOT NULL,
	[Points] [int] NOT NULL,
	[CreateDate] [datetime] NOT NULL,
 CONSTRAINT [PK_UserOtherPoints] PRIMARY KEY CLUSTERED 
(
	[UserOtherPointsId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO




alter table SchoolInfo
add AllowTalk bit default(0) not null
