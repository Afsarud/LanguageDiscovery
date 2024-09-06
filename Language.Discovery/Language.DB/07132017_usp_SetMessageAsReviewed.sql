ALTER procedure [dbo].[usp_SetMessageAsReviewed]
	@UserMailID bigint,
	@UserID bigint,
	@IsFeedBack bit = 0,
	@FeedbackMessage nvarchar(max) = null
as
begin

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
		
	where UserMailID = @UserMailID

end	

