create procedure usp_DeleteConferenceRoom
	@Room nvarchar(250)
as
begin

	DELETE ConferenceRoom WHERE RoomName = @Room

end