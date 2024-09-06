create procedure usp_DeleteCustomSchedule
	@Date date
as
begin

	DELETE [CustomSchedule] WHERE CustomDate = @Date
end