ALTER procedure [dbo].[usp_GetMessageDetailByUserMailID]
	@UserMailId bigint
as
begin	

	SELECT UserMailID, [Subject], [SenderID] , [RecepientID],UserMessage.[CreateDate],
	 [NativeLanguageMessage], [LearningLanguageMessage], [NativeLanguageMessageRecepient], [LearningLanguageMessageRecepient], [ReadDate],UserMessage.[IsActive], 
	 Cast(0 as bit)  as IsReply, isnull(U.Avatar,'') AS RecepientAvatar,isnull(u1.Avatar,'') as SenderAvatar,u.UserName as Sender,
	 u1.UserName as Recepient, Keyword, IsLike, u1.LearningLanguage RecepientLearningLanguage,
	 u1.NativeLanguage RecepientNativeLanguage, u.LearningLanguage SenderLearningLanguage,
	 u.NativeLanguage SenderNativeLanguage
	FROM UserMessage
	inner join [User] u1 on UserMessage.RecepientID = u1.UserID
	inner join [User] u on UserMessage.SenderID = u.UserID	
	WHERE UserMailID = @UserMailId
	
END






