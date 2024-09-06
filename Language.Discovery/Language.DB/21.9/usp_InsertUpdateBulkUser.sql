USE [Palaygo_04242021]
GO
/****** Object:  StoredProcedure [dbo].[usp_InsertUpdateBulkUser]    Script Date: 9/12/2021 9:48:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure [dbo].[usp_InsertUpdateBulkUser]
	@SchoolID bigint,
	@xml xml
as
begin
   
   DECLARE @User as Table
   (
		UserID bigint
	   ,UserName nvarchar(50)
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
	   ,IsDemo bit default(0)
	   ,Furigana nvarchar(50)
   )
   
   Declare @SchoolTypeID int 
   Declare @IsDemo bit 
   Declare @CountryID int 
   Declare @LevelID int 
   --Declare @ClassID int 
   Declare @NativeLanguage nvarchar(50)
   Declare @LearningLanguage nvarchar(50)
   Declare @SubLanguage nvarchar(50)
   declare @sublanguage2 nvarchar(10)
   declare @Gender nvarchar(20)
   
   SELECT @CountryID = CountryID, @LevelID = LevelID, @SchoolTypeID=SchoolTypeID,
   @nativelanguage = NativeLanguage, @learninglanguage = LearningLanguage 
   FROM SchoolInfo WHERE SchoolID  = @SchoolID
   
   SELECT @IsDemo = isnull(IsDemo,0) FROM SchoolType where SchoolTypeID = @SchoolTypeID
   
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


		 select @learninglanguage = LanguageCode, @sublanguage = SubLanguageCode
		 from [Language] 
		 where LanguageCode = 'ja-JP'

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
    SELECT UX.value('(UserID)[1]', 'bigint'),
			UX.value('(UserName)[1]', 'nvarchar(50)'),
			UX.value('(FirstName)[1]', 'nvarchar(50)'),
			null,
			UX.value('(LastName)[1]', 'nvarchar(50)'),
			null,
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
			null,--UX.value('(TeachersName)[1]', 'nvarchar(50)'),
			null,--UX.value('(ParentsName)[1]', 'nvarchar(50)'),
			UX.value('(Gender)[1]', 'nvarchar(20)'),
			null,
			1,
			0,
			@IsDemo
			,UX.value('(Furigana)[1]', 'nvarchar(50)')
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
      ,IsDemo
      ,Furigana)
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
      ,IsDemo
      ,case when len(Furigana) = 0 THEN null else Furigana end
       FROM @User T
       where T.UserName not in (select UserName from [User])
       
  --     UPDATE [User] SET UserName = T.UserName, FirstName= T.FirstName, LastName = T.LastName, 
		--ClassID = T.ClassID, [Password] = T.[Password]
  --     FROM [User]
  --     INNER JOIN @User T ON [User].UserName = T.UserName
  --     where T.UserName in (select UserName from [User])
 end
