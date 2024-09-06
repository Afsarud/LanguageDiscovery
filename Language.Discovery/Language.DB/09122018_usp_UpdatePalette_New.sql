ALTER procedure [dbo].[usp_UpdatePalette_New]
	@PaletteID bigint
	,@SchoolID bigint
	,@PhraseCategoryID bigint
	,@LevelID int
	,@UserID bigint
	,@SentenceXml xml
	,@PhraseXml xml
as
begin

	DECLARE @Sentence as Table
	(
		ID int identity(1,1),
		SentenceID bigint,
		PaletteID bigint,
		CreateDate datetime,
		CreatedBy bigint,		
		SentenceLanguageCode nvarchar(10),
		SentenceSoundFile nvarchar(50),
		Keyword nvarchar(50)
	)
	
	DECLARE @NewSentence as Table
	(
		ID int identity(1,1),
		SentenceID bigint,
		PaletteID bigint,
		CreateDate datetime,
		CreatedBy bigint,
		SentenceLanguageCode nvarchar(10),
		SentenceSoundFile nvarchar(50),
		Keyword nvarchar(50)
	)

	DECLARE @SentenceSound as Table
	(
		ID int identity(1,1),
		SentenceSoundID int,
		SentenceID bigint,
		LearningLanguageCode nvarchar(10),
		SoundFile nvarchar(50)
	)

	DECLARE @NewSentenceSound as Table
	(
		ID int identity(1,1),
		SentenceSoundID int,
		SentenceID bigint,
		LearningLanguageCode nvarchar(10),
		SoundFile nvarchar(50)
	)
	
	DECLARE @Phrase as Table
	(
		PhraseID bigint,
		SentenceID bigint,
		WordMapID bigint,
		Word nvarchar(50),
		Keyword nvarchar(50),
		WordSoundFile nvarchar(250),
		WordImageFile nvarchar(250),
		Ordinal int,
		WordType nvarchar(50)
	)
	
	DECLARE @NewPhrase as Table
	(
		PhraseID bigint,
		SentenceID bigint,
		WordMapID bigint,
		Word nvarchar(50),
		Keyword nvarchar(50),
		WordSoundFile nvarchar(250),
		WordImageFile nvarchar(250),
		Ordinal int,
		WordType nvarchar(50)
	)
	
	INSERT INTO @Sentence
	SELECT SX.value('(SentenceID)[1]', 'bigint'),
		SX.value('(PaletteID)[1]', 'bigint'),
		GETDATE(),
		SX.value('(CreatedBy)[1]', 'bigint'),
		SX.value('(LanguageCode)[1]', 'nvarchar(10)'),
		SX.value('(SoundFile)[1]', 'nvarchar(50)'),
		SX.value('(Keyword)[1]', 'nvarchar(50)')
    FROM  @SentenceXml.nodes('ArrayOfSentence/Sentence') AS XD(SX)

	INSERT INTO @SentenceSound
	SELECT  SX.value('(SentenceSoundID)[1]', 'int'),
		SX.value('(SentenceID)[1]', 'bigint'),
		SX.value('(LearningLanguageCode)[1]', 'nvarchar(10)'),
		SX.value('(SoundFile)[1]', 'nvarchar(50)')
    FROM  @SentenceXml.nodes('ArrayOfSentence/Sentence/SentenceSoundList/SentenceSound') AS XD(SX)

	
	-- Insert new sentence
	INSERT INTO @NewSentence
	select SentenceID, PaletteID, GETDATE(), CreatedBy, SentenceLanguageCode, SentenceSoundFile, Keyword
	from @Sentence
	--WHERE SentenceID <= 0
	
	--delete the new sentence in the old sentence list
	DELETE @Sentence WHERE SentenceID <=0

	INSERT INTO @NewSentenceSound
	Select SentenceSoundID, SentenceID, LearningLanguageCode, SoundFile
	From @SentenceSound

	Delete @SentenceSound where SentenceSoundID <= 0


	INSERT INTO @Phrase
	SELECT PX.value('(PhraseID)[1]', 'bigint'),
		PX.value('(SentenceID)[1]', 'bigint'),
		PX.value('(WordMapID)[1]', 'bigint'),
		PX.value('(Word)[1]', 'nvarchar(50)'),
		PX.value('(Keyword)[1]', 'nvarchar(50)'),
		PX.value('(SoundFile)[1]', 'nvarchar(250)'),
		PX.value('(ImageFile)[1]', 'nvarchar(250)'),
		PX.value('(Ordinal)[1]', 'int'),
		PX.value('(WordType)[1]', 'nvarchar(50)')
    FROM  @PhraseXml.nodes('ArrayOfPhrase/Phrase') AS XD(PX)
    
    
    
    INSERT INTO @NewPhrase
    SELECT PhraseID, SentenceID,WordMapID,Word,Keyword, WordSoundFile, WordImageFile,Ordinal, WordType
    FROM @Phrase
	where PhraseID <= 0
	--delete the new phrase in the old phrase
	delete @Phrase where SentenceID <= 0
	
	--select * from @NewPhrase


	UPDATE Palette SET SchoolID = @SchoolID, PhraseCategoryID = @PhraseCategoryID , 
		LevelID = @LevelID,  ModifiedDate = getdate(), ModifiedBy = @UserID
	WHERE PaletteID = @PaletteID
	
	DECLARE @ID int
	DECLARE @RecordCount bigint
	
	SELECT @RecordCount = COUNT(1) FROM @NewSentence
	SET @ID = 1
	
	--select *  FROM @Sentence

		DECLARE @SentenceID bigint = null
		DECLARE @TempSentenceID bigint = null
		DECLARE @TempSentenceSoundID int
	
	--select * from @NewSentence
	--select * from @SentenceSound
	--select * from SentenceSound
	--select * from @NewSentenceSound

	WHILE ( @ID <= @RecordCount )
	BEGIN
		
		SELECT @TempSentenceID = SentenceID FROM @NewSentence WHERE ID = @ID
		
		IF @TempSentenceID <= 0
		BEGIN
			INSERT INTO Sentence (PaletteID, CreateDate, CreatedBy, SentenceLanguageCode, Keyword )
			SELECT @PaletteID, CreateDate, CreatedBy, SentenceLanguageCode, Keyword
			FROM @NewSentence
			WHERE ID = @ID
			
			SET @SentenceID = SCOPE_IDENTITY()


			--SELECT @TempSentenceSoundID = SentenceSoundID FROM @NewSentenceSound WHERE SentenceID = @TempSentenceID
			--INSERT INTO Sentence (PaletteID, CreateDate, CreatedBy, SentenceLanguageCode, Keyword )
			--SELECT PaletteID, CreateDate, CreatedBy, SentenceLanguageCode, Keyword
			--FROM @NewSentence
			--WHERE ID = @ID
			
			--SET @SentenceID = SCOPE_IDENTITY()
			INSERT INTO SentenceSound (SentenceID, LearningLanguageCode, SoundFile)
			SELECT SentenceID, LearningLanguageCode, SoundFile
			FROM @NewSentenceSound
			WHERE SentenceID = @TempSentenceID

			
			INSERT INTO Phrase ( SentenceID, WordMapID, Word,Keyword, WordSoundFile, WordImageFile, Ordinal, WordType )
			SELECT @SentenceID, WordMapID, Word,Keyword, WordSoundFile, WordImageFile, Ordinal, WordType
			FROM @NewPhrase
			WHERE SentenceID = @TempSentenceID AND isnull(Word,'') <> ''
		END
		ELSE
		BEGIN
			
			INSERT INTO SentenceSound (SentenceID, LearningLanguageCode, SoundFile)
			SELECT NSS.SentenceID, NSS.LearningLanguageCode, NSS.SoundFile
			FROM @NewSentenceSound NSS
			where cast(SentenceID as varchar) + LearningLanguageCode not in (select cast(SentenceID as varchar)+LearningLanguageCode From SentenceSound SS where ss.SentenceID = @TempSentenceID)
			--where SentenceID not in (select SentenceID From SentenceSound SS where ss.SentenceID = @TempSentenceID and ss.LearningLanguageCode  <> NSS.LearningLanguageCode)
						

			UPDATE SentenceSound Set SoundFile = Nss.SoundFile
			from SentenceSound SS
			INNER JOIN @NewSentenceSound NSS ON ss.SentenceID = nss.SentenceID and ss.LearningLanguageCode = nss.LearningLanguageCode
			
			Delete @NewSentenceSound where SentenceID = @TempSentenceID


			INSERT INTO Phrase ( SentenceID, WordMapID, Word,Keyword, WordSoundFile, WordImageFile, Ordinal, WordType )
			SELECT @TempSentenceID, WordMapID, Word,Keyword, WordSoundFile, WordImageFile, Ordinal, WordType
			FROM @NewPhrase
			WHERE SentenceID = @TempSentenceID AND isnull(Word,'') <> ''
		END
				
		SET @SentenceID  = NULL
		SET @TempSentenceID = NULL
			
			--TODO
			--UPDATE Phrase WordMapID, Word,Keyword, WordSoundFile, WordImageFile, Ordinal
			--FROM Phrase P 
			--INNER JOIN @Phrase temp on P.PhraseID = temp.PhraseID
		
		SET @ID = @ID + 1
	
	END
	
	--SET @ID = 1
	
	----select *  FROM @Sentence
	
	--SET @SentenceID  = NULL
	--SET @TempSentenceID = NULL
	
	--WHILE ( @ID <= @RecordCount )
	--BEGIN
	
		
		
		
	--	SELECT @TempSentenceID = SentenceID FROM @NewSentence WHERE ID = @ID
	--		--INSERT INTO Sentence (PaletteID, CreateDate, CreatedBy, SentenceLanguageCode, Keyword )
	--		--SELECT PaletteID, CreateDate, CreatedBy, SentenceLanguageCode, Keyword
	--		--FROM @NewSentence
	--		--WHERE ID = @ID
			
	--		--SET @SentenceID = SCOPE_IDENTITY()
			
	--		INSERT INTO Phrase ( SentenceID, WordMapID, Word,Keyword, WordSoundFile, WordImageFile, Ordinal )
	--		SELECT @TempSentenceID, WordMapID, Word,Keyword, WordSoundFile, WordImageFile, Ordinal
	--		FROM @NewPhrase
	--		WHERE SentenceID = @TempSentenceID AND isnull(Word,'') <> ''
			
	--		SET @SentenceID  = NULL
	--		SET @TempSentenceID = NULL
			
	--		--TODO
	--		--UPDATE Phrase WordMapID, Word,Keyword, WordSoundFile, WordImageFile, Ordinal
	--		--FROM Phrase P 
	--		--INNER JOIN @Phrase temp on P.PhraseID = temp.PhraseID
		
	--	SET @ID = @ID + 1
	
	--END
	
	--update old sentence
		UPDATE Sentence set SentenceLanguageCode = temp.SentenceLanguageCode, SentenceSoundFile = temp.SentenceSoundFile, Keyword = temp.Keyword
		FROM Sentence S
		INNER JOIN @Sentence temp on S.SentenceID = temp.SentenceID

	--update old phrase
		UPDATE Phrase SET Word = temp.Word, WordSoundFile = temp.WordSoundFile, 
			WordImageFile = temp.WordImageFile, Ordinal = temp.Ordinal, WordType= temp.WordType
		from Phrase P
		inner join @Phrase temp on P.PhraseID = temp.PhraseID	

end

