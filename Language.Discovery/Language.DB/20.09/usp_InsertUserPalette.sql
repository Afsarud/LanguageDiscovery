USE [Palaygo.11222018]
GO
/****** Object:  StoredProcedure [dbo].[usp_InsertUserPalette]    Script Date: 9/9/2020 12:17:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[usp_InsertUserPalette]
	@UserID bigint,
	@xml xml
AS
BEGIN

	DECLARE @UserPalette as table
	(
		UserID bigint,
		PaletteID bigint
	)

	DECLARE @UserSentence as table
	(
		SentenceID bigint
	)

	INSERT INTO @UserPalette
	SELECT @UserID,
			PX.value('(ID)[1]', 'bigint')
	FROM  @xml.nodes('UserPalettes/IDS') AS XD(PX)

	INSERT INTO @UserSentence
	SELECT [SentenceID] FROM [dbo].[Sentence] where PaletteID in (SELECT PaletteID from @UserPalette)

	delete UserPalette where PaletteID in (select PaletteID from @UserPalette) and UserID = @UserID
	delete MyPalette where PaletteID in (select PaletteID from @UserPalette)  and UserID = @UserID
	delete MySentence where PaletteID in (select PaletteID from @UserPalette)  and UserID = @UserID	
	delete MyPhrase where SentenceID in (select SentenceID from @UserSentence)  and UserID = @UserID	
		
	INSERT INTO UserPalette
	SELECT UserID, PaletteID, GETDATE()
	from @UserPalette

	INSERT INTO MyPalette ([PaletteID],[SchoolID],[PhraseCategoryID],[CreateDate],[CreatedBy],[ApprovedDate],[ApprovedBy],[Approved],[DefaultLanguageCode],[GroupID],[LanguageCode],[LevelID],[ModifiedDate],[ModifiedBy], UserID)
	SELECT [PaletteID],[SchoolID],[PhraseCategoryID],[CreateDate],[CreatedBy],[ApprovedDate],[ApprovedBy],[Approved],[DefaultLanguageCode],[GroupID],[LanguageCode],[LevelID],[ModifiedDate],[ModifiedBy], @UserID
    FROM [dbo].[Palette]
	WHERE PaletteID IN (SELECT PaletteID from @UserPalette)

	INSERT INTO MySentence ([SentenceID],[PaletteID],[CreateDate],[CreatedBy],[SentenceSoundFile],[SentenceImageFile],[SentenceLanguageCode],[Keyword], UserID)
	SELECT [SentenceID],[PaletteID],[CreateDate],[CreatedBy],[SentenceSoundFile],[SentenceImageFile],[SentenceLanguageCode],[Keyword], @UserID
	FROM [dbo].[Sentence] where PaletteID in (SELECT PaletteID from @UserPalette)


	INSERT INTO MyPhrase([PhraseID],[SentenceID],[WordMapID],[Word],[Keyword],[PluralForm],[WordSoundFile],[WordImageFile],[Ordinal],[ParentID],[WordType], UserID)
	SELECT [PhraseID],[SentenceID],[WordMapID],[Word],[Keyword],[PluralForm],[WordSoundFile],[WordImageFile],[Ordinal],[ParentID],[WordType], @UserID
	FROM [dbo].[Phrase] where SentenceID in (SELECT SentenceID from @UserSentence)

	
END
