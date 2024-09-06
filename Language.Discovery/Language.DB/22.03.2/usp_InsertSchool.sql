USE [Palaygo_04242021]
GO
/****** Object:  StoredProcedure [dbo].[usp_InsertSchool]    Script Date: 3/16/2022 8:21:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[usp_InsertSchool]
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
   ,@CreatedBy int = null
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
   ,@OrderByLearningLanguageFlag bit = 0
   ,@AllowTalk bit = 0
   ,@ID int output
as
begin
   
 INSERT INTO [SchoolInfo]
      ([SchoolCode]
      ,[Name1]
      ,[Name2]
      ,[SchoolTypeID]
      ,[CountryID]
      ,[LevelID]
      ,[Address]
      ,[Telephone]
      ,[Url]
      ,[Email]
      ,[PreparedBy]
      --,[Password]
      ,[License]
      ,[StartTime]
      ,[EndTime]
      ,[CreatedBy]
      ,[ModifiedBy]
      ,[MailCheck]
      ,[ShowPhraseOrder]
      ,[ShowNativeLanguage]
      ,[AfterSchool]
      ,[SchoolPallete]
      ,[SchoolKey]
      ,[CreateDate]
      ,[ModifiedDate]
      ,DefaultLanguageOrder
      ,ShowSubLanguage2
      ,AllowSameCountry
      ,NativeLanguage
      ,LearningLanguage
	  ,SendPasswordToTeacher
	  ,TeachersEmail
	  ,ShowRomanji
	  ,EnabledFreeMessage
	  ,SoundAndMail
	  ,TalkTime
	  ,OrderByLearningLanguageFlag
	  ,AllowTalk)
   VALUES
      (@SchoolCode
      ,@Name1
      ,@Name2
      ,@SchoolTypeID
      ,@CountryID
      ,@LevelID
      ,@Address
      ,@Telephone
      ,@Url
      ,@Email
      ,@PreparedBy
      --,@Password
      ,@License
      ,@StartTime
      ,@EndTime
      ,@CreatedBy
      ,@ModifiedBy
      ,@MailCheck
      ,@ShowPhraseOrder
      ,@ShowNativeLanguage
      ,@AfterSchool
      ,@SchoolPalette
      ,@SchoolKey
      ,GETDATE()
      ,GETDATE()
      ,@DefaultLanguageOrder
      ,@ShowSubLanguage2
      ,@AllowSameCountry
      ,@NativeLanguage
      ,@LearningLanguage
	  ,@SendPasswordToTeacher
	  ,@TeachersEmail
	  ,@ShowRomanji
	  ,@EnabledFreeMessage
	  ,@SoundAndMail
	  ,@TalkTime
	  ,@OrderByLearningLanguageFlag
	  ,@AllowTalk)
      
 SET @ID = SCOPE_IDENTITY()
end

