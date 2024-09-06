ALTER procedure [dbo].[usp_InsertUser]
 @UserName nvarchar(50)
   ,@FirstName nvarchar(50)
   ,@MiddleName nvarchar(50) = null
   ,@LastName nvarchar(50)
   ,@Address nvarchar(250)
   ,@DateOfBirth datetime = null
   ,@Telephone nvarchar(20) = null
   ,@Fax nvarchar(20) = null
   ,@Email nvarchar(50) = null
   ,@Password nvarchar(50) = null
   ,@Password2 nvarchar(50) = null
   ,@ClassID int = 1 
   ,@UserTypeID int = 3 
   ,@CountryID int = 1
   ,@CityID int = 1
   ,@SchoolID int = 7
   ,@LevelID int = 1
   ,@IsPalleteVisible bit = 1
   --,@NativeLanguage nvarchar(10) = null
   --,@LearningLanguage nvarchar(10) = null
   --,@SubNativeLanguage nvarchar(10) = null
   ,@TeachersName nvarchar(50) = null
   ,@ParentsName nvarchar(50) = null
   ,@Gender nvarchar(10) = null
   ,@IsActive bit = 0
   ,@AfterSchool bit = 0
   ,@IsRobot bit = 0
   ,@AllowTalk bit = 0 
   ,@HasAgreedTC bit = 0
   ,@TrialExpirationDate datetime = null
   ,@Custom1 varchar(50) = null
   ,@Custom2 varchar(50) = null
   ,@Custom3 varchar(50) = null
   ,@Note1 varchar(50) = null
   ,@Note2 varchar(50) = null
   ,@Note3 varchar(50) = null
   ,@Note4 varchar(50) = null
   ,@EnabledFreeMessage bit
   ,@SoundAndMail bit
   ,@ShouldUpdateTalkTime bit = 0
   ,@TotalTime int = 0
   ,@BalanceTime int = 0
   ,@SessionTime int = 0
   ,@ID bigint output
as
begin

DECLARE @IsDemo bit
declare @nativelanguage nvarchar(10)
declare @learninglanguage nvarchar(10)
declare @sublanguage nvarchar(10)
declare @sublanguage2 nvarchar(10)

