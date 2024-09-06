ALTER PROCEDURE [dbo].[usp_SearchWord_dynamic_3]
	@SchoolID bigint = 0,
	@RowsPerPage INT = 10,
	@PageNumber as INT = 1,
	@Word as nvarchar(50) = null,
	@Keyword as NVARCHAR(50) = null,
	@CategoryID as bigint = 0,
	@CategoryIDs nvarchar(100) = null,
	@SearcheeID bigint = 0,
	@TopCategoryHeaderID int = 0,
	@IsTalk bit = 0,
	@VirtualCount as int output
as
begin	

	declare @NativeLanguage nvarchar(20)
	declare @LearningLanguage nvarchar(20)
	
	select @NativeLanguage = ISNULL(u.NativeLanguage,''),
	@LearningLanguage = ISNULL(u.LearningLanguage,'')
	from [user] U
	where U.UserID = @SearcheeID



	declare @Result as TABLE
	(
		ID int identity(1,1),
		Keyword nvarchar(100)
	)
	INSERT INTO @Result 
	SELECT * from ufn_Split(@Keyword, ';')

	declare @criteria nvarchar(max)
	declare @exactcriteria nvarchar(max)
	declare @likecriteria nvarchar(max)
	declare @id int
	declare @count int
	set @id = 1
	select @count = COUNT(1) from @Result
	set @criteria = ''
	set @exactcriteria = ''
	set @likecriteria = ''
	while @id <= @count
	begin
		--select @criteria = @criteria + 'WH.Keyword Like N''%' + Keyword + '%'' OR W.Word Like N''%' + Keyword + '%'' OR ' from  @Result where ID = @id
		select @criteria = @criteria + 'WH.Keyword Like N''%' + replace(Keyword ,'''''''''','''''') + '%'' OR ' from  @Result where ID = @id
		
		set @id = @id + 1
	end

	DELETE @Result
	INSERT INTO @Result 
	SELECT * from ufn_Split(@Word, ';')

	select top 1 @id =  id from @result order by id
	select @count = max(ID) from @Result
	while @id <= @count
	begin
		select @exactcriteria = @exactcriteria + 'W.WORD = N''' + replace(Keyword ,'''''''''','''''') + ''' OR ' from  @Result where ID = @id
		select @likecriteria = @likecriteria + 'W.WORD like N''%' + replace(Keyword ,'''''''''','''''') + '%'' OR ' from  @Result where ID = @id
		
		set @id = @id + 1
	end
	set  @criteria = case when len(@criteria) > 0 then ' OR (' + reverse(stuff(reverse(@criteria), 1, 3, '')) + ')' else '' end
	set  @exactcriteria = case when len(@exactcriteria) > 0 then ' OR (' + reverse(stuff(reverse(@exactcriteria), 1, 3, '')) + ')' else '' end
	set  @likecriteria = case when len(@likecriteria) > 0 then ' OR (' + reverse(stuff(reverse(@likecriteria), 1, 3, '')) + ')' else '' end
	DECLARE @MainSQL nvarchar(max) 
	DECLARE @ParamDefinition nvarchar(max) 

	IF EXISTS (SELECT *FROM sys.tables WHERE name='#tempword')
		DROP TABLE #tempword

	CREATE TABLE #tempword
	(
		ID INT IDENTITY(1,1),
		WordHeaderID bigint	,
		rownum int	
	)
	

	IF EXISTS (SELECT *FROM sys.tables WHERE name='#Groups')
	DROP TABLE #Groups
	
	CREATE table #Groups 
	(
		GroupID bigint
	)


	DECLARE @GroupID int
	DECLARE @SchoolPalette bit
	declare @FirstQueryCount as int

	
	SELECT @GroupID = GroupID FROM PhraseCategory WHERE PhraseCategoryID = @CategoryID

	INSERT INTO #Groups
	SELECT GroupID  FROM PhraseCategory WHERE PhraseCategoryID IN ( SELECT * from dbo.ufn_Split(@CategoryIDs, ','))

	SELECT @SchoolPalette = SchoolPallete FROM SchoolInfo WHERE SchoolID = @SchoolID
	
	set @MainSQL = ';WITH tempword AS 
	(
		SELECT WH.WordHeaderID,  ROW_NUMBER() OVER (ORDER BY WordHeaderID) AS RowNum 
		FROM Word W
		INNER JOIN WordHeader WH on W.WordMapID = WH.WordHeaderID
		LEFT JOIN PhraseCategory PC ON WH.PhraseCategoryID = PC.PhraseCategoryID
		Left Join PhraseCategoryHeader PCH on PC.GroupID = PCH.PhraseCategoryHeaderID
		WHERE (ISNULL(@Word,'''') = '''' ' + @exactcriteria + ')
		--AND (PC.GroupID in (select GroupID from #Groups) )
		AND (@SchoolID = 0 OR isnull(W.SchoolID,0) = 0 OR ( @SchoolPalette = 1 AND W.SchoolID = @SchoolID ))
		AND (@TopCategoryHeaderID = 0 OR PCH.TopCategoryHeaderID = @TopCategoryHeaderID OR  WH.PhraseCategoryID = 0)
		--or WH.PhraseCategoryID = 0
		group by WH.WordHeaderID
		
	)
	INSERT INTO #tempword
	select * from tempword
	WHERE tempword.RowNum BETWEEN ((@PageNumber-1)*@RowsPerPage)+1
	AND @RowsPerPage*(@PageNumber) 
	order by RowNum

	select @FirstQueryCount = COUNT(1) from #tempword

	;WITH tempword AS 
	(
		SELECT WH.WordHeaderID,  ROW_NUMBER() OVER (ORDER BY WordHeaderID) AS RowNum 
		FROM Word W
		INNER JOIN WordHeader WH on W.WordMapID = WH.WordHeaderID
		LEFT JOIN PhraseCategory PC ON WH.PhraseCategoryID = PC.PhraseCategoryID
		Left Join PhraseCategoryHeader PCH on PC.GroupID = PCH.PhraseCategoryHeaderID
		WHERE ((ISNULL(@Word,'''') = '''' ' + @likecriteria + ')) AND WH.WordHeaderID not IN (select WordHeaderID from #tempword)
		--AND (PC.GroupID in (select GroupID from #Groups) )
		AND (@SchoolID = 0 OR isnull(W.SchoolID,0) = 0 OR ( @SchoolPalette = 1 AND W.SchoolID = @SchoolID ))
		AND (@TopCategoryHeaderID = 0 OR PCH.TopCategoryHeaderID = @TopCategoryHeaderID OR  WH.PhraseCategoryID = 0)
		--or WH.PhraseCategoryID = 0
		group by WH.WordHeaderID
		
	)
	INSERT INTO #tempword
	select * from tempword
	WHERE tempword.RowNum BETWEEN ((@PageNumber-1)*@RowsPerPage)+1
	AND (@RowsPerPage - @FirstQueryCount)*(@PageNumber) 
	order by RowNum

	IF @IsTalk = 1 AND ISNULL(@Word,'''') = ''''
	begin
		truncate table #tempword
	end

	


	select @FirstQueryCount = COUNT(1) from #tempword
	
	;WITH W AS 
	(
				
		SELECT WH.WordHeaderID,  ROW_NUMBER() OVER (ORDER BY WordHeaderID) AS RowNum 
		FROM Word W
		INNER JOIN WordHeader WH on W.WordMapID = WH.WordHeaderID
		LEFT JOIN PhraseCategory PC ON WH.PhraseCategoryID = PC.PhraseCategoryID
		Left Join PhraseCategoryHeader PCH on PC.GroupID = PCH.PhraseCategoryHeaderID
		WHERE ((ISNULL(@Keyword,'''') = '''' ' + @criteria + ')) AND WH.WordHeaderID not IN (select WordHeaderID from #tempword)
		--AND (PC.GroupID in (select GroupID from #Groups))
		AND ((@IsTalk = 1 AND PC.GroupID in (select GroupID from #Groups)) OR (@IsTalk = 0 AND (@GroupID IS NULL OR PC.GroupID = @GroupID) OR  WH.PhraseCategoryID = 0) )
		AND (@SchoolID = 0 OR isnull(W.SchoolID,0) = 0 OR ( @SchoolPalette = 1 AND W.SchoolID = @SchoolID ))
		AND (@TopCategoryHeaderID = 0 OR PCH.TopCategoryHeaderID = @TopCategoryHeaderID OR  WH.PhraseCategoryID = 0)
		 --OR WH.PhraseCategoryID = 0
		group by WH.WordHeaderID

	)
	INSERT INTO #tempword
	select * from w
	WHERE w.RowNum BETWEEN ((@PageNumber-1)*@RowsPerPage)+1
	AND (@RowsPerPage - @firstquerycount) * (@PageNumber)  

	;WITH W AS 
	(
		SELECT WH.WordHeaderID,  ROW_NUMBER() OVER (ORDER BY WordHeaderID) AS RowNum 
		FROM Word W
		INNER JOIN WordHeader WH on W.WordMapID = WH.WordHeaderID
		LEFT JOIN PhraseCategory PC ON WH.PhraseCategoryID = PC.PhraseCategoryID
		Left Join PhraseCategoryHeader PCH on PC.GroupID = PCH.PhraseCategoryHeaderID
		WHERE ((ISNULL(@Keyword,'''') = '''' ' + @criteria + '))
		--AND (PC.GroupID in (select GroupID from #Groups))
		AND ((@IsTalk = 1 AND PC.GroupID in (select GroupID from #Groups)) OR (@IsTalk = 0 AND (@GroupID IS NULL OR PC.GroupID = @GroupID) OR  WH.PhraseCategoryID = 0)  )
		AND (@SchoolID = 0 OR isnull(W.SchoolID,0) = 0 OR ( @SchoolPalette = 1 AND W.SchoolID = @SchoolID ))
		AND (@TopCategoryHeaderID = 0 OR PCH.TopCategoryHeaderID = @TopCategoryHeaderID OR  WH.PhraseCategoryID = 0)
		--OR WH.PhraseCategoryID = 0
		group by WH.WordHeaderID
	)
	select @VirtualCount = COUNT(1)
	from w
		
	SELECT [WordID]
      ,[LanguageCode]
      ,[WordMapID]
      ,Replace([Word],'''',''&#39;'') Word
      ,W.[Keyword]
      ,[PluralForm]
      ,[SoundFile]
      ,[SchoolID]
      ,W.[PhraseCategoryID]
      ,W.[CreateDate]
      ,[CreatedBy]
      ,[Ordinal]
      ,[ParentID]
      ,WC.ImageFile
	FROM Word W
	INNER JOIN WordHeader WC ON W.WordMapID = WC.WordHeaderID
	inner join #tempword t on WC.WordHeaderID = t.WordHeaderID
	order by t.ID'
	
	print @MainSQL
	set @ParamDefinition = '@RowsPerPage INT, @PageNumber INT, @Word NVARCHAR(1000), @Keyword NVARCHAR(1000), 
	@CategoryID bigint,@SchoolID bigint, @GroupID int, 
	@SchoolPalette bit, @FirstQueryCount int, @TopCategoryHeaderID int, @IsTalk bit, @VirtualCount int output'

		
	  execute sp_executesql @MainSQL,	@ParamDefinition,@RowsPerPage, @PageNumber, @Word,@Keyword, 
	@CategoryID,@SchoolID, @GroupID, @SchoolPalette, @FirstQueryCount, @TopCategoryHeaderID,@IsTalk, @VirtualCount = @VirtualCount output

	IF EXISTS (SELECT *FROM sys.tables WHERE name='#tempword')
		DROP TABLE #tempword


end


