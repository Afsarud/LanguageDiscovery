ALTER procedure [dbo].[usp_GetScheduleByUserId]
	@UserId int
AS
BEGIN
		SELECT *, '' as UserName FROM Schedule 
	WHERE (UserId = @UserId OR PartnerId = @UserId)
	and Schedule > GETDATE()

	union all 

	select 0 , getdate(), @UserId, UserId,getdate(), UserName as UserName
	from [user] where Username = 'Palaygo Test User' or Username like 'ferdie%' or FirstName = 'Palaygo Test User'
END
