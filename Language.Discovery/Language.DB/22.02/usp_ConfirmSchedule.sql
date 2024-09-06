ALTER procedure [dbo].[usp_ConfirmSchedule]
	@Token uniqueidentifier,
	@IsConfirmed bit = 1,
	@UserID int = 0,
	@ID int output

as
begin

	declare @ScheduleId int 
	select @ScheduleId = Scheduleid from Schedule where UserConfirmationToken = @Token and isnull(IsUserConfirmed,0) = 0-- AND UserID = @UserID
	if @ScheduleId IS NOT NULL
	begin
		UPDATE Schedule SET IsUserConfirmed = @IsConfirmed, UserConfirmationDateTime = GETDATE() where ScheduleId = @ScheduleId
	end
	ELSE
	BEGIN
		select @ScheduleId = Scheduleid from Schedule where PartnerConfirmationToken = @Token and ISNULL(IsPartnerConfirmed,0) = 0-- AND PartnerId = @UserID
		if @ScheduleId IS NOT NULL
		begin
			UPDATE Schedule SET IsPartnerConfirmed = @IsConfirmed, PartnerConfirmationDateTime = GETDATE() where ScheduleId = @ScheduleId
		end
	END

	--IF ISNULL(@ScheduleId,0) = 0
	--BEGIN
	--	select @ScheduleId = Scheduleid from Schedule where UserConfirmationToken = @Token or PartnerConfirmationToken = @Token 
	--END

	SET @ID = @ScheduleId

end