select @IsDemo = ST.IsDemo, @nativelanguage = NativeLanguage, @learninglanguage = LearningLanguage 
FROM SchoolInfo SI
INNER JOIN SchoolType ST ON SI.SchoolTypeID = ST.SchoolTypeID
WHERE SI.SchoolID = @SchoolID

   
 INSERT INTO [User]
      ([UserName]
      ,[FirstName]
      ,[MiddleName]
      ,[LastName]
      ,[Address]
      ,[DateOfBirth]
      ,[Telephone]
      ,[Fax]
      ,[Email]
      ,[Password]
      ,[Password2]
      ,[CreateDate]
      ,[ModifiedDate]
      ,[ClassID]
      ,[UserTypeID]
      ,[CountryID]
      ,[CityID]
      ,[SchoolID]
      ,[LevelID]
      ,[IsPalleteVisible]
      --,[NativeLanguage]
      --,[LearningLanguage]
      --,[SubNativeLanguage]
      ,[TeachersName]
      ,[ParentsName]
      ,[Gender]
      ,Avatar
      ,IsActive
      ,AfterSchool
      ,IsDemo
      ,IsRobot
	  ,AllowTalk
	  ,HasAgreedTC
	  ,TrialExpirationDate
	  ,Custom1
	  ,Custom2
	  ,Custom3
	  ,Note1
	  ,Note2
	  ,Note3
	  ,Note4
	  ,EnabledFreeMessage
	  ,SoundAndMail)
   VALUES
      (@UserName
      ,@FirstName
      ,@MiddleName
      ,@LastName
      ,@Address
      ,@DateOfBirth
      ,@Telephone
      ,@Fax
      ,@Email
      ,@Password
      ,@Password2
      ,GETDATE()
      ,GETDATE()
      ,@ClassID
      ,@UserTypeID
      ,@CountryID
      ,@CityID
      ,@SchoolID
      ,@LevelID
      ,@IsPalleteVisible
      --,@NativeLanguage
      --,@LearningLanguage
      --,@SubNativeLanguage
      ,@TeachersName
      ,@ParentsName
      ,@Gender
      ,case when @Gender = 'Male' then 'AB-1.png' when @Gender='Female' then 'JG-1.png' end
      ,@IsActive
      ,@AfterSchool
      ,isnull(@IsDemo,0)
      ,@IsRobot
	  ,@AllowTalk
	  ,@HasAgreedTC
	  ,@TrialExpirationDate
	  ,Case When isnull(@Custom1,'') = '' THEN NULL ELSE @Custom1 END 
	  ,Case When isnull(@Custom2,'') = '' THEN NULL ELSE @Custom2 END
	  ,Case When isnull(@Custom3,'') = '' THEN NULL ELSE @Custom3 END
	  ,Case When isnull(@Note1,'') = '' THEN NULL ELSE @Note1  END
	  ,Case When isnull(@Note2,'') = '' THEN NULL ELSE @Note2  END
	  ,Case When isnull(@Note3,'') = '' THEN NULL ELSE @Note3  END
	  ,Case When isnull(@Note4,'') = '' THEN NULL ELSE @Note4  END
	  ,@EnabledFreeMessage
	  ,@SoundAndMail)
      
 SET @ID = SCOPE_IDENTITY()
 


	 --declare @nativelanguage nvarchar(10)
	 --declare @learninglanguage nvarchar(10)

	 --declare @sublanguage nvarchar(10)
	 --declare @sublanguage2 nvarchar(10)


	 
	 if @CountryID = 1 -- australia quickfix
	 begin
	 
 		-- select @nativelanguage = LanguageCode
		 --from [Language] 
		 --where LanguageCode = 'en-US'
		 
		 select @learninglanguage = LanguageCode, @sublanguage = SubLanguageCode, 
				@sublanguage2 = SubLanguageCode2
		 from [Language] 
		 where LanguageCode = @learninglanguage

		 --select @learninglanguage = LanguageCode, @sublanguage = SubLanguageCode, @sublanguage2 = SubLanguageCode2
		 --from [Language] 
		 --where LanguageCode = 'ja-JP'


	 end
	 else IF @CountryID = 2-- japanese
	 begin
	 
		 select @nativelanguage = LanguageCode, @sublanguage2 = SubLanguageCode2
		 from [Language] 
		 where LanguageCode = @nativelanguage 
		 
 		 select @learninglanguage = LanguageCode
		 from [Language] 
		 where LanguageCode = 'en-US'


	 end
	 else IF @CountryID = 3--Chinese
	 begin
	 
		 select @nativelanguage = LanguageCode, @sublanguage2 = SubLanguageCode2
		 from [Language] 
		 where LanguageCode = @nativelanguage
		 
 		 select @learninglanguage = LanguageCode
		 from [Language] 
		 where LanguageCode = 'en-US'
	 end


	UPDATE [User] set LearningLanguage = @learninglanguage, NativeLanguage=@nativelanguage, SubNativeLanguage=@sublanguage, SubNativeLanguage2=@sublanguage2
	where UserID = @ID


	IF @ShouldUpdateTalkTime = 1 AND EXISTS(Select * FROM UserTalkSubscription where UserID = @ID and IsActive = 1)
	 BEGIN
		UPDATE UserTalkSubscription set SessionTime = @SessionTime, BalanceTime = @BalanceTime, TotalTime = @TotalTime where UserID = @ID
		Update SchoolInfo set TalkTime = TalkTime - @TotalTime where SchoolID = @SchoolID
	 END
	 ELSE
	 BEGIN
		INSERT INTO UserTalkSubscription VALUES (@ID, @SessionTime, @BalanceTime, @TotalTime, GETDATE(), 1)
		Update SchoolInfo set TalkTime = TalkTime - @TotalTime where SchoolID = @SchoolID
	 END
 
end