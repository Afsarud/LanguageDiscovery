ALTER procedure [dbo].[usp_ConfirmSchedule]
	@Token uniqueidentifier,
	@IsConfirmed bit,
	@UserID int,
	@ID int output

as
begin

	declare @ScheduleId int 
	select @ScheduleId = Scheduleid from Schedule where UserConfirmationToken = @Token and UserConfirmationDateTime IS NULL AND UserID = @UserID
	if @ScheduleId IS NOT NULL
	begin
		UPDATE Schedule SET IsUserConfirmed = @IsConfirmed, UserConfirmationDateTime = GETDATE() where ScheduleId = @ScheduleId
	end
	ELSE
	BEGIN
		select @ScheduleId = Scheduleid from Schedule where PartnerConfirmationToken = @Token and PartnerConfirmationDateTime IS NULL AND PartnerId = @UserID
		if @ScheduleId IS NOT NULL
		begin
			UPDATE Schedule SET IsPartnerConfirmed = @IsConfirmed, PartnerConfirmationDateTime = GETDATE() where ScheduleId = @ScheduleId
		end
	END

	SET @ID = @ScheduleId

end