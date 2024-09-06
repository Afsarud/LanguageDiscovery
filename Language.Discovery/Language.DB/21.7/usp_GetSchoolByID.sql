USE [Palaygo_04242021]
GO
/****** Object:  StoredProcedure [dbo].[usp_GetSchoolByID]    Script Date: 7/4/2021 7:50:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[usp_GetSchoolByID]
 @ID int
as
begin

 SELECT S.[SchoolID]
      ,[SchoolCode]
      ,[Name1]
      ,[Name2]
      ,s.[SchoolTypeID]
      ,[CountryID]
      ,[Address]
      ,[Telephone]
      ,[Url]
      ,[Email]
      ,[PreparedBy]
      ,[Password]
      ,[License]
      ,[StartTime]
      ,[EndTime]
      ,[MailCheck]
      ,[CreateDate]
      ,[ModifiedDate]
      ,[ModifiedBy]
      ,[CreatedBy]
      ,[ShowPhraseOrder]
      ,[ShowNativeLanguage]
      ,[AfterSchool]
      ,[SchoolPallete]
      ,[GroupOnly]
      ,[PhraseOrderCheck]
      ,[SchoolTimeException]
      ,[SameLanguageMail]
      ,[RegistryCode]
      ,S.[LevelID]
      ,[SchoolKey]
      ,[DefaultLanguageOrder]
      ,[ShowSubLanguage2]
      ,IsNull(S.[AllowSameCountry],0) AllowSameCountry
	  ,isnull(U.StudentCount,0) StudentCount
	  , L.IsLevelDemo
	  ,SC.IsRobot
	  ,NativeLanguage 
	  ,LearningLanguage
	  ,SendPasswordToTeacher
	  ,TeachersEmail
	  ,ShowRomanji
	  ,EnabledFreeMessage
	  ,SoundAndMail
	  ,TalkTime
	  ,IsDefault
	  ,SC.IsDemo IsSchoolDemo
	  ,OrderByLearningLanguageFlag
 FROM [SchoolInfo] S
 left JOIN (
		select count(schoolid) StudentCount, SchoolID from [User] U group by SchoolID
		) U on S.SchoolID = U.SchoolID
 left JOIN [Level]	L on S.LevelID = L.LevelID
 INNER JOIN SchoolType SC on s.SchoolTypeID = sc.SchoolTypeID
 WHERE S.[SchoolID] = @ID

end


