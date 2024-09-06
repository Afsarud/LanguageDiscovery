create procedure usp_CreateNewSchedule
	@Date datetime,
	@UserName nvarchar(50),
	@PartnerUserName nvarchar(50)
as
begin
	DECLARE @UserId int
	DECLARE @PartnerId int

	SELECT @UserId = UserId from [User] where UserName = @UserName
	SELECT @PartnerId = UserId from [User] where UserName = @PartnerUserName

	INSERT INTO Schedule VALUES(@Date, @UserId, @PartnerId, GETDATE())

	
end