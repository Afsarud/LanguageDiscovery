ALTER PROCEDURE [dbo].[usp_UpdateSchool]
 @ID int,
 @SchoolCode nvarchar(50)
   ,@Name1 nvarchar(50)
   ,@Name2 nvarchar(50) = null
   ,@SchoolTypeID int = null
   ,@CountryID int
   ,@LevelID int = null
   ,@Address nvarchar(max) = null
   ,@Telephone nvarchar(50) = null
   ,@Url nvarchar(max) = null
   ,@Email nvarchar(max)
   ,@PreparedBy nvarchar(50) = null
   ,@Password nvarchar(50) = null
   ,@License int
   ,@StartTime int
   ,@EndTime tinyint
   ,@ModifiedBy int = null
   ,@MailCheck bit
   ,@ShowPhraseOrder bit
   ,@ShowNativeLanguage bit
   ,@AfterSchool bit
   ,@SchoolPalette bit
   ,@SchoolKey bit
   ,@DefaultLanguageOrder nvarchar(50)
   ,@ShowSubLanguage2 bit
   ,@AllowSameCountry bit
   ,@NativeLanguage nvarchar(10)
   ,@LearningLanguage nvarchar(10)
   ,@SendPasswordToTeacher bit
   ,@TeachersEmail nvarchar(50) = null
   ,@ShowRomanji bit
   ,@EnabledFreeMessage bit
   ,@SoundAndMail bit
   ,@TalkTime int = 0
AS
BEGIN

 UPDATE [SchoolInfo]
 SET [SchoolCode] = @SchoolCode,
  [Name1] = @Name1,
  [Name2] = @Name2,
  [SchoolTypeID] = @SchoolTypeID,
  [CountryID] = @CountryID,
  [LevelID] = @LevelID,
  [Address] = @Address,
  [Telephone] = @Telephone,
  [Url] = @Url,
  [Email] = @Email,
  [PreparedBy] = @PreparedBy,
  --[Password] = @Password,
  [License] = @License,
  [StartTime] = @StartTime,
  [EndTime] = @EndTime,
  [ModifiedBy] = @ModifiedBy,
  [MailCheck] = @MailCheck,
  [ShowPhraseOrder] = @ShowPhraseOrder,
  [ShowNativeLanguage] = @ShowNativeLanguage,
  [AfterSchool] = @AfterSchool,
  [SchoolPallete] = @SchoolPalette,
  [SchoolKey] = @SchoolKey,
  [ModifiedDate] = GETDATE(),
  DefaultLanguageOrder = @DefaultLanguageOrder,
  ShowSubLanguage2 = @ShowSubLanguage2,
  AllowSameCountry = @AllowSameCountry,
  NativeLanguage = @NativeLanguage,
  LearningLanguage = @LearningLanguage ,
  SendPasswordToTeacher = @SendPasswordToTeacher,
  TeachersEmail = @TeachersEmail,
  ShowRomanji = @ShowRomanji,
  EnabledFreeMessage = @EnabledFreeMessage ,
  SoundAndMail = @SoundAndMail,
  TalkTime = @TalkTime
 WHERE [SchoolID] = @ID
 
  declare @sublanguagecode as nvarchar(10)

    select @sublanguagecode = SubLanguageCode from [Language]
  where LanguageCode = @LearningLanguage


 DECLARE @IsDemo bit

select @IsDemo = ST.IsDemo
FROM SchoolInfo SI
INNER JOIN SchoolType ST ON SI.SchoolTypeID = ST.SchoolTypeID
WHERE SI.SchoolID = @ID
 
 UPDATE [User] SET LevelID = @LevelID, 
	NativeLanguage = @NativeLanguage, 
	LearningLanguage=@LearningLanguage,
	SubNativeLanguage = @sublanguagecode,
	CountryID = @CountryID,
	IsDemo = @IsDemo,
	SubLanguageOptionFlag = @ShowRomanji,
	EnabledFreeMessage=@EnabledFreeMessage,
	SequenceOptionFlag = @ShowPhraseOrder,
	NativeOptionFlag = @ShowNativeLanguage,
	SubLanguage2OptionFlag = @ShowSubLanguage2,
	SoundAndMail = @SoundAndMail,
	AfterSchool = @AfterSchool
WHERE SchoolID = @ID

END

