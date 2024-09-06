
CREATE PROCEDURE usp_InsertTalkHistory
	@UserName nvarchar(100),
	@TimeSpent int,
	@PartnerUserName nvarchar(100)
AS
BEGIN
	DECLARE @UserID bigint
	DECLARE @PartnerUserID bigint
	
	SELECT @UserID = UserID FROM [User] where UserName = @UserName
	SELECT @PartnerUserID = UserID FROM [User] where UserName = @PartnerUserName
	INSERT INTO UserTalkHistory VALUES( @UserID, DATEADD(MINUTE, -@TimeSpent, GETDATE()), GETDATE(), @TimeSpent, @PartnerUserID )

END

GO