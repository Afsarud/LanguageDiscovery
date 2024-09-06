USE [Palaygo.09272017]
GO
/****** Object:  StoredProcedure [dbo].[usp_SearchPhrase_dynamic_3]    Script Date: 10/30/2018 11:14:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[usp_SearchPhrase_dynamic_3]
	@RowsPerPage INT = 10, 
	@PageNumber INT = 1, 
	@Word nvarchar(50) = null,
	@Keyword NVARCHAR(500) = null,
	@CategoryID bigint = 0,
	@CategoryIDs nvarchar(100) = null,
	@SchoolID bigint = 0,
	@LevelID int =0,
	@IsAdmin bit = 0,
	@LanguageCode nvarchar(10) = null,
	@TopCategoryHeaderID int = 0,
	@SearcheeID bigint = 0,
	@IsTalk bit = 0,
	@VirtualCount int output
as
BEGIN

	declare @NativeLanguage nvarchar(20)
	declare @LearningLanguage nvarchar(20)
	
	select @NativeLanguage = ISNULL(u.NativeLanguage,''),
	@LearningLanguage = ISNULL(u.LearningLanguage,'')
	from [user] U
	where U.UserID = @SearcheeID

	declare @delimiter as char(1) = ' '
	if CHARINDEX(';',@Keyword) > 0 
	begin
		set @delimiter = ';'
	end
	
	declare @KeywordsFirstTable as TABLE
	(
		ID int identity(1,1),
		Keyword nvarchar(500)
	)
	declare @KeywordsTable as TABLE
	(
		ID int identity(1,1),
		Keyword nvarchar(500)
	)
	INSERT INTO @KeywordsFirstTable 
	SELECT * from dbo.ufn_Split(@Keyword, @delimiter)
	WHERE keyword like '*%'

	INSERT INTO @KeywordsTable 
	SELECT distinct * from dbo.ufn_Split(@Keyword, @delimiter)
	WHERE keyword not like '*%'

	declare @criteriaWord nvarchar(max) = ''
	declare @criteriaWordLike nvarchar(max) = ''
	declare @criteriaFirstKeywordLike nvarchar(100) = ''
	declare @criteriaKeyword nvarchar(max) = ''
	declare @id int
	declare @count int
	set @id = 1
	select @count = COUNT(1) from @KeywordsFirstTable 
	
	while @id <= @count
	begin
		select @criteriaFirstKeywordLike = @criteriaFirstKeywordLike + 'S.Keyword Like N''%' + replace(Keyword ,'''''''''','''''') + '%'' OR ' from  @KeywordsFirstTable where ID = @id
		set @id = @id + 1
	end

	set @id = 1
	select @count = COUNT(1) from @KeywordsTable
	while @id <= @count
	begin
		select @criteriaKeyword = @criteriaKeyword + 'S.Keyword Like N''%' + replace(Keyword ,'''''''''','''''') + '%'' OR ' from  @KeywordsTable where ID = @id
		set @id = @id + 1
	end


	select @criteriaWord = 'Word = N''' + @Word + ''' OR '
	select @criteriaWordLike = 'Word like N''%' + @Word + '%'' OR '

	set  @criteriaWord = case when len(@criteriaWord) > 0 then ' OR (' + reverse(stuff(reverse(@criteriaWord), 1, 3, '')) + ')' else '' end
	set  @criteriaWordLike = case when len(@criteriaWordLike) > 0 then ' OR (' + reverse(stuff(reverse(@criteriaWordLike), 1, 3, '')) + ')' else '' end
	set  @criteriaKeyword = case when len(@criteriaKeyword) > 0 then ' OR (' + reverse(stuff(reverse(@criteriaKeyword), 1, 3, '')) + ')' else '' end
	set  @criteriaFirstKeywordLike = case when len(@criteriaFirstKeywordLike) > 0 then ' OR (' + reverse(stuff(reverse(@criteriaFirstKeywordLike), 1, 3, '')) + ')' else '' end

	print @criteriaWord
	print @criteriaKeyword

	IF EXISTS (SELECT *FROM sys.tables WHERE name='#Groups')
		DROP TABLE #Groups
	
	CREATE table #Groups 
	(
		GroupID bigint
	)


	DECLARE @MainSQL nvarchar(max) 
	DECLARE @ParamDefinition nvarchar(max) 
	
	DECLARE @GroupID int
	DECLARE @GroupIDs nvarchar(100)
	DECLARE @SchoolPalette bit
	
	declare @tempWord nvarchar(50) = @word
		--declare @tempKeyword NVARCHAR(500) = @Keyword
		declare @tempCategoryID bigint = @CategoryID
		--declare @tempCategoryIDs nvarchar(100) = @CategoryIDs
		--declare @tempSchoolID bigint = @SchoolID
		--declare @tempLevelID int = @LevelID
		--declare @tempIsAdmin bit = 1
		--declare @tempLanguageCode nvarchar(10) = @LanguageCode
		--declare @tempTopCategoryHeaderID int = @TopCategoryHeaderID
		--declare @tempSearcheeID bigint = @SearcheeID
		--declare @tempIsTalk bit = @IsTalk
	
	SELECT @GroupID = GroupID FROM PhraseCategory WHERE PhraseCategoryID = @tempCategoryID

	INSERT INTO #Groups
	SELECT GroupID  FROM PhraseCategory WHERE PhraseCategoryID IN ( SELECT * from dbo.ufn_Split(@CategoryIDs, ','))
	
	SELECT @SchoolPalette = SchoolPallete FROM SchoolInfo WHERE SchoolID = @SchoolID
	
	set @ParamDefinition = '@RowsPerPage INT, @PageNumber INT, @Keyword NVARCHAR(1000), 
		@CategoryID bigint,@SchoolID bigint, @LevelID int, @GroupID int, 
		@SchoolPalette bit, @TopCategoryHeaderID int, @IsTalk bit, @VirtualCount int output'


	IF EXISTS (SELECT *FROM sys.tables WHERE name='#Palette')
		DROP TABLE #Palette
	IF EXISTS (SELECT *FROM sys.tables WHERE name='#PaletteTemp')
		DROP TABLE #PaletteTemp

	CREATE table #Palette
	(
		PaletteID bigint
	)

	CREATE table #PaletteTemp
	(
		PaletteID bigint,
		RowNum int identity(1,1)
	)

	
	DECLARE @Sentences as Table
	(
		SentenceID bigint,
		PaletteID bigint,
		ImageFile nvarchar(200),
		SoundFile nvarchar(200),
		LanguageCode nvarchar(10),
		Keyword nvarchar(150)
	)
	
	if @IsAdmin = 1
	BEGIN
		
	
		;WITH PS AS 
		(
			SELECT Distinct x.PaletteID, ROW_NUMBER() OVER (ORDER BY x.PaletteID) AS RowNum 
			FROM (SELECT Distinct PL.PaletteID
			FROM Phrase P
			INNER JOIN Sentence S on P.SentenceID = S.SentenceID
			INNER JOIN Palette PL on S.PaletteID = PL.PaletteID
			left JOIN PhraseCategory PC on PL.PhraseCategoryID = PC.PhraseCategoryID --AND PC.GroupID = @GroupID
			WHERE (isnull(@tempWord,'') = '' OR P.Word like + N'%' + @tempWord + '%')  
			AND (isnull(@Keyword,'') = '' OR S.Keyword like + N'%' +  @Keyword + '%') 
			AND (@LevelID = 0 OR PL.LevelID = @LevelID) --AND (@CategoryID = 0 OR PL.PhraseCategoryID = @CategoryID)
			AND (@SchoolID = 0 OR PL.SchoolID = @SchoolID) 
			AND (isnull(@CategoryID,0) = 0 OR PL.PhraseCategoryID = @CategoryID)
			--AND (isnull(@GroupID,0) = 0 OR PC.GroupID = @GroupID)
			AND (@SchoolID = 0 OR PL.SchoolID = 0 OR ( @SchoolPalette = 1 AND PL.SchoolID = @SchoolID ))
			AND (ISNULL(@LanguageCode,'') = '' OR S.SentenceLanguageCode=@LanguageCode)
			) X
			--AND @GroupID IS NULL OR PL.GroupID = @GroupID) X
			--AND PL.SchoolID = @SchoolID AND PL.Approved = 0
			
			--UNION ALL
			
			--SELECT Distinct x.PaletteID, ROW_NUMBER() OVER (ORDER BY x.PaletteID) AS RowNum 
			--FROM (SELECT Distinct PL.PaletteID
			--FROM Phrase P
			--INNER JOIN Sentence S on P.SentenceID = S.SentenceID
			--INNER JOIN Palette PL on S.PaletteID = PL.PaletteID
			--WHERE (@Word is null OR P.Word like @Word + '%')  AND (@Keyword is null OR P.Keyword like @Keyword + '%') 
			--AND @GroupID IS NULL OR PL.GroupID = @GroupID AND PL.Approved = 1) X
			
		)
		INSERT INTO #Palette
		SELECT distinct PS.PaletteID--, S.ImageFile, S.SoundFile, S.LanguageCode
		FROM PS 
		INNER JOIN Palette PL ON PS.PaletteID= PL.PaletteID
		--INNER JOIN Sentence S ON PL.PaletteID= S.PaletteID
		WHERE PS.RowNum BETWEEN ((@PageNumber-1)*@RowsPerPage)+1
		AND @RowsPerPage*(@PageNumber) 
		ORDER BY PS.PaletteID
	END
	ELSE
	BEGIN
	declare @orderby varchar(100) = '1'
	
	IF ISNULL(@Keyword,'') = '' 
	begin
		SET @orderby = 'x.PaletteID'
	end
	
		Set @MainSQL = '
				INSERT INTO #PaletteTemp
				SELECT Distinct PL.PaletteID
				FROM Phrase P
				INNER JOIN Sentence S on P.SentenceID = S.SentenceID
				INNER JOIN Palette PL on S.PaletteID = PL.PaletteID
				left JOIN PhraseCategory PC on PL.PhraseCategoryID = PC.PhraseCategoryID --AND PC.GroupID = @GroupID
				Left Join PhraseCategoryHeader PCH on PC.GroupID = PCH.PhraseCategoryHeaderID
				WHERE ((ISNULL(@Keyword,'''') = '''' ' + @criteriaFirstKeywordLike + '))
				AND (PL.LevelID = @LevelID OR PL.LevelID = 0) --AND (@CategoryID = 0 OR PL.PhraseCategoryID = @CategoryID)
				AND (@SchoolID = 0 OR PL.SchoolID = 0 OR ( @SchoolPalette = 1 AND PL.SchoolID = @SchoolID ))
				AND ((@IsTalk = 1 AND PC.GroupID in (select GroupID from #Groups)) OR (@IsTalk = 0 AND (@GroupID IS NULL OR PC.GroupID = @GroupID)) )
				AND (@TopCategoryHeaderID = 0 OR PCH.TopCategoryHeaderID = @TopCategoryHeaderID)
				and PL.PaletteID not IN (Select PaletteID from #PaletteTemp)

				
				INSERT INTO #PaletteTemp
				SELECT Distinct PL.PaletteID
				FROM Phrase P
				INNER JOIN Sentence S on P.SentenceID = S.SentenceID
				INNER JOIN Palette PL on S.PaletteID = PL.PaletteID
				left JOIN PhraseCategory PC on PL.PhraseCategoryID = PC.PhraseCategoryID --AND PC.GroupID = @GroupID
				Left Join PhraseCategoryHeader PCH on PC.GroupID = PCH.PhraseCategoryHeaderID
				WHERE ((ISNULL(@Keyword,'''') = '''' ' + @criteriaWordLike + '))
				AND (PL.LevelID = @LevelID OR PL.LevelID = 0) --AND (@CategoryID = 0 OR PL.PhraseCategoryID = @CategoryID)
				AND (@SchoolID = 0 OR PL.SchoolID = 0 OR ( @SchoolPalette = 1 AND PL.SchoolID = @SchoolID ))
				AND ((@IsTalk = 1 AND PC.GroupID in (select GroupID from #Groups)) OR (@IsTalk = 0 AND (@GroupID IS NULL OR PC.GroupID = @GroupID)) )
				AND (@TopCategoryHeaderID = 0 OR PCH.TopCategoryHeaderID = @TopCategoryHeaderID)
				and PL.PaletteID not IN (Select PaletteID from #PaletteTemp)

				INSERT INTO #PaletteTemp
				SELECT Distinct PL.PaletteID
				FROM Phrase P
				INNER JOIN Sentence S on P.SentenceID = S.SentenceID
				INNER JOIN Palette PL on S.PaletteID = PL.PaletteID
				left JOIN PhraseCategory PC on PL.PhraseCategoryID = PC.PhraseCategoryID --AND PC.GroupID = @GroupID
				Left Join PhraseCategoryHeader PCH on PC.GroupID = PCH.PhraseCategoryHeaderID
				WHERE ((ISNULL(@Keyword,'''') = '''' ' + @criteriaKeyword + '))
				AND (PL.LevelID = @LevelID OR PL.LevelID = 0) --AND (@CategoryID = 0 OR PL.PhraseCategoryID = @CategoryID)
				AND (@SchoolID = 0 OR PL.SchoolID = 0 OR ( @SchoolPalette = 1 AND PL.SchoolID = @SchoolID ))
				AND ((@IsTalk = 1 AND PC.GroupID in (select GroupID from #Groups)) OR (@IsTalk = 0 AND (@GroupID IS NULL OR PC.GroupID = @GroupID)) )
				AND (@TopCategoryHeaderID = 0 OR PCH.TopCategoryHeaderID = @TopCategoryHeaderID)
				and PL.PaletteID not IN (Select PaletteID from #PaletteTemp)

				INSERT INTO #PaletteTemp
				SELECT Distinct PL.PaletteID
				FROM Phrase P
				INNER JOIN Sentence S on P.SentenceID = S.SentenceID
				INNER JOIN Palette PL on S.PaletteID = PL.PaletteID
				left JOIN PhraseCategory PC on PL.PhraseCategoryID = PC.PhraseCategoryID --AND PC.GroupID = @GroupID
				Left Join PhraseCategoryHeader PCH on PC.GroupID = PCH.PhraseCategoryHeaderID
				WHERE ((ISNULL(@Keyword,'''') = '''' ' + @criteriaWord + '))
				AND (PL.LevelID = @LevelID OR PL.LevelID = 0) --AND (@CategoryID = 0 OR PL.PhraseCategoryID = @CategoryID)
				AND (@SchoolID = 0 OR PL.SchoolID = 0 OR ( @SchoolPalette = 1 AND PL.SchoolID = @SchoolID ))
				AND ((@IsTalk = 1 AND PC.GroupID in (select GroupID from #Groups)) OR (@IsTalk = 0 AND (@GroupID IS NULL OR PC.GroupID = @GroupID)) )
				AND (@TopCategoryHeaderID = 0 OR PCH.TopCategoryHeaderID = @TopCategoryHeaderID)
				and PL.PaletteID not IN (Select PaletteID from #PaletteTemp)

				INSERT INTO #PaletteTemp
				SELECT Distinct PL.PaletteID
				FROM Phrase P
				INNER JOIN Sentence S on P.SentenceID = S.SentenceID
				INNER JOIN Palette PL on S.PaletteID = PL.PaletteID
				left JOIN PhraseCategory PC on PL.PhraseCategoryID = PC.PhraseCategoryID --AND PC.GroupID = @GroupID
				Left Join PhraseCategoryHeader PCH on PC.GroupID = PCH.PhraseCategoryHeaderID
				WHERE (PL.LevelID = @LevelID OR PL.LevelID = 0) --AND (@CategoryID = 0 OR PL.PhraseCategoryID = @CategoryID)
				AND (@SchoolID = 0 OR PL.SchoolID = 0 OR ( @SchoolPalette = 1 AND PL.SchoolID = @SchoolID ))
				AND ((@IsTalk = 1 AND PC.GroupID in (select GroupID from #Groups)) OR (@IsTalk = 0 AND (@GroupID IS NULL OR PC.GroupID = @GroupID)) )
				AND isnull(@Keyword,'''') <> ''''
				AND (@TopCategoryHeaderID = 0 OR PCH.TopCategoryHeaderID = @TopCategoryHeaderID)
				and PL.PaletteID not IN (Select PaletteID from #PaletteTemp)
		
		INSERT INTO #Palette	
		SELECT PS.PaletteID--, S.ImageFile, S.SoundFile, S.LanguageCode
		FROM #PaletteTemp PS 
		INNER JOIN Palette PL ON PS.PaletteID= PL.PaletteID
		--INNER JOIN Sentence S ON PL.PaletteID= S.PaletteID
		WHERE PS.RowNum BETWEEN ((@PageNumber-1)*@RowsPerPage)+1
		AND @RowsPerPage*(@PageNumber) 
		--ORDER BY PS.PaletteID
	
		
		select @VirtualCount = count(PaletteID)
		from #PaletteTemp '

	  print @MainSQL

	  execute sp_executesql @MainSQL,@ParamDefinition,@RowsPerPage, @PageNumber, @Keyword, 
		@CategoryID,@SchoolID, @LevelID, @GroupID, @SchoolPalette, @TopCategoryHeaderID, @IsTalk, @VirtualCount = @VirtualCount output

	
	END
	
	if @IsAdmin = 1
	BEGIN
		select @VirtualCount = count(Distinct PL.PaletteID)
			FROM Phrase P
			INNER JOIN Sentence S on P.SentenceID = S.SentenceID
			INNER JOIN Palette PL on S.PaletteID = PL.PaletteID
			left JOIN PhraseCategory PC on PL.PhraseCategoryID = PC.PhraseCategoryID
			WHERE (isnull(@Word,'') = '' OR P.Word like + N'%' + @Word + '%')  
			AND (isnull(@Keyword,'') = '' OR S.Keyword like + N'%' +  @Keyword + '%') 
			AND (@LevelID = 0 OR PL.LevelID = @LevelID) --AND (@CategoryID = 0 OR PL.PhraseCategoryID = @CategoryID)
			AND (@SchoolID = 0 OR PL.SchoolID = 0 OR ( @SchoolPalette = 1 AND PL.SchoolID = @SchoolID ))
			AND (@GroupID IS NULL OR PC.GroupID = @GroupID)
			AND (ISNULL(@LanguageCode,'') = '' OR S.SentenceLanguageCode=@LanguageCode)
	end
		

	INSERT INTO @Sentences
	SELECT S.SentenceID, S.PaletteID, S.SentenceImageFile, S.SentenceSoundFile, S.SentenceLanguageCode, S.Keyword 
	FROM Sentence S
	INNER JOIN #Palette PL on S.PaletteID = PL.PaletteID
	
	

	SELECT PL.* 
	FROM #Palette P
	INNER JOIN Palette PL ON P.PaletteID = PL.PaletteID
	
	
	SELECT * FROM @Sentences

	--SELECT SS.*
	--FROM @Sentences S
	--INNER JOIN SentenceSound SS on S.SentenceID = SS.SentenceID
	
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
	FROM Phrase P
	INNER JOIN Sentence S ON P.SentenceID = S.SentenceID
	WHERE S.PaletteID IN (SELECT PaletteID FROM #Palette) AND P.Word <> ''
	
	

END