ALTER procedure [dbo].[usp_RegisterUser]
	@ParentsFullName nvarchar(50),
	@ParentsEmail nvarchar(50),
	@FirstName nvarchar(50),
	@SchoolEntry nvarchar(150),
	@Gender varchar(10),
	@Password nvarchar(50),
	@Reference nvarchar(250),
	@UserName nvarchar(50),
	@ID bigint output
as
begin
	Declare @CountryID int
	Declare @SchoolCode nvarchar(20)
	--Declare @UserName nvarchar(50)
	Declare @NativeLanguage nvarchar(50)
   Declare @LearningLanguage nvarchar(50)
   Declare @SubLanguage nvarchar(50)	
   Declare @LevelID int
   declare @SchoolID int 
	
	 SELECT @CountryID = CountryID, @SchoolCode = SchoolCode , @LevelID = LevelID, @SchoolID = SchoolID 
	 FROM SchoolInfo WHERE IsDefault = 1
	 
	 --set @UserName =  @FirstName + '@' + @SchoolCode 
	 
  if @CountryID = 1 -- australia quickfix
	 begin
	 
 		 select @nativelanguage = LanguageCode
		 from [Language] 
		 where LanguageCode = 'en-US'
		 
		 select @learninglanguage = LanguageCode, @sublanguage = SubLanguageCode
		 from [Language] 
		 where LanguageCode = 'ja-JP'


	 end
	 else -- japanese
	 begin
	 
		 select @nativelanguage = LanguageCode
		 from [Language] 
		 where LanguageCode = 'ja-JP'
		 
 		 select @learninglanguage = LanguageCode
		 from [Language] 
		 where LanguageCode = 'en-US'
	 end	 
	 

	IF @nativelanguage = 'ja-JP'
	BEGIN

		INSERT INTO [User] (createdate, ParentsName, Email, FirstName,SchoolID,Gender,[Password], Reference, UserName,
				NativeLanguage,LearningLanguage,SubNativeLanguage, Avatar, IsActive, TrialExpirationDate, UserTypeID, CountryID, AfterSchool, LevelID, SchoolEntry, IsDemo, HasAgreedTC   )
			VALUES (getdate(),@ParentsFullName, @ParentsEmail, @FirstName, @SchoolID, @Gender, @Password, @Reference, @UserName, 
				@NativeLanguage, @LearningLanguage, @SubLanguage, 
				case when @Gender = 'Male' then 'AB-1.png' when @Gender='Female' then 'JG-1.png' end, 1, DATEADD(D,27,getdate() ), 3, @CountryID, 1, @LevelID, @SchoolEntry, 1, 1 )
	END
	ELSE
	BEGIN
		INSERT INTO [User] (createdate, TeachersName, Email, FirstName,SchoolID,Gender,[Password], Reference, UserName,
				NativeLanguage,LearningLanguage,SubNativeLanguage, Avatar, IsActive, TrialExpirationDate, UserTypeID, CountryID, AfterSchool, LevelID, SchoolEntry, IsDemo, HasAgreedTC   )
			VALUES (getdate(),@ParentsFullName, @ParentsEmail, @FirstName, @SchoolID, @Gender, @Password, @Reference, @UserName, 
				@NativeLanguage, @LearningLanguage, @SubLanguage, 
				case when @Gender = 'Male' then 'AB-1.png' when @Gender='Female' then 'JG-1.png' end, 1, DATEADD(D,27,getdate() ), 2, @CountryID, 1, @LevelID, @SchoolEntry, 1, 1 )
	END

	set @ID = SCOPE_IDENTITY()
end
