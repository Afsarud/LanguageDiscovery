	declare @UserID bigint = 0

	declare @UserRank as TABLE 
	(
		UserID bigint,
		StarCount int,
		MessageCount int,
		Points int
	)

	declare @LevelID int
	select @LevelID=isnull(LevelID,0) from [User] where UserID = @UserID 
	INSERT INTO @UserRank
	SELECT UserId, StarCount, LikeCount as MessageCount, StarCount+ LikeCount
	FROM
	(
		select xx.UserID,UserName,Flag,SchoolName,LikeCount + y.c1 + z.c2 LikeCount, Avatar, LikeCount as StarCount, SchoolCode, FirstName
		from (
		SELECT U.UserID,U.UserName, C.Flag, S.Name1 as SchoolName, COUNT(islike)*10 LikeCount, U.Avatar, S.SchoolCode,  U.FirstName
		FROM  UserMessage UM with(nolock)
		INNER JOIN [user] u on UM.SenderID = u.UserID
		INNER JOIN [Country] C on u.CountryID = C.CountryID
		INNER JOIN [SchoolInfo] S on U.SchoolID = S.SchoolID
		WHERE UM.SenderID > 0 and IsLike = 1 AND (isnull(@UserID,0) = 0 or U.UserID = @UserID) AND ((@LevelID <> 0 and u.levelid = @levelID)  OR U.LevelID not in (3,4))
		AND U.IsActive = 1
		GROUP BY U.USerID,U.UserName,C.Flag, S.Name1 , U.Avatar, S.SchoolCode, U.FirstName
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
	ORDER BY LikeCount DESC
	SELECT * FROM  @UserRank

	INSERT INTO UserRank (UserID, StarCount, MessageCount, Points)
	SELECT UserID, StarCount, MessageCount, Points 
	FROM  @UserRank
	where UserID NOT IN (SELECT UserID FROM UserRank)



	UPDATE UserRank set StarCount =TUR.StarCount, MessageCount = tur.MessageCount, Points = tur.Points
	FROM UserRank UR
	INNER JOIN @UserRank TUR ON UR.UserID = TUR.UserID


	select * from UserRank