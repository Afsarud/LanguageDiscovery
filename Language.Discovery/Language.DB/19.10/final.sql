	declare @UserID bigint = 0

	declare @Multiplier as int = 1
	DECLARE @UserCountryId as int
	DECLARE @UserCountryLanguage as nvarchar(10)
	DECLARE @UserLearningCountryId as int
	DECLARE @UserCountryLearningLanguage as nvarchar(10)
	DECLARE @AUMessageCount as int
	DECLARE @JPMessageCount as int
	declare @UserRank as TABLE 
	(
		UserID1 bigint,
		StarCount1 int,
		MessageCount1 int
	)

	DECLARE @LevelID INT
	SELECT @LevelID=isnull(LevelID,0), @UserCountryLanguage = NativeLanguage, @UserCountryLearningLanguage = LearningLanguage 
	FROM [User] WHERE UserID = @UserID 

	SELECT @UserCountryId = CountryId FROM [Language] WHERE LanguageCode = @UserCountryLanguage
	SELECT @UserLearningCountryId = CountryId FROM [Language] WHERE LanguageCode = @UserCountryLearningLanguage


	--AU
	SELECT @AUMessageCount = Count(u.UserID ) 
	FROM  UserMessage UM with(nolock)
	INNER JOIN [user] u on UM.SenderID = u.UserID
	WHERE  ((@LevelID <> 0 and u.levelid = @levelID)  OR U.LevelID not in (3,4))
	and u.CountryID = 1 AND UM.CreateDate>=DATEADD(DAY,-500,GETDATE())
	--GROUP BY U.USerID
	
	--JP
	SELECT @JPMessageCount = Count(u.UserID )
	FROM  UserMessage UM with(nolock)
	INNER JOIN [user] u on UM.SenderID = u.UserID
	WHERE  ((@LevelID <> 0 and u.levelid = @levelID)  OR U.LevelID not in (3,4))
	and u.CountryID = 2 AND UM.CreateDate>=DATEADD(DAY,-500,GETDATE())
	
	IF @AUMessageCount * 100.0/@JPMessageCount < 50
		SET @Multiplier = 10


	--INSERT INTO @UserRank
	SELECT UserId, StarCount, MessageCount
	FROM
	(
		select xx.UserID,StarCount, (y.c1 + z.c2) * case when CountryID = 1 THEN @Multiplier ELSE 1 END   MessageCount, CountryID
		from (
		SELECT U.UserID,U.UserName, C.Flag, S.Name1 as SchoolName, 
			COUNT(islike) AS StarCount, 
			U.Avatar, S.SchoolCode,  U.FirstName, u.CountryID
		FROM  UserMessage UM with(nolock)
		INNER JOIN [user] u on UM.SenderID = u.UserID
		INNER JOIN [Country] C on u.CountryID = C.CountryID
		INNER JOIN [SchoolInfo] S on U.SchoolID = S.SchoolID
		WHERE UM.SenderID > 0 and IsLike = 1 AND (isnull(@UserID,0) = 0 or U.UserID = @UserID) AND ((@LevelID <> 0 and u.levelid = @levelID)  OR U.LevelID not in (3,4))
		AND U.IsActive = 1
		GROUP BY U.USerID,U.UserName,C.Flag, S.Name1 , U.Avatar, S.SchoolCode, U.FirstName, U.CountryID
		) xx
		INNER JOIN 
		(
			SELECT U.UserID,Count(u.UserID ) c1
			FROM  UserMessage UM with(nolock)
			INNER JOIN [user] u on UM.SenderID = u.UserID
			WHERE  (isnull(@UserID,0) = 0 or U.UserID = @UserID) AND ((@LevelID <> 0 and u.levelid = @levelID)  OR U.LevelID not in (3,4))
			GROUP BY U.USerID
		) y on xx.UserID= y.UserID 
		INNER JOIN 
		(
			SELECT U.UserID,Count(u.UserID ) c2
			FROM  UserMessage UM with(nolock)
			INNER JOIN [user] u on UM.RecepientID = u.UserID
			WHERE  (isnull(@UserID,0) = 0 or U.UserID = @UserID) AND ((@LevelID <> 0 and u.levelid = @levelID)  OR U.LevelID not in (3,4))
			GROUP BY U.USerID
		) z on xx.UserID= z.UserID 
	) x
	ORDER BY StarCount DESC

	--SELECT * FROM  @UserRank
	--select * from userrank
	INSERT INTO UserRank (UserID, StarCount, MessageCount)
	SELECT UserID1, StarCount1, MessageCount1
	FROM  @UserRank
	where UserID1 NOT IN (SELECT UserID FROM UserRank)


	UPDATE UserRank set StarCount = CASE WHEN StarCount > TUR.StarCount1 THEN StarCount ELSE TUR.StarCount1 END, 
	MessageCount = CASE WHEN MessageCount > TUR.MessageCount1 THEN MessageCount ELSE TUR.MessageCount1 END
	FROM UserRank AS UR
	INNER JOIN @UserRank TUR ON UR.UserID = TUR.UserID1
