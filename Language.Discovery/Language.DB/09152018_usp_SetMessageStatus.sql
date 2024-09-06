CREATE procedure [dbo].[usp_SetMessageStatus]
	@xml xml,
	@UserID bigint,
	@IsFeedBack bit = 0,
	@StatusId bit = 0,
	@FeedbackMessage nvarchar(max) = null
as
begin

	
	IF @StatusId = 1
	BEGIN

		UPDATE UserMessage SET Reviewed = 1, ReviewedByID = @UserID, HasFilteredWords = 0, ReviewedDate =GETDATE(), IsFeedBack = @IsFeedBack, 
			OriginalRecepientID = CASE WHEN @IsFeedBack = 1 THEN RecepientID ELSE NULL END, 
			RecepientID =  CASE WHEN @IsFeedBack = 1 THEN SenderID ELSE RecepientID END,
			SenderID =  CASE WHEN @IsFeedBack = 1 THEN @UserID ELSE SenderID END,
			NativeLanguageMessage = CASE WHEN 
										ISNULL(@FeedbackMessage, '')='' THEN NativeLanguageMessage 
									ELSE 
										@FeedbackMessage --NativeLanguageMessage + @FeedbackMessage 
									END,
			NativeLanguageMessageRecepient = CASE WHEN 
										ISNULL(@FeedbackMessage, '')='' THEN NativeLanguageMessageRecepient 
									ELSE 
										@FeedbackMessage --NativeLanguageMessage + @FeedbackMessage 
									END
		
		where UserMailID in (
				SELECT PX.value('(id)[1]', 'bigint')
				FROM  @xml.nodes('UserMail/IDS') AS XD(PX)
			)
	END
	ELSE
	BEGIN
		UPDATE UserMessage SET Reviewed = 1, ReviewedByID = @UserID, ReviewedDate =GETDATE(), IsActive = 0
		where UserMailID in (
				SELECT PX.value('(id)[1]', 'bigint')
				FROM  @xml.nodes('UserMail/IDS') AS XD(PX)
			)
	END
end	

