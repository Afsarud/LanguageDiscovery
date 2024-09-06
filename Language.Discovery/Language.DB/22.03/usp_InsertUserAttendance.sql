ALTER procedure [dbo].[usp_InsertUserAttendance]
	@UserID int,
	@Schedule datetime,
	@Score int = 100
as
begin

	IF NOT EXISTS(SELECT 1 FROM UserAttendance WHERE Schedule = @Schedule AND UserID = @UserID)
	BEGIN
		INSERT INTO UserAttendance
		VALUES ( @UserID, @Schedule, @Score, GETDATE() )
	END

end