ALTER procedure [dbo].[usp_MarkMessageAsRead]
	@SenderID bigint = 0,
	@RecipientID bigint
as
begin

	IF @SenderID > 0
	BEGIN
		UPDATE UserMessage SET ReadDate = GETDATE() WHERE SenderID =@SenderID AND RecepientID = @RecipientID AND Reviewed=1
	END
	ELSE
	BEGIN
		UPDATE UserMessage SET ReadDate = GETDATE() WHERE RecepientID = @RecipientID AND Reviewed=1 AND ReadDate is null and DATEDIFF(dd,CreateDate, getdate()) > 30
	END

end

 
