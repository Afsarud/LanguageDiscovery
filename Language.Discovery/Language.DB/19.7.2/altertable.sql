alter table [user]
add IsCanTalk bit default(0)

CREATE TABLE [dbo].[ConferenceRoom](
	[ConferenceRoomID] [int] IDENTITY(1,1) NOT NULL,
	[RoomName] [nvarchar](250) NOT NULL,
	[Caller] [nvarchar](100) NOT NULL,
	[Callee] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_ConferenceRoom] PRIMARY KEY CLUSTERED 
(
	[ConferenceRoomID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO


