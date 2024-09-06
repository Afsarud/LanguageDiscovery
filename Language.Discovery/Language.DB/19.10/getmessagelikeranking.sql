USE [Palaygo.11222018]
GO
/****** Object:  StoredProcedure [dbo].[usp_GetMessageLikeRanking]    Script Date: 10/28/2019 11:36:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure [dbo].[usp_GetMessageLikeRanking]
	@UserID bigint
as
BEGIN

	SELECT top 30 ROW_NUMBER() over( order by Points desc ) Ranking,U.UserID,UserName,Flag, Name1 SchoolName, StarCount, Avatar, MessageCount,  SchoolCode, FirstName
	FROM (
		SELECT UserID,StarCount, MessageCount, StarCount + MessageCount as Points
		FROM UserRank
	) UR
	INNER JOIN [user] u on UR.UserID = u.UserID
	INNER JOIN [Country] C on u.CountryID = C.CountryID
	INNER JOIN [SchoolInfo] S on U.SchoolID = S.SchoolID
	Order by Points desc


	--declare @LevelID int
	--select @LevelID=isnull(LevelID,0) from [User] where UserID = @UserID 
	--SELECT top 30 ROW_NUMBER() over( order by LikeCount desc ) Ranking,x.UserID,UserName,Flag,SchoolName,LikeCount, Avatar, StarCount,  SchoolCode, FirstName
	--FROM
	--(
	--	select xx.UserID,UserName,Flag,SchoolName,LikeCount + y.c1 + z.c2 LikeCount, Avatar, LikeCount as StarCount, SchoolCode, FirstName
	--	from (
	--	SELECT U.UserID,U.UserName, C.Flag, S.Name1 as SchoolName, COUNT(islike)*10 LikeCount, U.Avatar, S.SchoolCode,  U.FirstName
	--	FROM  UserMessage UM with(nolock)
	--	INNER JOIN [user] u on UM.SenderID = u.UserID
	--	INNER JOIN [Country] C on u.CountryID = C.CountryID
	--	INNER JOIN [SchoolInfo] S on U.SchoolID = S.SchoolID
	--	WHERE UM.SenderID > 0 and IsLike = 1 AND (isnull(@UserID,0) = 0 or U.UserID = @UserID) AND ((@LevelID <> 0 and u.levelid = @levelID)  OR U.LevelID not in (3,4))
	--	AND U.IsActive = 1
	--	GROUP BY U.USerID,U.UserName,C.Flag, S.Name1 , U.Avatar, S.SchoolCode, U.FirstName
	--	) xx
	--	INNER JOIN 
	--	(
	--		SELECT U.UserID,Count(u.UserID ) c1
	--		FROM  UserMessage UM with(nolock)
	--		INNER JOIN [user] u on UM.SenderID = u.UserID
	--		WHERE  (isnull(@UserID,0) = 0 or U.UserID = @UserID) AND ((@LevelID <> 0 and u.levelid = @levelID)  OR U.LevelID not in (3,4))
	--		GROUP BY U.USerID
	--	) y on xx.UserID= y.UserID 
	--	INNER JOIN 
	--	(
	--		SELECT U.UserID,Count(u.UserID ) c2
	--		FROM  UserMessage UM with(nolock)
	--		INNER JOIN [user] u on UM.RecepientID = u.UserID
	--		WHERE  (isnull(@UserID,0) = 0 or U.UserID = @UserID) AND ((@LevelID <> 0 and u.levelid = @levelID)  OR U.LevelID not in (3,4))
	--		GROUP BY U.USerID
	--	) z on xx.UserID= z.UserID 
	--) x
	--ORDER BY LikeCount DESC
END

