alter PROCEDURE usp_SaveMessageForLaterUse 
	@UserSavedMessageId int = null,
	@UserID int,
	@LearningMessage nvarchar(max),
	@NativeMessage nvarchar(max),
	@OtherMessage nvarchar(max) = null,
	@ID int output
AS
BEGIN
	
	IF ISNULL(@UserSavedMessageId,0) = 0
	BEGIN
		INSERT INTO UserSavedMessage 
		VALUES ( @UserID, GETDATE(), @LearningMessage, @NativeMessage, @OtherMessage )

		SET @ID = SCOPE_IDENTITY()
	END
	ELSE
	BEGIN
		UPDATE UserSavedMessage set NativeMessage = @NativeMessage, LearningMessage = @LearningMessage, OtherLanguageMessage = @OtherMessage WHERE UserSavedMessageID = @UserSavedMessageID
		SET @ID = @UserSavedMessageId
	END
END