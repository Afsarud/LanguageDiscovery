
ALTER PROCEDURE [dbo].[usp_CancelSchedule]
	@Date datetime,
	@UserId int
AS
BEGIN
	IF EXISTS (SELECT 1 FROM Schedule WHERE Schedule = @Date AND PartnerId = @UserId)
	BEGIN
		UPDATE Schedule SET PartnerId = NULL, PartnerConfirmationToken = null, IsPartnerConfirmed = null, UserConfirmationDatetime = null WHERE Schedule = @Date AND PartnerId = @UserId
	END
	ELSE IF EXISTS (SELECT 1 FROM Schedule WHERE Schedule = @Date AND UserId = @UserId AND PartnerId IS NOT NULL)
	BEGIN
		UPDATE Schedule SET UserId = PartnerId, UserConfirmationToken = UserConfirmationToken, IsUserConfirmed = IsPartnerConfirmed, 
		UserConfirmationDateTime = PartnerConfirmationDateTime, PartnerId = NULL, PartnerConfirmationToken = null, IsPartnerConfirmed = null, PartnerConfirmationDateTime = null
		WHERE Schedule = @Date AND UserId = @UserId
	END
	ELSE
	BEGIN
		DELETE Schedule WHERE Schedule = @Date AND UserId = @UserId
	END

END