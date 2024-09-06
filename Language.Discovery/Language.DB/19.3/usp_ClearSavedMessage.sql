create PROCEDURE usp_ClearSavedMessage
	@UserID int
AS
BEGIN
	DELETE UserSavedMessage where UserId = @UserID
END