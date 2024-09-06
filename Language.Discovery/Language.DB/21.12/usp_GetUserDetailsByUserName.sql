USE [Palaygo_04242021]
GO
/****** Object:  StoredProcedure [dbo].[usp_GetUserDetailsByUserName]    Script Date: 12/25/2021 11:09:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure [dbo].[usp_GetUserDetailsByUserName]
	@UserName nvarchar(50)
as
BEGIN

	declare @ProfilePhoto nvarchar(50)
	declare @UserId bigint
	declare @StartTime int
	declare @EndTime int
	declare @SchoolID int
	declare @WithinRange bit
	
	SELECT @UserId = UserID, @SchoolID = SchoolID FROM [User] where UserName = @UserName
	
	SELECT @StartTime = StartTime, @EndTime = EndTime
	FROM SchoolInfo WHERE SchoolID = @SchoolID
	
	select @WithinRange = case when (DATEPART(HH,GETDATE())*60 + DATEPART(mi,GETDATE())) between @StartTime*60 and @EndTime*60 
						  then 1 else 0 end
						  
	select @ProfilePhoto = Photo FROM UserPhoto WHERE UserID = @UserID and IsProfilePhoto = 1
	IF @ProfilePhoto IS NULL
		SELECT TOP 1 @ProfilePhoto = Photo FROM UserPhoto WHERE UserID = @UserID

	SELECT U.[UserID]
      ,U.[UserNo]
      ,U.[UserName]
      ,U.[FirstName]
      ,U.[MiddleName]
      ,U.[LastName]
      ,U.[Address]
      ,U.[DateOfBirth]
      ,U.[Telephone]
      ,U.[Fax]
      ,U.[Email]
      ,U.[Password]
      ,U.[Password2]
      ,U.[CreateDate]
      ,U.[ModifiedDate]
      ,U.[ClassID]
      ,U.[UserTypeID]
      ,U.[CountryID]
      ,U.[CityID]
      ,U.[SchoolID]
      ,U.[LevelID]
      ,U.[IsPalleteVisible]
      ,U.[AfterSchool]
      ,U.[IsActive]
      ,U.[StatusText]
      ,U.[Avatar]
      ,U.[NativeLanguage]
      ,U.[LearningLanguage]
      ,U.[SubNativeLanguage]
      ,U.[TeachersName]
      ,U.[ParentsName]
      ,U.[LastLogin]
      ,U.[IsOnline]
      ,U.[Gender]
      ,U.[Introduction]
	  ,U.HasAgreedTC
	  ,Ut.UserTypeName
	  ,@ProfilePhoto
      ,U.Theme
      ,U.GradeID
      ,U.DontShowVideo
      ,U.DontShowNewTab
	  ,U.Skin
	  ,U.SubNativeLanguage2
  	  ,U.IsDemo
	  ,U.TrialExpirationDate
	  ,cast(CASE WHEN U.TrialExpirationDate < GETDATE() then 1 ELSE 0 END as bit) IsTrialExpired
	  ,Case WHEN S.SchoolTypeID = 1  AND S.AfterSchool = 1 AND @WithinRange = 1 THEN 'continuelogin'
			WHEN S.SchoolTypeID = 1  AND S.AfterSchool = 0 AND isnull(L.IsLevelDemo,0) = 0 THEN 'deniedlogin' -- denied
			WHEN S.SchoolTypeID = 1 AND S.AfterSchool = 1 AND isnull(L.IsLevelDemo,0) = 0 AND isnull(U.Email,'') = '' THEN 'permissionrequired'
			WHEN S.SchoolTypeID = 1 AND S.AfterSchool = 1 AND isnull(L.IsLevelDemo,0) = 0 AND isnull(U.Email,'') <> '' THEN 'continuelogin'
			WHEN S.SchoolTypeID = 3 AND S.AfterSchool = 1 AND isnull(L.IsLevelDemo,0) = 0 THEN 'continuelogin'
			WHEN S.SchoolTypeID = 3 AND S.AfterSchool = 0 AND isnull(L.IsLevelDemo,0) = 0 AND isnull(U.Email,'') = '' THEN 'permissionrequired'
			WHEN S.SchoolTypeID = 3 AND S.AfterSchool = 0 AND isnull(L.IsLevelDemo,0) = 0 AND isnull(U.Email,'') <> '' THEN 'continuelogin'
			WHEN S.SchoolTypeID = 4  AND isnull(L.IsLevelDemo,0) = 0 AND isnull(U.Email,'') = '' THEN 'permissionrequired'
		END PermissionStatus
	   ,U.Reference
	   ,U.SchoolEntry
	   ,U.AllowTalk
	   ,U.Furigana
	   ,U.Custom1
	   ,U.Custom2
	   ,U.Custom3
	   ,U.Custom4
	   ,U.Custom5
	   ,U.Note1
	   ,U.Note2
	   ,U.Note3
	   ,U.Note4
	   ,U.Note5
	   ,SequenceOptionFlag
	   ,NativeOptionFlag
	   ,SubLanguageOptionFlag
	   ,SubLanguage2OptionFlag
	   ,IsOptionUpdated
	   ,coalesce(U.Custom3, U.Custom2, C.ClassName) ClassName
	   ,SendPasswordToTeacher
	   ,TeachersEmail
	   ,U.SoundAndMail
	   ,U.IsCanTalk
	   ,U.DontShowQuickGuide
	   ,u.OrderByLearningLanguageFlag
	   ,U.IsSupport
	   ,cast(CASE WHEN U.PasswordExpiration IS NULL THEN 0 WHEN U.PasswordExpiration < GETDATE() THEN 1 ELSE 0 END as bit) ShouldChangePassword
	   ,LinkKey
	   ,UTS.SessionTime
	FROM [User] u 
	Inner join UserType Ut on u.UserTypeID =Ut.UserTypeID
	left JOIN [Level] L on U.LevelID = L.LevelID
	left JOIN SchoolInfo S on u.SchoolID = S.SchoolID 
	LEFT JOIN Class C on u.ClassID = C.ClassID
	LEFT JOIN UserTalkSubscription UTS on U.UserID = UTS.UserID AND UTS.IsActive = 1
	WHERE u.UserID = @UserId

END



