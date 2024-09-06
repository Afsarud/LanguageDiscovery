ALTER procedure [dbo].[usp_GetMessageLikeRanking]
	@UserID bigint
as
BEGIN

	SELECT top 30 ROW_NUMBER() over( order by Points desc ) Ranking,U.UserID,UserName,Flag, 
		Name1 SchoolName, Points LikeCount, Avatar, MessageCount,  SchoolCode, FirstName, Points, U.LevelID
	FROM (
		SELECT U.UserID,StarCount, MessageCount, StarCount + MessageCount + isnull(UA.Score,0) + isnull(UOP.OtherPoints,0) as Points
		FROM UserRank U
		LEFT JOIN ( SELECT UserID, SUM(isnull(Score,0)) Score FROM UserAttendance GROUP BY UserID ) UA ON U.UserID = UA.UserID
		LEFT JOIN ( SELECT UserID, SUM(isnull(Points,0)) OtherPoints FROM UserOtherPoints GROUP BY UserID ) UOP ON U.UserID = UOP.UserID
	) UR
	INNER JOIN [user] u on UR.UserID = u.UserID
	INNER JOIN [Country] C on u.CountryID = C.CountryID
	INNER JOIN [SchoolInfo] S on U.SchoolID = S.SchoolID
	--LEFT JOIN ( SELECT UserID, SUM(isnull(Score,0)) Score FROM UserAttendance GROUP BY UserID ) UA ON U.UserID = UA.UserID
	--LEFT JOIN ( SELECT UserID, SUM(isnull(Points,0)) OtherPoints FROM UserOtherPoints GROUP BY UserID ) UOP ON U.UserID = UOP.UserID
	WHERE (isnull(@UserID,0) = 0 or U.UserID = @UserID)
	Order by Points desc

END

