CREATE PROCEDURE [dbo].[usp_UpdateTalkSubscription]
	@UserTalkSubscriptionID int,
	@UserName nvarchar(100),
	@PartnerUserName nvarchar(100),
	@SessionTime int
AS
BEGIN
	
	declare @BalanceTime as int
	DECLARE @IsActive bit = 1
	DECLARE @UserID bigint
	DECLARE @TimeSpent bigint
	
	SELECT @UserID = UserID FROM [User] where UserName = @UserName

	
	SELECT @BalanceTime =  BalanceTime - (SessionTime-@SessionTime), @TimeSpent=SessionTime-@SessionTime  FROM UserTalkSubscription WHERE UserTalkSubscriptionID = @UserTalkSubscriptionID
	
	IF @BalanceTime <= 0
	BEGIN
		SET @IsActive = 0
	END
	UPDATE UserTalkSubscription 
	 SET UserID = @UserID,  BalanceTime = BalanceTime - (SessionTime-@SessionTime), IsActive = @IsActive
	 WHERE UserTalkSubscriptionID = @UserTalkSubscriptionID


	 exec usp_InsertTalkHistory @UserName, @TimeSpent, @PartnerUserName

END





