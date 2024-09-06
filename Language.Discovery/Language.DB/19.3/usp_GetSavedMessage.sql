CREATE PROCEDURE usp_GetSavedMessage
	@UserID int
AS
BEGIN
	SELECT * FROM UserSavedMessage where UserId = @UserID
END