create procedure [dbo].[usp_GetMySchedule]
	@UserId int
AS
BEGIN
	SELECT *, '' as UserName FROM Schedule 
	WHERE (UserId = @UserId OR PartnerId = @UserId)
	and Schedule > GETDATE()

END

