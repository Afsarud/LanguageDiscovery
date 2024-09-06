ALTER procedure [dbo].[usp_GetScheduleForAdmin]
	@From datetime,
	@To datetime
as
begin

	select distinct S.ScheduleId, S.Schedule, S.UserId, U.UserName, S.PartnerId, UP.UserName as PartnerName, u.GradeID ,
		up.GradeID PartnerGradeID, UTSUser.SessionTime UserSessionTime, UTSPartner.SessionTime PartnerSessionTime,
		S.UserConfirmationToken, S.IsUserConfirmed, S.UserConfirmationDateTime, S.PartnerConfirmationToken, S.IsPartnerConfirmed, S.PartnerConfirmationDateTime,
		S.Comment, S.UserColor, S.PartnerColor, UC.CountryCode UserCountryCode, PC.CountryCode PartnerCountryCode
	from Schedule S
	inner join [user] U on s.UserId = u.UserID
	left join [user] UP on s.PartnerId = up.UserID
	left join UserTalkSubscription UTSUser on S.UserID = UTSUser.UserID and UTSUser.IsActive = 1
	left join UserTalkSubscription UTSPartner on s.PartnerId = UTSPartner.UserID AND UTSPartner.IsActive = 1
	inner join Country UC on U.CountryID = UC.CountryID
	left JOIN Country PC on UP.CountryID = PC.CountryID
	where S.Schedule BETWEEN convert(varchar(10),@From, 101) + ' 00:00:01' AND convert(varchar(10),@To, 101) + ' 23:59:59'
	order by Schedule


end
