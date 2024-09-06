create procedure usp_updateTalkStatus
	@UserID bigint,
	@Status bit = 0
as 
begin

	UPDATE [User] set IsCanTalk = @Status where UserID = @UserID

end
