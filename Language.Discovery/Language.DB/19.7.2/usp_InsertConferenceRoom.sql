
ALTER procedure [dbo].[usp_InsertConferenceRoom]
	@Room nvarchar(250),
	@Caller nvarchar(100),
	@Callee nvarchar(100)
as
begin

	INSERT INTO ConferenceRoom 
	values(@Room, @Caller, @Callee)

end