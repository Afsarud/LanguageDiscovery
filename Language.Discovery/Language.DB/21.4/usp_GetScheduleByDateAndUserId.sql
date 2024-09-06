alter procedure [dbo].[usp_GetScheduleByDateAndUserId]
	@Schedule datetime,
	@UserId int
as
BEGIN
	
	Declare @CountryId int
	Declare @LevelId int
	Declare @GradeId int 
	DECLARE @NativeLanguage nvarchar(20)

	SELECT @GradeId = GradeID, @CountryId = CountryID, @LevelId = LevelId, @NativeLanguage = NativeLanguage from [User] where UserId = @UserId

	DECLARE @UserFrequencyPartner as TABLe
	(
		UserId int,
		MatchedCount int,
		NumberOfMatching int
	)
	INSERT INTO @UserFrequencyPartner
		SELECT Matched.UserID, sum(Matched.Matched) Matched, U.NumberOfMatching
		FROM (
		SELECT UserID, Count(schedule) Matched
			FROM Schedule 
			WHERE Month(Schedule) = Month(@Schedule) AND  Year(Schedule) = Year(@Schedule)
			and PartnerId is not null 
			GROUP BY Month(Schedule) + Year(Schedule), userid
			
			UNION ALL

			SELECT PartnerId, Count(schedule) Matched
			FROM Schedule 
			WHERE Month(Schedule) = Month(@Schedule) AND  Year(Schedule) = Year(@Schedule)
			and PartnerId is not null 
			GROUP BY Month(Schedule) + Year(Schedule), PartnerId

			union all

			SELECT UserID, Count(partnerid) Matched
			FROM Schedule 
			WHERE Month(Schedule) = Month(@Schedule) AND  Year(Schedule) = Year(@Schedule)
			and PartnerId is null 
			GROUP BY Month(Schedule) + Year(Schedule), UserID
		) Matched
		INNER JOIN [User] U on U.UserID = Matched.UserID
		group by Matched.UserID, U.NumberOfMatching


	SELECT S.*, U.GradeID, U.NumberOfMatching, MatchedCount
	FROM Schedule S
	INNER JOIN [User] U on S.UserId = U.UserID
	INNER JOIN @UserFrequencyPartner UP on U.UserID = UP.UserId
	WHERE Schedule BETWEEN convert(varchar(10),@Schedule, 101) + ' 00:00:01' AND convert(varchar(10),@Schedule, 101) + ' 23:59:59'
	AND U.CountryID <> @CountryId and U.UserTypeID = 3 AND U.NativeLanguage <> @NativeLanguage OR S.UserId = @UserId

	SELECT S.*, U.GradeID, U.NumberOfMatching, MatchedCount
	FROM Schedule S
	INNER JOIN [User] U on S.UserId = U.UserID
	INNER JOIN @UserFrequencyPartner UP on U.UserID = UP.UserId
	WHERE Month(Schedule) = Month(@Schedule) and year(Schedule) = year(@Schedule)


END