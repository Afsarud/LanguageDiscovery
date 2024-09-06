ALTER procedure [dbo].[usp_GetScheduleByDate]
	@Schedule datetime

as
BEGIN
	
	SELECT S.*, U.GradeID
	FROM Schedule S
	INNER JOIN [User] U on S.UserId = U.UserID
	WHERE Schedule BETWEEN convert(varchar(10),@Schedule, 101) + ' 00:00:01' AND convert(varchar(10),@Schedule, 101) + ' 23:59:59'

END