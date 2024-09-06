CREATE PROCEDURE usp_GetTalkSubscription
	@UserName nvarchar(100)
AS
BEGIN

		DECLARE @UserID bigint
	SELECT @UserID = UserID FROM [User] where UserName = @UserName

	SELECT UserTalkSubscriptionID, UserID, 
	CASE WHEN BalanceTime < SessionTime then BalanceTime else SessionTime end SessionTime, 
	BalanceTime, TotalTime, CreateDate, IsActive
	FROM UserTalkSubscription WHERE UserID = @UserID and IsActive = 1	

END



