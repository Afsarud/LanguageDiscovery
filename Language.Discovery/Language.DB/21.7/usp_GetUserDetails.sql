USE [Palaygo_04242021]
GO
/****** Object:  StoredProcedure [dbo].[usp_GetUserDetails]    Script Date: 7/3/2021 11:56:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure [dbo].[usp_GetUserDetails]
	@UserID bigint
as
BEGIN

	--declare @ProfilePhoto nvarchar(50)
	
	--select @ProfilePhoto = Photo FROM UserPhoto WHERE UserID = @UserID and IsProfilePhoto = 1
	--IF @ProfilePhoto IS NULL
	--	SELECT TOP 1 @ProfilePhoto = Photo FROM UserPhoto WHERE UserID = @UserID

	--SELECT *, @ProfilePhoto FROM [User] WHERE UserID = @UserID
	
	
SELECT U.*, US.StatusText, US.UserStatusID, US.StatusDate, UP.Photo,  Slike.*,C.CountryName, CI.CityName, UT.UserTypeName, L.LevelName, CL.ClassName, G.GradeName 
	FROM [User] U
	left join UserStatus US on U.UserID =  US.UserID and US.IsDefault = 1
	left join UserPhoto UP on U.UserID = UP.UserID AND UP.IsProfilePhoto = 1
	LEFT JOIN (  SELECT Count( LikeByUserID ) LikeCount, UserStatusID
				FROM UserStatusLike
				Group By UserStatusID  ) SLike ON US.UserStatusID = SLike.UserStatusID
	LEFT JOIN (  SELECT Count(RecepientID) UnReadMessageCount, RecepientID
				FROM UserMessage  (nolock)
				WHERE RecepientID = @UserID
				Group By RecepientID   ) UM ON UM.RecepientID = U.UserID
	 INNER JOIN Country C on u.CountryID = C.CountryID
	 LEft JOIN City CI on U.CityID = CI.CityID
	 inner join UserType UT on U.UserTypeID = UT.UserTypeID
	 left JOIN [Level] L on U.LevelID = L.LevelID
	 left JOIN [Class] CL on U.ClassID= CL.ClassID
	 LEFT Join Grade G on U.GradeID = G.GradeID 
				
	WHERE U.UserID = @UserID
END

