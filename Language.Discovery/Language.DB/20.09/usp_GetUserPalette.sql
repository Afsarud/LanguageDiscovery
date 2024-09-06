ALTER PROCEDURE [dbo].[usp_GetUserPalette]
	@UserID bigint,
	@RowsPerPage INT = 4, 
	@PageNumber INT = 1, 
	@VirtualCount int output
as
BEGIN

	DECLARE @Palette AS TABLE
	(
		RowNum int identity(1,1),
		PaletteID bigint
	)

	DECLARE @PaletteTemp AS TABLE
	(
		PaletteID bigint,
		RowNum int identity(1,1)
	)

	INSERT INTO @PaletteTemp
	SELECT Distinct UP.PaletteID
	FROM UserPalette UP
	WHERE UP.UserID = @UserID

	INSERT INTO @Palette	
		SELECT PS.PaletteID
		FROM @PaletteTemp PS 
		WHERE PS.RowNum BETWEEN ((@PageNumber-1)*@RowsPerPage)+1
		AND @RowsPerPage*(@PageNumber) 
		
		select @VirtualCount = count(PaletteID)
		from @PaletteTemp 
	
	

	SELECT PL.* 
	FROM @Palette P
	INNER JOIN MyPalette PL ON P.PaletteID = PL.PaletteID
	
	SELECT S.SentenceID, S.PaletteID, S.SentenceImageFile as ImageFile, S.SentenceSoundFile as SoundFile, S.SentenceLanguageCode as LanguageCode, S.Keyword 
	FROM MySentence S
	--where S.PaletteID in (select PaletteID from @Palette )
	INNER JOIN @Palette PL on S.PaletteID = PL.PaletteID
	ORDER BY PL.RowNum
	
	SELECT [PhraseID]
      ,P.[SentenceID]
      ,[WordMapID]
      ,Replace([Word],'''','&#39;') Word
      ,P.[Keyword]
	  ,P.[WordType]
      ,[PluralForm]
      ,[WordSoundFile]
      ,[WordImageFile]
      ,[Ordinal]
      ,[ParentID] 
	  ,P.[WordType]
      ,S.*
	FROM MyPhrase P
	INNER JOIN MySentence S ON P.SentenceID = S.SentenceID
	--INNER JOIN @Palette PP on S.PaletteID = PP.PaletteID
	--where P.Word <> ''
	WHERE S.PaletteID IN (SELECT PaletteID FROM @Palette) AND P.Word <> ''
	
	

END