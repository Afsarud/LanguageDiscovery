
CREATE PROCEDURE usp_InsertTalkSubscription
	@UserName nvarchar(100),
	@SessionTime int,
	@BalanceTime int,
	@TotalTime int,
	@IsActive bit = 0,
	@ID int out	
AS
BEGIN

	DECLARE @UserID bigint
	
	SELECT @UserID = UserID FROM [User] where UserName = @UserName
	INSERT INTO UserTalkSubscription 
	VALUES (@UserID, @SessionTime, @BalanceTime, @TotalTime, getdate(), @IsActive)

	SET @ID = SCOPE_IDENTITY()

END



