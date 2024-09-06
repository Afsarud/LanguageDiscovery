ALTER PROCEDURE [dbo].[usp_Authenticate]
	@UserName nvarchar(50),
	@Password nvarchar(20),
	@IsAdminLogin bit = 0
AS
BEGIN

	SET NOCOUNT ON
	
	DECLARE @UserID bigint
	DECLARE @SchoolID bigint
	DECLARE @StartTime int
	DECLARE @EndTime int
	DECLARE @AfterSchool bit
	DECLARE @SchoolKey bit
	DECLARE @UserTypeID int
	DECLARE @UserAfterSchool bit
	DECLARE @IsDemo bit
	declare @PermissionStatus as nvarchar(50)
	declare @OtherLanguage as nvarchar(50)

	declare @Languages as table
	(
		LanguageCode nvarchar(100)
	)


	
	SELECT @UserID = U.UserID, @SchoolID = U.SchoolID, @UserTypeID = U.UserTypeID, 
		@UserAfterSchool = U.AfterSchool, @IsDemo = U.IsDemo,
		@PermissionStatus =  Case WHEN S.SchoolTypeID = 1  AND S.AfterSchool = 0 AND isnull(L.IsLevelDemo,0) = 0 THEN 'deniedlogin' -- denied
		WHEN S.SchoolTypeID = 1 AND S.AfterSchool = 1 AND isnull(L.IsLevelDemo,0) = 0 AND isnull(U.Email,'') = '' THEN 'permissionrequired'
		WHEN S.SchoolTypeID = 1 AND S.AfterSchool = 1 AND isnull(L.IsLevelDemo,0) = 0 AND isnull(U.Email,'') <> '' THEN 'continuelogin'
		WHEN S.SchoolTypeID = 3 AND S.AfterSchool = 1 AND isnull(L.IsLevelDemo,0) = 0 THEN 'continuelogin'
		WHEN S.SchoolTypeID = 3 AND S.AfterSchool = 0 AND isnull(L.IsLevelDemo,0) = 0 AND isnull(U.Email,'') = '' THEN 'permissionrequired'
		WHEN S.SchoolTypeID = 3 AND S.AfterSchool = 0 AND isnull(L.IsLevelDemo,0) = 0 AND isnull(U.Email,'') <> '' THEN 'continuelogin'
		WHEN S.SchoolTypeID = 4 AND isnull(L.IsLevelDemo,0) = 0 AND isnull(U.Email,'') = '' THEN 'permissionrequired'
		END 
		FROM [User] U
		INNER JOIN [Level] L On U.LevelID = U.LevelID 
		left JOIN SchoolInfo S on u.SchoolID = S.SchoolID 
		WHERE UserName = @UserName AND U.[Password] = @Password	COLLATE SQL_Latin1_General_CP1_CS_AS

	INSERT INTO @Languages
	select NativeLanguage from [user] where userid = @UserID
	union all 
	select LearningLanguage from [user] where userid = @UserID
		
	
	SELECT @StartTime = StartTime, @EndTime = EndTime, @AfterSchool = AfterSchool, @SchoolKey = SchoolKey
	FROM SchoolInfo WHERE SchoolID = @SchoolID
	
	
	IF @SchoolKey = 0 
	begin
		select null
	end
	else if (@UserTypeID < 3) OR (@AfterSchool = 1 AND @UserAfterSchool = 1 ) OR @IsDemo = 1 OR (@AfterSchool=0 AND @PermissionStatus='continuelogin' )
		OR (((@SchoolKey = 1 AND (DATEPART(HH,GETDATE())*60 + DATEPART(mi,GETDATE())) between @StartTime*60 and @EndTime*60)))
	begin

		select distinct @OtherLanguage =
			stuff((
				select ',' + l.LanguageCode
				from Language l
				where l.LanguageCode = LanguageCode
				and l.LanguageCode not in (select languagecode from @Languages)
				order by L.LanguageCode
				for xml path('')
			),1,1,'')  
		from language
		
		group by LanguageCode

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
	  ,UT.UserTypeName
      ,U.Theme
	  ,U.GradeID
	  ,U.DontShowVideo
	  ,U.DontShowNewTab
	  ,U.Skin
	  ,U.SubNativeLanguage2
  	  ,U.IsDemo
	  ,U.TrialExpirationDate
	  ,cast(CASE WHEN U.TrialExpirationDate < GETDATE() then 1 ELSE 0 END as bit) IsTrialExpired
	  ,U.IsRobot
	  ,U.Reference
  	  ,U.SchoolEntry
	  ,U.SchoolID
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
	,G.GradeName 
	,SequenceOptionFlag
	,NativeOptionFlag
	,SubLanguageOptionFlag
	,SubLanguage2OptionFlag
	,StepOptionFlag
	,IsOptionUpdated
	,@OtherLanguage as OtherLanguage
	,coalesce(U.Custom3, U.Custom2, C.ClassName) ClassName
	,EnabledFreeMessage
	,SoundAndMail
	,U.IsCanTalk
	,U.DontShowQuickGuide
	,CO.CountryCode
	,U.NumberOfMatching
	,U.MatchingFrequency
	FROM [User] U
	LEFT JOIN (  SELECT Count(RecepientID) UnReadMessageCount, RecepientID
		FROM UserMessage with(nolock)
		WHERE RecepientID = @UserID and ReadDate is null
		Group By RecepientID   ) UM ON UM.RecepientID = @UserID
	INNER JOIN UserType UT on U.UserTypeID = UT.UserTypeID
	INNER JOIN [Level] L on U.LevelID = L.LevelID
	LEFT join Grade G on U.GradeID = G.GradeID
	LEFT JOIN Class C on U.ClassID = C.ClassID
	LEFT JOIN Country CO on U.CountryID = CO.CountryID
	WHERE UserName = @UserName AND [Password] = @Password  COLLATE SQL_Latin1_General_CP1_CS_AS
		
		IF ( EXISTS (SELECT 1 
					FROM [User]
					WHERE UserName = @UserName AND [Password] = @Password COLLATE SQL_Latin1_General_CP1_CS_AS) )
					BEGIN
						UPDATE [User] set LastLogin = GETDATE(), IsOnline = Case when @IsAdminLogin = 1 then 0 else 1 end , IsActive=1, HasAgreedTC = 1 WHERE UserName = @UserName AND [Password] = @Password COLLATE SQL_Latin1_General_CP1_CS_AS
						INSERT INTO UserLog VALUES (@UserID, GETDATE())
					END
		
		SET NOCOUNT OFF
	end
	else if (@AfterSchool = 0  AND not (DATEPART(HH,GETDATE())*60 + DATEPART(mi,GETDATE())) between @StartTime*60 and @EndTime*60)
	begin
		select null
	end
	else if (@SchoolKey = 0) OR (@SchoolKey = 1 AND not (DATEPART(HH,GETDATE())*60 + DATEPART(mi,GETDATE())) between @StartTime*60 and @EndTime*60)
	begin 
		select null
	end 
	
	
END
