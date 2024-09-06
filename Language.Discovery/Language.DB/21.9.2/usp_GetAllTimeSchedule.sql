ALTER procedure [dbo].[usp_GetAllTimeSchedule]
	@Date datetime = null
AS
BEGIN

	SELECT TS.*, CS.CustomDate
	FROM TimeScheduleAux TS
	INNER JOIN CustomSchedule CS on TS.TimeId = CS.TimeId
	where (CS.CustomDate >= DateAdd(day, 1, getdate()) )
	--WHERE @Date IS NULL OR (CS.CustomDate >= DateAdd(day, 2, getdate()) )
	order by cs.CustomDate asc
	--WHERE Active = 1 --AND CS.CustomDate = CONVERT(DATE, @Date)

END