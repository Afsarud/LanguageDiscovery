alter PROCEDURE usp_GetCustomSchedule
	@Startdate date,
	@Enddate date
as
begin

	SELECT c.CustomDate,
			(  
			SELECT ' ' + t.TimeSchedule
			FROM CustomSchedule c2 
			inner join TimeScheduleAux t on c2.TimeId = t.TimeId
			WHERE c.CustomDate = c2.CustomDate
			FOR XML PATH ('')  
			)  as TimeSchedule,
			STUFF((  
			SELECT ',' + cast(t.TimeId as varchar(2))
			FROM CustomSchedule c2 
			inner join TimeScheduleAux t on c2.TimeId = t.TimeId
			WHERE c.CustomDate = c2.CustomDate
			FOR XML PATH ('')  
			),1,1,'' ) as TimeIds
	FROM CustomSchedule c  
	where CustomDate BETWEEN convert(varchar(10),@Startdate, 101)  AND convert(varchar(10),@Enddate, 101)
	GROUP BY c.CustomDate
	


	--select cs.* , t.TimeSchedule
	--from CustomSchedule cs
	--inner join TimeScheduleAux t on cs.TimeId = t.TimeId
	--where CustomDate BETWEEN convert(varchar(10),@Startdate, 101)  AND convert(varchar(10),@Enddate, 101)

end