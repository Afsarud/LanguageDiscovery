ALTER procedure [dbo].[usp_BulkInsertPalette]
	-- @SchoolID bigint
	
	--,@LevelID int
	--@UserID bigint
	@DeleteFirstThenAdd bit
	,@PhraseCategoryID bigint
	,@PaletteXml xml
	,@SentenceXml xml
	,@PhraseXml xml
as
begin



	DECLARE @Palette as Table
	(
		ID bigint identity(1,1),
		PaletteID bigint,
		SchoolID bigint,
		PhraseCategoryID bigint null,
		CreateDate datetime,
		CreatedBy bigint
	)


	DECLARE @Sentence as Table
	(
		ID int, --identity(1,1),
		SentenceID bigint,
		PaletteID bigint,
		CreateDate datetime,
		CreatedBy bigint,
		SentenceLanguageCode nvarchar(10),
		SentenceSoundFile nvarchar(50),
		Keyword nvarchar(50)
	)
	
	DECLARE @Phrase as Table
	(
		SentenceID bigint,
		WordMapID bigint,
		Word nvarchar(50),
		Keyword nvarchar(50),
		WordSoundFile nvarchar(250),
		WordImageFile nvarchar(250),
		Ordinal int,
		WordType nvarchar(50)

	)

	INSERT INTO @Palette
	SELECT SX.value('(PaletteID)[1]', 'bigint'),
		SX.value('(SchoolID)[1]', 'bigint'),
		SX.value('(PhraseCategoryID)[1]', 'bigint'),
		GETDATE(),
		SX.value('(CreatedBy)[1]', 'bigint')
    FROM  @PaletteXml.nodes('ArrayOfPaletteContract/PaletteContract') AS XD(SX)

	
	INSERT INTO @Sentence
	SELECT ROW_NUMBER() over (partition by SX.value('(PaletteID)[1]', 'bigint') order by SX.value('(PaletteID)[1]', 'bigint')),
		SX.value('(SentenceID)[1]', 'bigint'),
		SX.value('(PaletteID)[1]', 'bigint'),
		GETDATE(),
		SX.value('(CreatedBy)[1]', 'bigint'),
		SX.value('(LanguageCode)[1]', 'nvarchar(10)'),
		SX.value('(SoundFile)[1]', 'nvarchar(50)'),
		SX.value('(Keyword)[1]', 'nvarchar(50)')
    FROM  @SentenceXml.nodes('ArrayOfSentence/Sentence') AS XD(SX)


	INSERT INTO @Phrase
	SELECT PX.value('(SentenceID)[1]', 'bigint'),
		PX.value('(WordMapID)[1]', 'bigint'),
		PX.value('(Word)[1]', 'nvarchar(50)'),
		PX.value('(Keyword)[1]', 'nvarchar(50)'),
		PX.value('(SoundFile)[1]', 'nvarchar(250)'),
		PX.value('(ImageFile)[1]', 'nvarchar(250)'),
		PX.value('(Ordinal)[1]', 'int'),
		PX.value('(WordType)[1]', 'nvarchar(50)')
    FROM  @PhraseXml.nodes('ArrayOfPhrase/Phrase') AS XD(PX)
    
	--select * from @Palette
 --   select * from @Sentence
 --   select * from @Phrase
    
    --declare @UserType nvarchar(50)
    
    --select @UserType = UT.UserTypeName
    --FROM [User] U
    --INNER JOIN UserType UT ON U.UserTypeID = UT.UserTypeID
    --WHERE U.UserID = @UserID
    
    --DECLARE @Approved bit
    
    --set @Approved = case when @UserType='Administrator' then 1 else 0 end

	DECLARE @PaletteID as bigint
	DECLARE @TempPaletteID as bigint
	DECLARE @PID as bigint
	DECLARE @PaletteRecordCount int

	SELECT @PaletteRecordCount = COUNT(1) FROM @Palette
	SET @PID = 1


	IF @DeleteFirstThenAdd = 1 AND @PaletteRecordCount > 0
	BEGIN

		DELETE phrase where SentenceID in (select SentenceID 
										   from Sentence 
										   where PaletteID in ( select PaletteID from Palette where PhraseCategoryID = @PhraseCategoryID ))
		DELETE Sentence where PaletteID in ( select PaletteID from Palette where PhraseCategoryID = @PhraseCategoryID )
		DELETE Palette where PhraseCategoryID = @PhraseCategoryID
	END
    
	WHILE ( @PID <= @PaletteRecordCount ) 
	BEGIN

		INSERT INTO Palette ( SchoolID, PhraseCategoryID, CreateDate, CreatedBy)
		SELECT SchoolID,PhraseCategoryID, CreateDate, CreatedBy  FROM @Palette WHERE ID = @PID

		SELECT @TempPaletteID = PaletteID FROM @Palette where id = @PID
	
		SET @PaletteID = SCOPE_IDENTITY()
	
		DECLARE @ID int
		DECLARE @RecordCount bigint

		SELECT @RecordCount = COUNT(1) FROM @Sentence where PaletteID = @TempPaletteID
		SET @ID = 1
	
		WHILE ( @ID <= @RecordCount )
		BEGIN
	
			DECLARE @SentenceID bigint
			DECLARE @TempSentenceID bigint
		
			SELECT @TempSentenceID = SentenceID FROM @Sentence WHERE ID = @ID and PaletteID = @TempPaletteID
		
			IF EXISTS (SELECT 1 FROM @Phrase WHERE SentenceID = @TempSentenceID)
			BEGIN
				INSERT INTO Sentence (PaletteID, CreateDate, CreatedBy, SentenceLanguageCode, SentenceSoundFile, Keyword )
				SELECT @PaletteID, CreateDate, CreatedBy, SentenceLanguageCode, SentenceSoundFile, Keyword
				FROM @Sentence
				WHERE ID = @ID and PaletteID = @TempPaletteID
				SET @SentenceID = SCOPE_IDENTITY()
			END
		
			INSERT INTO Phrase ( SentenceID, WordMapID, Word,Keyword, WordSoundFile, WordImageFile, Ordinal,WordType )
			SELECT @SentenceID, WordMapID, Word,Keyword, WordSoundFile, WordImageFile, Ordinal, WordType
			FROM @Phrase
			WHERE SentenceID = @TempSentenceID AND ISNULL(Word,'' )  <> ''
		
			SET @SentenceID  = NULL
			SET @TempSentenceID = NULL
		
			SET @ID = @ID + 1
	
		END

		SET @PID = @PID + 1

	END
	

end

