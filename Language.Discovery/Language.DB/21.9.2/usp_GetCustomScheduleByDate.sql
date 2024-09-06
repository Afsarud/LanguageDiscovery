CREATE PROCEDURE usp_GetCustomScheduleByDate
	@date date
as
begin

	select cs.* , t.TimeSchedule
	from CustomSchedule cs
	inner join TimeScheduleAux t on cs.TimeId = t.TimeId
	where CustomDate  = @Date

end