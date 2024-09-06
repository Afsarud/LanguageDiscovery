alter procedure usp_UpdateUserParentsInfo
	@UserID int
as
begin

	UPDATE [User] set IsParentsInfoStored = 1 WHERE UserID = @UserID

end
