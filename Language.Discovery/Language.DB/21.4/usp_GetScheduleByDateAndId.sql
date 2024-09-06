create procedure usp_GetScheduleByDateAndId
	@Schedule datetime,
	@UserId bigint

as
BEGIN
	
	SELECT * 
	FROM Schedule 
	WHERE Schedule BETWEEN convert(varchar(10),@Schedule, 101) + ' 00:00:01' AND convert(varchar(10),@Schedule, 101) + ' 23:59:59'
	AND (UserId = @UserId OR PartnerId = @UserId)

END