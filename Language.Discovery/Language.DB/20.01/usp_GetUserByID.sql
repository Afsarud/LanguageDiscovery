ALTER PROCEDURE [dbo].[usp_GetUserByID]
 @ID int
as
begin


 SELECT U.* , C.CountryName, CI.CityName, UT.UserTypeName, L.LevelName, isnull(uts.TotalTime,0) TotalTime, isnull(uts.SessionTime,0) SessionTime, isnull(uts.BalanceTime, -1) BalanceTime
 FROM [User] U
 left JOIN Country C on u.CountryID = C.CountryID
 left JOIN City CI on U.CityID = CI.CityID
 left join UserType UT on U.UserTypeID = UT.UserTypeID
 left JOIN [Level] L on U.LevelID = L.LevelID
 left join UserTalkSubscription uts on u.UserID = uts.UserID and uts.IsActive =1
 
 WHERE u.[UserID] = @ID

end


