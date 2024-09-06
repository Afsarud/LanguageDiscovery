SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure [dbo].[usp_UpdateUser]
 @ID int
   ,@UserName nvarchar(50)
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
   ,@SchoolID int = 1
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
as
begin
   
   
    declare @nativelanguage nvarchar(10)
	 declare @learninglanguage nvarchar(10)
	 declare @sublanguage nvarchar(10)
	 declare @sublanguage2 nvarchar(10)
	 declare @IsDemo int
	 
	select @IsDemo = ISNULL(ST.IsDemo,0),  @nativelanguage = NativeLanguage, @learninglanguage = LearningLanguage
	FROM SchoolInfo SI
	INNER JOIN SchoolType ST ON SI.SchoolTypeID = ST.SchoolTypeID
	WHERE SI.SchoolID = @SchoolID
	 
	 if @CountryID = 1 -- australia quickfix
	 begin
	 
 		-- select @nativelanguage = LanguageCode
		 --from [Language] 
		 --where LanguageCode = 'en-US'
		 
		select @learninglanguage = LanguageCode, @sublanguage = SubLanguageCode, 
				@sublanguage2 = SubLanguageCode2
		 from [Language] 
		 where LanguageCode = @learninglanguage 

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
	
	
 UPDATE [User]
 SET [UserName] = @UserName
  ,[FirstName] = @FirstName
  ,[MiddleName] = @MiddleName
  ,[LastName] = @LastName
  ,[Address] = @Address
  ,[DateOfBirth] = @DateOfBirth
  ,[Telephone] = @Telephone
  ,[Fax] = @Fax
  ,[Email] = @Email
  ,[Password] = @Password
  ,[Password2] = @Password2
  ,[ModifiedDate] = GETDATE()
  ,[ClassID] = @ClassID
  ,[UserTypeID] = @UserTypeID
  ,[CountryID] = @CountryID
  ,[CityID] = @CityID
  ,[SchoolID] = @SchoolID
  ,[LevelID] = @LevelID
  ,[IsPalleteVisible] = @IsPalleteVisible
  ,[NativeLanguage] = @NativeLanguage
  ,[LearningLanguage] = @LearningLanguage
  ,[SubNativeLanguage] = @sublanguage
  ,[TeachersName] = @TeachersName
  ,[ParentsName] = @ParentsName
  ,[Gender] = coalesce(@Gender,gender)
  ,IsActive = @IsActive
  ,AfterSchool = @AfterSchool
  ,IsDemo = @IsDemo
  ,IsRobot = @IsRobot 
  ,AllowTalk = @AllowTalk 
  ,HasAgreedTC = @HasAgreedTC 
  ,TrialExpirationDate = @TrialExpirationDate
   ,Custom1  = Case When isnull(@Custom1,'') = '' THEN NULL ELSE @Custom1 END 
   ,Custom2 = Case When isnull(@Custom2,'') = '' THEN NULL ELSE @Custom2 END
   ,Custom3 = Case When isnull(@Custom3,'') = '' THEN NULL ELSE @Custom3 END
   ,Note1 = Case When isnull(@Note1,'') = '' THEN NULL ELSE @Note1  END
   ,Note2 = Case When isnull(@Note2,'') = '' THEN NULL ELSE @Note2  END
   ,Note3 = Case When isnull(@Note3,'') = '' THEN NULL ELSE @Note3  END
   ,Note4 = Case When isnull(@Note4,'') = '' THEN NULL ELSE @Note4  END
   ,EnabledFreeMessage = @EnabledFreeMessage
   ,SoundAndMail = @SoundAndMail
 WHERE [UserID] = @ID
end