create procedure [usp_GetUserAvailablePerMonth]

	@UserId int = 7
as
begin

	declare @GradeId int
	select @GradeId = GradeID FROM [User] where UserId = @UserId

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
		where U.UserID = @UserId
		group by Matched.UserID, U.NumberOfMatching, [Month], [Year]
		--having sum(Matched.Matched) < U.NumberofMatching

		select * from @UserFrequencyPartner
	
end
	
