ALTER PROCEDURE [dbo].[usp_UpdateTalkSubscription]
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
	DECLARE @TempSessionTime bigint
	DECLARE @TempBalanceTime bigint
	
	SELECT @UserID = UserID FROM [User] where UserName = @UserName

	select @TempSessionTime = SessionTime, @TempBalanceTime= BalanceTime FROM UserTalkSubscription WHERE UserTalkSubscriptionID = @UserTalkSubscriptionID

	IF @TempBalanceTime < @TempSessionTime
	BEGIN 
		SELECT @BalanceTime =  BalanceTime - @SessionTime, @TimeSpent=BalanceTime-@SessionTime  FROM UserTalkSubscription WHERE UserTalkSubscriptionID = @UserTalkSubscriptionID
	END
	ELSE
	BEGIN
		SELECT @BalanceTime =  BalanceTime - (SessionTime-@SessionTime), @TimeSpent=SessionTime-@SessionTime  FROM UserTalkSubscription WHERE UserTalkSubscriptionID = @UserTalkSubscriptionID
	END
	IF @TempBalanceTime >= @TempSessionTime
	BEGIN 
		UPDATE UserTalkSubscription 
		 SET UserID = @UserID,  BalanceTime = BalanceTime - (SessionTime-@SessionTime)
		 WHERE UserTalkSubscriptionID = @UserTalkSubscriptionID
	END
	ELSE
	BEGIN
		UPDATE UserTalkSubscription 
		 SET UserID = @UserID,  BalanceTime = CASE WHEN @SessionTime = 0 then 0 else BalanceTime -@SessionTime end
		 WHERE UserTalkSubscriptionID = @UserTalkSubscriptionID

	END
	SELECT @BalanceTime =  BalanceTime FROM UserTalkSubscription WHERE UserTalkSubscriptionID = @UserTalkSubscriptionID

	IF @BalanceTime <= 0
	BEGIN
		SET @IsActive = 0
	END

	--temporary commented out
	--UPDATE UserTalkSubscription SET IsActive = @IsActive  WHERE UserTalkSubscriptionID = @UserTalkSubscriptionID


	--temporary 
	if @IsActive = 0 
	begin
		UPDATE UserTalkSubscription SET BalanceTime = TotalTime WHERE UserTalkSubscriptionID = @UserTalkSubscriptionID
	end
	else
	--begin
		--UPDATE UserTalkSubscription SET IsActive = @IsActive  WHERE UserTalkSubscriptionID = @UserTalkSubscriptionID
	--end

	 exec usp_InsertTalkHistory @UserName, @TimeSpent, @PartnerUserName

END





