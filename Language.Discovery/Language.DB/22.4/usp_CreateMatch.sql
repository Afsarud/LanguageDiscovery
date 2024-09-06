ALTER procedure [dbo].[usp_CreateMatch]
	@Date datetime,
	@UserId int,
	@CategoryId int = null,
	@ID int output
AS
BEGIN

	DECLARE @Temp as Table 
	(
		Id int,
		UserId int,
		Grade int,
		Schedule datetime
	)

	DECLARE @Partner as TABLe
	(
		UserId int,
		Grade int,
		Gender nvarchar(50),
		Email nvarchar(50)
	)

	DECLARE @UserFrequency as TABLe
	(
		UserId int,
		MatchedCount int,
		NumberOfMatching int
	)

	DECLARE @UserFrequencyPartner as TABLe
	(
		UserId int,
		MatchedCount int,
		NumberOfMatching int
	)


	DECLARE @Grade int
	DECLARE @ScheduleId int
	DECLARE @PartnerUserId int
	DECLARE @CountryId int
	DECLARE @NativeLanguage nvarchar(20)

	SET @ID = 0

	SELECT @Grade = GradeID, @CountryId = CountryID, @NativeLanguage = NativeLanguage from [User] where UserId = @UserId

	INSERT INTO @Temp
	SELECT S.ScheduleId, S.UserId, U.GradeID, S.Schedule
	FROM Schedule S
	INNER JOIN [User] U ON S.UserId = U.UserID
	WHERE SCHEDULE = @Date AND S.UserId = @UserId

	UNION ALL

	SELECT S.ScheduleId, S.PartnerId, U.GradeID, S.Schedule
	FROM Schedule S
	INNER JOIN [User] U ON S.PartnerId = U.UserID
	WHERE SCHEDULE = @Date AND S.PartnerId= @UserId
	
	--IF NOT EXISTS(SELECT 1 FROM Schedule where Schedule = @Date AND UserId = @UserId )
	IF NOT EXISTS(SELECT 1 FROM @Temp)
	BEGIN
		
		--FIND PARTNER
		INSERT INTO @Temp
		SELECT S.ScheduleId, S.UserId, U.GradeID, S.Schedule
		FROM Schedule S
		INNER JOIN [User] U ON S.UserId = U.UserID
		WHERE SCHEDULE = @Date

		--FIND all possible Partner with less than the allowed matching count
		INSERT INTO @UserFrequencyPartner
		SELECT Matched.UserID, sum(Matched.Matched) Matched, U.NumberOfMatching
		FROM (
		SELECT UserID, Count(schedule) Matched
			FROM Schedule 
			WHERE Month(Schedule) = Month(@Date) AND  Year(Schedule) = Year(@Date)
			and PartnerId is not null 
			GROUP BY Month(Schedule) + Year(Schedule), userid
			
			UNION ALL

			SELECT PartnerId, Count(schedule) Matched
			FROM Schedule 
			WHERE Month(Schedule) = Month(@Date) AND  Year(Schedule) = Year(@Date)
			and PartnerId is not null 
			GROUP BY Month(Schedule) + Year(Schedule), PartnerId

			union all

			SELECT UserID, Count(partnerid) Matched
			FROM Schedule 
			WHERE Month(Schedule) = Month(@Date) AND  Year(Schedule) = Year(@Date)
			and PartnerId is null 
			GROUP BY Month(Schedule) + Year(Schedule), UserID
		) Matched
		INNER JOIN [User] U on U.UserID = Matched.UserID
		group by Matched.UserID, U.NumberOfMatching
		having Sum(Matched.Matched) < U.NumberOfMatching


		--Check if the user is still less than the allowed number of matching in a month
		IF @Grade = 13 -- Youth
		BEGIN
			SELECT Top 1 @ScheduleId = Id, @PartnerUserId = T.UserId 
			FROM @Temp T
			INNER JOIN @UserFrequencyPartner UP on T.UserId = UP.UserId
			INNER JOIN [User] U on T.UserId = U.UserID
			INNER JOIN Schedule S on T.Id = S.ScheduleId AND S.PartnerId is null
			WHERE Grade between 8 AND 13
				AND U.CountryID <> @CountryId AND U.NativeLanguage <> @NativeLanguage AND U.UserTypeID = 3
			ORDER BY NEWID()  
		END
		ELSE
		BEGIN
			SELECT Top 1 @ScheduleId = Id, @PartnerUserId = T.UserId 
			FROM @Temp T
			INNER JOIN @UserFrequencyPartner UP on T.UserId = UP.UserId
			INNER JOIN [User] U on T.UserId = U.UserID
			INNER JOIN Schedule S on T.Id = S.ScheduleId AND S.PartnerId is null
			WHERE Grade between @Grade - 2 AND @Grade + 2
				AND U.CountryID <> @CountryId AND U.NativeLanguage <> @NativeLanguage AND U.UserTypeID = 3
			ORDER BY NEWID()  
		END

		INSERT INTO @UserFrequency
		SELECT Matched.UserID, sum(Matched.Matched) Matched, U.NumberOfMatching
		FROM (
			SELECT @userid UserID, Count(schedule) Matched
			FROM Schedule 
			WHERE (UserID = @UserID OR PartnerId =@userid )AND Month(Schedule) = Month(@Date) AND  Year(Schedule) = Year(@Date)
			and PartnerId is not null 
			GROUP BY Month(Schedule) + Year(Schedule), userid
		) Matched
		INNER JOIN [User] U on U.UserID = Matched.UserID
		group by Matched.UserID, U.NumberOfMatching
		


		DECLARE @UserMatchedCount int
		DECLARE @Matched int
		DECLARE @NumberOfMatching int

		SELECT @UserMatchedCount = UserID, @Matched = MatchedCount, @NumberOfMatching = NumberOfMatching FROM @UserFrequency

		IF ISNULL(@UserMatchedCount,0) = 0
		BEGIN
			
			INSERT INTO @UserFrequency
			SELECT @UserId, 0, U.NumberOfMatching
			FROM [User] U
			WHERE U.UserID = @UserId

		END

		SELECT @UserMatchedCount = UserID, @Matched = MatchedCount, @NumberOfMatching = NumberOfMatching FROM @UserFrequency

		IF @ScheduleId IS NOT NULL AND @Matched < @NumberOfMatching --PARTNER FOUND
		BEGIN
			UPDATE Schedule SET PartnerId = @UserId, PartnerConfirmationToken = NEWID(), PartnerPhraseCategoryID = @CategoryId WHERE ScheduleId = @ScheduleId
			
			SET @ID = @ScheduleId
		END
		ELSE
		BEGIN
			INSERT INTO Schedule(Schedule, UserId, CreateDate, UserConfirmationToken, PhraseCategoryID)
				VALUES( @Date, @UserId, GETDATE(), NEWID(), @CategoryId)

			SET @ID = SCOPE_IDENTITY()

		END
	END

	

	--SELECT UserID, Age, Gender, Email FROM @Partner
END
