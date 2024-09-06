create procedure usp_UpdateSchedule
	@ScheduleId int,
	@Date datetime,
	@UserName nvarchar(50),
	@PartnerUserName nvarchar(50)
as
begin
	DECLARE @UserId int
	DECLARE @PartnerId int

	SELECT @UserId = UserId from [User] where UserName = @UserName
	SELECT @PartnerId = UserId from [User] where UserName = @PartnerUserName

	UPDATE Schedule SET Schedule = @Date, UserId = @UserId, PartnerId =@PartnerId WHERE ScheduleId = @ScheduleId

	
end