create procedure usp_GetNonMatchedScheduleByDateAndId
	@Schedule datetime,
	@UserId bigint

as
BEGIN
	
	SELECT * 
	FROM Schedule 
	WHERE Schedule BETWEEN convert(varchar(10),@Schedule, 101) + ' 00:00:01' AND convert(varchar(10),@Schedule, 101) + ' 23:59:59'
	AND UserId = @UserId
	AND PartnerId is NULL

END