create procedure usp_DeleteSchedule
	@ScheduleId int
as
begin
	DELETE Schedule where ScheduleId = @ScheduleId
end