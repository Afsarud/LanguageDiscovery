ALTER procedure [dbo].[usp_UpdateWords]
	@WordHeaderID bigint,
	@ImageFile nvarchar(50) = null,
	@PhraseCategoryID bigint = null,
	@UserID bigint,
	@Keyword nvarchar(50),
	@WordType nvarchar(50),
	@xml xml
as
begin


	declare @temp as table
	(
		WordID bigint,
		LanguageCode nvarchar(10),
		WordMapID bigint,
		Word nvarchar(50),
		SoundFile nvarchar(50),
		SchoolID int
	)
	
	INSERT INTO @temp
	SELECT XTbl.value('(WordID)[1]', 'nvarchar(10)'),
		XTbl.value('(LanguageCode)[1]', 'nvarchar(10)'),
		XTbl.value('(WordMapID)[1]', 'bigint'),
		XTbl.value('(Word)[1]', 'nvarchar(50)'),
		XTbl.value('(SoundFile)[1]', 'nvarchar(50)'),
		XTbl.value('(SchoolID)[1]', 'int')
		FROM  @xml.nodes('ArrayOfWordContract/WordContract') AS XD(XTbl)
		
	
	UPDATE WordHeader set ImageFile = case when isnull(@ImageFile, '' ) = '' then ImageFile else @ImageFile end, PhraseCategoryID = @PhraseCategoryID,
		ModifiedDate = GETDATE(), ModifiedByID =@UserID, Keyword = case when isnull(@Keyword,'') = '' then Keyword else @Keyword end,
		WordType = case when isnull(@WordType,'') = '' then WordType else @WordType end
	WHERE WordheaderID = @WordHeaderID
	
	
	UPDATE Word SET LanguageCode = T.LanguageCode,
		Word = T.Word, SoundFile =case when isnull(T.SoundFile, '') = '' then W.SoundFile else T.SoundFile end ,
		SchoolID = coalesce(T.SchoolID, W.SchoolID)
	FROM Word W
	INNER JOIN @temp T ON W.WordID = T.WordID
	
	INSERT INTO Word ( LanguageCode, WordMapID, Word, SoundFile, CreateDate, CreatedBy, SchoolID )
	SELECT				LanguageCode, @WordHeaderID, Word, SoundFile, GETDATE(), @UserID, SchoolID 
	FROM @Temp
	WHERE WordID = 0
	
end	
