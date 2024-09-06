CREATE PROCEDURE usp_CancelSchedule
	@Date datetime,
	@UserId int
AS
BEGIN
	IF EXISTS (SELECT 1 FROM Schedule WHERE Schedule = @Date AND PartnerId = @UserId)
	BEGIN
		UPDATE Schedule SET PartnerId = NULL WHERE Schedule = @Date AND PartnerId = @UserId
	END
	ELSE
	BEGIN
		DELETE Schedule WHERE Schedule = @Date AND UserId = @UserId
	END
END