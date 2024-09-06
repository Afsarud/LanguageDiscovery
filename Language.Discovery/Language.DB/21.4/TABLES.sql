

/****** Object:  Table [dbo].[Schedule]    Script Date: 3/28/2021 2:36:08 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Schedule](
	[ScheduleId] [int] IDENTITY(1,1) NOT NULL,
	[Schedule] [datetime] NOT NULL,
	[UserId] [bigint] NOT NULL,
	[PartnerId] [bigint] NULL,
	[CreateDate] [datetime] NOT NULL
) ON [PRIMARY]
GO



USE [Palaygo.11222018]
GO

/****** Object:  Table [dbo].[TimeScheduleAux]    Script Date: 3/28/2021 2:36:22 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[TimeScheduleAux](
	[TimeId] [int] IDENTITY(1,1) NOT NULL,
	[TimeSchedule] [nvarchar](50) NOT NULL,
	[Active] [bit] NOT NULL,
	[MaxSlot] [int] NOT NULL
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[TimeScheduleAux] ADD  CONSTRAINT [DF_TimeScheduleAux_Active]  DEFAULT ((0)) FOR [Active]
GO



alter table [User]
add NumberOfMatching int default(0),
	MatchingFrequency nvarchar(20)