CREATE PROCEDURE usp_GetLatestMessage
	@UserID bigint
AS 
BEGIN

	SELECT TOP 1 UM.NativeLanguageMessage, NativeLanguageMessageRecepient, UM.LearningLanguageMessage, UM.LearningLanguageMessageRecepient, U.* 
	FROM UserMessage UM
	INNER JOIN [User] U on UM.SenderID = U.UserID
	WHERE RecepientID = @UserID AND DATEDIFF(mi,UM.CreateDate,getdate()) < 30
	AND UM.ReadDate is null and um.IsActive = 1 and UM.Reviewed = 1 AND um.HasFilteredWords = 0
	ORDER by UM.CreateDate desc

END

