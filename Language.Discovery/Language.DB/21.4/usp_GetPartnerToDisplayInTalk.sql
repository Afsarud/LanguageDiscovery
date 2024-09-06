ALTER PROCEDURE [dbo].[usp_GetPartnerToDisplayInTalk]
	@UserId int = 0
as
begin

	declare @GradeId int
	declare @CountryId int
	declare @LevelId int
	DECLARE @NativeLanguage nvarchar(20)

	select @GradeId = GradeID, @CountryId = CountryID, @LevelId = LevelID, @NativeLanguage = NativeLanguage FROM [User] where UserId = @UserId

	DECLARE @UserFrequencyPartner as TABLe
	(
		UserId int,
		MatchedCount int,
		NumberOfMatching int,
		[Month] int,
		[Year] int
	)
	INSERT INTO @UserFrequencyPartner
		SELECT Matched.UserID, sum(Matched.Matched) Matched, U.NumberOfMatching, [Month], [Year]
		FROM (
			SELECT UserID, Count(schedule) Matched, Month(Schedule) [Month], Year(Schedule) [Year]
			FROM Schedule 
			WHERE PartnerId is not null AND Month(Schedule) >= Month(getdate())
			GROUP BY Month(Schedule) , Year(Schedule), userid
			
			UNION ALL

			SELECT PartnerId, Count(schedule) Matched, Month(Schedule) [Month], Year(Schedule) [Year]
			FROM Schedule 
			WHERE PartnerId is not null AND Month(Schedule) >= Month(getdate())
			GROUP BY Month(Schedule) , Year(Schedule), PartnerId

			union all

			SELECT UserID, Count(partnerid) Matched, Month(Schedule) [Month], Year(Schedule) [Year]
			FROM Schedule 
			WHERE PartnerId is null AND Month(Schedule) >= Month(getdate())
			GROUP BY Month(Schedule) , Year(Schedule), UserID
		) Matched
		INNER JOIN [User] U on U.UserID = Matched.UserID
		group by Matched.UserID, U.NumberOfMatching, [Month], [Year]
		having sum(Matched.Matched) < U.NumberofMatching

	SELECT distinct S.*, U.GradeID, U.NumberOfMatching--,  UP.[Month]
	FROM Schedule S
	INNER JOIN [User] U on S.UserId = U.UserID
	INNER JOIN @UserFrequencyPartner UP on S.UserID = UP.UserId and up.[Month] = Month(S.Schedule)
	WHERE S.PartnerId is null AND U.GradeID between @GradeId -2 AND @GradeId + 2
	AND S.UserId <> @UserId and S.Schedule > getdate()
	AND U.CountryID <> @CountryId and U.UserTypeID = 3 AND U.NativeLanguage <> @NativeLanguage
	
	

end
	
	
