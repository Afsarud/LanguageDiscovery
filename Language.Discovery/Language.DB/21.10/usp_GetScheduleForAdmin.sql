ALTER procedure [dbo].[usp_GetScheduleForAdmin]
	@From datetime,
	@To datetime
as
begin
	select S.ScheduleId, S.Schedule, S.UserId, U.UserName, S.PartnerId, UP.UserName as PartnerName, u.GradeID , up.GradeID PartnerGradeID
	from Schedule S
	inner join [user] U on s.UserId = u.UserID
	left join [user] UP on s.PartnerId = up.UserID
	where S.Schedule BETWEEN convert(varchar(10),@From, 101) + ' 00:00:01' AND convert(varchar(10),@To, 101) + ' 23:59:59'
	order by Schedule


end