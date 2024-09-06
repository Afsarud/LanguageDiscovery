ALTER PROCEDURE [dbo].[usp_InsertUpdateCustomSchedule]
	@Date date,
	@Timeids nvarchar(250),
	@ID bigint output
as
begin

	declare @Ids as table 
	(
		TimeId int
	)

	Insert into @ids
	select * from dbo.ufn_Split(@TimeIds,',')

	delete Schedule where Schedule in (
		select cast(cs.customdate as varchar) + ' ' + t.TimeSchedule + ':00'
		from CustomSchedule cs
		inner join TimeScheduleAux t on cs.TimeId = t.TimeId
		where CustomDate = @Date AND cs.TimeId not in (select * from @Ids)
		) AND PartnerId is null

	DELETE [CustomSchedule] WHERE CustomDate = @Date

	INSERT INTO [dbo].[CustomSchedule]([TimeId],[CustomDate])
	Select TimeId, @Date from @Ids

	set @ID = SCOPE_IDENTITY()
    
end

