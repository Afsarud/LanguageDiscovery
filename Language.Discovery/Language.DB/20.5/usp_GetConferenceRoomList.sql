USE [Palaygo.11222018]
GO
/****** Object:  StoredProcedure [dbo].[usp_GetConferenceRoomList]    Script Date: 5/18/2020 7:20:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure [dbo].[usp_GetConferenceRoomList]
	@SchoolId int = NULL
as
begin

		SELECT * 
		FROM ConferenceRoom 
		where ISNULL(@SchoolId,0) = 0 OR (CalleSchoolId = @SchoolId OR CallerSchoolId = @SchoolId )

end