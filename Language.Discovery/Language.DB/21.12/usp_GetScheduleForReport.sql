alter procedure [dbo].[usp_GetScheduleForReport]
	@SchoolID int = 0,
	@PartnerSchoolId int = 0,
	@Sort nvarchar(50) = null,
	@Order nvarchar(10) = 'A',
	@From datetime,
	@To datetime

as
begin

	select SU.Name1, SP.Name1 PartnerSchool, S.ScheduleId,  S.Schedule, S.UserId, U.UserName, S.PartnerId, UP.UserName as PartnerName, u.GradeID ,
		up.GradeID PartnerGradeID, UTSUser.SessionTime UserSessionTime, UTSPartner.SessionTime PartnerSessionTime,
		S.UserConfirmationToken, S.IsUserConfirmed, S.UserConfirmationDateTime, S.PartnerConfirmationToken, S.IsPartnerConfirmed, S.PartnerConfirmationDateTime,
		S.Comment, S.UserColor, S.PartnerColor 
	from Schedule S
	inner join [user] U on s.UserId = u.UserID
	left join [user] UP on s.PartnerId = up.UserID
	left join UserTalkSubscription UTSUser on S.UserID = UTSUser.UserID and UTSUser.IsActive = 1
	left join UserTalkSubscription UTSPartner on s.PartnerId = UTSPartner.UserID AND UTSPartner.IsActive = 1
	inner JOIN SchoolInfo SU on U.SchoolID = SU.SchoolID
	inner JOIN SchoolInfo SP on UP.SchoolID = SP.SchoolID
	where S.Schedule BETWEEN convert(varchar(10),@From, 101) + ' 00:00:01' AND convert(varchar(10),@To, 101) + ' 23:59:59'
	AND (ISNULL(@SchoolID, 0) = 0 OR SU.SchoolID = @SchoolID  )
	AND (ISNULL(@PartnerSchoolID, 0) = 0 OR SP.SchoolID = @PartnerSchoolID  )
	group by SU.Name1, SP.Name1, S.ScheduleId,  S.Schedule, S.UserId, U.UserName, S.PartnerId, UP.UserName, u.GradeID ,
		up.GradeID , UTSUser.SessionTime , UTSPartner.SessionTime ,
		S.UserConfirmationToken, S.IsUserConfirmed, S.UserConfirmationDateTime, S.PartnerConfirmationToken, S.IsPartnerConfirmed, S.PartnerConfirmationDateTime,
		S.Comment, S.UserColor, S.PartnerColor 
	ORDER BY 
				CASe when @Sort = 'School' AND @Order = 'A' then SU.Name1 END ASC,
				CASe when @Sort = 'School' AND @Order = 'D' then SU.Name1 END DESC,
				CASe when @Sort = 'Schedule' AND @Order = 'A' then S.Schedule END ASC,
				CASe when @Sort = 'Schedule' AND @Order = 'D' then S.Schedule END DESC,
				s.Schedule asc
			

end
