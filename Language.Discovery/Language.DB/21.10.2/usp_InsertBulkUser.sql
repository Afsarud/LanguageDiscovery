ALTER procedure [dbo].[usp_InsertBulkUser]
	@SchoolID bigint,
	@xml xml
as
begin
   
   DECLARE @User as Table
   (
		UserName nvarchar(50)
	   ,FirstName nvarchar(50)
	   ,MiddleName nvarchar(50)
	   ,LastName nvarchar(50)
	   ,[Address] nvarchar(250)
	   ,Telephone nvarchar(20)
	   ,Fax nvarchar(20)
	   ,Email nvarchar(50)
	   ,[Password] nvarchar(50)
	   ,Password2 nvarchar(50)
	   ,CreateDate datetime
	   ,ModifiedDate datetime
	   ,ClassID int
	   ,UserTypeID int
	   ,CountryID int
	   ,CityID int
	   ,SchoolID int
	   ,LevelID int
	   ,IsPalleteVisible bit
	   ,NativeLanguage nvarchar(10)
	   ,LearningLanguage nvarchar(10)
	   ,SubNativeLanguage nvarchar(10)
	   ,TeachersName nvarchar(50)
	   ,ParentsName nvarchar(50)
	   ,Gender nvarchar(10)
	   ,Avatar nvarchar(50)
	   ,IsActive bit
	   ,AfterSchool bit
   )
   
   Declare @CountryID int 
   Declare @LevelID int 
   --Declare @ClassID int 
   Declare @NativeLanguage nvarchar(50)
   Declare @LearningLanguage nvarchar(50)
   Declare @SubLanguage nvarchar(50)
   Declare @SubLanguage2 nvarchar(50)
   declare @Gender nvarchar(20)
   
   SELECT @CountryID = CountryID, @LevelID = LevelID,
   @nativelanguage = NativeLanguage, @learninglanguage = LearningLanguage 
   FROM SchoolInfo WHERE SchoolID  = @SchoolID
   
   --SELECT @ClassID = ClassId FROM Class WHERE SchoolID = @SchoolID
   
    if @CountryID = 1 -- australia quickfix
	 begin
	 
 		-- select @nativelanguage = LanguageCode
		 --from [Language] 
		 --where LanguageCode = 'en-US'
		 
		select @sublanguage = SubLanguageCode, 
				@sublanguage2 = SubLanguageCode2
		 from [Language] 
		 where LanguageCode = @learninglanguage 

		 --select @learninglanguage = LanguageCode, @sublanguage = SubLanguageCode
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
   
   INSERT INTO @User
    SELECT UX.value('(UserName)[1]', 'nvarchar(50)'),
			UX.value('(FirstName)[1]', 'nvarchar(50)'),
			UX.value('(MiddleName)[1]', 'nvarchar(50)'),
			UX.value('(LastName)[1]', 'nvarchar(50)'),
			UX.value('(Address)[1]', 'nvarchar(250)'),
			null,
			null,
			null,
			UX.value('(Password)[1]', 'nvarchar(50)'),
			null,
			GETDATE(),
			GETDATE(),
			UX.value('(ClassID)[1]', 'int'),
			3,
			@CountryID,
			0,
			@SchoolID,
			@LevelID,
			1,
			@NativeLanguage,
			@LearningLanguage,
			@SubLanguage,
			UX.value('(TeachersName)[1]', 'nvarchar(50)'),
			UX.value('(ParentsName)[1]', 'nvarchar(50)'),
			UX.value('(Gender)[1]', 'nvarchar(20)'),
			null,
			0,
			0
	FROM  @xml.nodes('ArrayOfUserContract/UserContract') AS XD(UX) 
   
 INSERT INTO [User]
      ([UserName]
      ,[FirstName]
      ,[MiddleName]
      ,[LastName]
      ,[Address]
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
      ,[NativeLanguage]
      ,[LearningLanguage]
      ,[SubNativeLanguage]
      ,[TeachersName]
      ,[ParentsName]
      ,[Gender]
      ,Avatar
      ,IsActive
      ,AfterSchool
	  ,PasswordExpiration)
     select [UserName]
      ,[FirstName]
      ,[MiddleName]
      ,[LastName]
      ,[Address]
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
      ,[NativeLanguage]
      ,[LearningLanguage]
      ,[SubNativeLanguage]
      ,[TeachersName]
      ,[ParentsName]
      ,[Gender]
      ,case when Gender = 'Male' then 'AB-1.png' when Gender='Female' then 'JG-1.png' end Avatar
      ,IsActive
      ,AfterSchool
	  ,DATEADD(d, -1, getdate())
       FROM @User
 end
