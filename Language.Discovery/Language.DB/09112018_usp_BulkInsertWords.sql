ALTER procedure [dbo].[usp_BulkInsertWords]
	@header xml,
	@detail xml,
	@DeleteFirstThenAdd bit = 0,
	@PhraseCategoryID bigint = 0
as
begin

	DECLARE @WordHeader as table
	(
		ID bigint identity(1,1),
		WordHeaderID bigint,
		CreateDate datetime,
		CreatedByID bigint,
		ImageFile nvarchar(50),
		PhraseCategoryID bigint,
		Keyword nvarchar(50),
		WordType nvarchar(50)
	)
	
	declare @Word as table
	(
		WordID bigint,
		LanguageCode nvarchar(10),
		WordMapID bigint,
		Word nvarchar(50),
		SoundFile nvarchar(50),
		CreateDate datetime,
		CreatedBy bigint,
		SchoolID int
	)

	INSERT INTO @WordHeader	
	SELECT XTbl.value('(WordHeaderID)[1]', 'bigint'),
		GETDATE(),
		XTbl.value('(CreatedByID)[1]', 'bigint'),
		XTbl.value('(ImageFile)[1]', 'nvarchar(50)'),
		XTbl.value('(PhraseCategoryID)[1]', 'bigint'),
		XTbl.value('(Keyword)[1]', 'nvarchar(50)'),
		XTbl.value('(WordType)[1]', 'nvarchar(50)')
	FROM  @header.nodes('ArrayOfWordHeaderContract/WordHeaderContract') AS XD(XTbl)
	
	INSERT INTO @Word 
	SELECT XTbl.value('(WordID)[1]', 'bigint'),
		XTbl.value('(LanguageCode)[1]', 'nvarchar(10)'),
		XTbl.value('(WordMapID)[1]', 'bigint'),
		XTbl.value('(Word)[1]', 'nvarchar(50)'),
		XTbl.value('(SoundFile)[1]', 'nvarchar(50)'),
		GETDATE(),
		XTbl.value('(CreatedBy)[1]', 'bigint'),
		XTbl.value('(SchoolID)[1]', 'int')
	FROM  @detail.nodes('ArrayOfWordContract/WordContract') AS XD(XTbl)
	
	DECLARE @ID int
	DECLARE @RecordCount bigint

	SELECT @RecordCount = COUNT(1) FROM @WordHeader
	SET @ID = 1

	IF @DeleteFirstThenAdd = 1 AND @RecordCount > 0
	BEGIN

		DELETE Word where WordMapID in (select WordHeaderid from WordHeader where isnull(PhraseCategoryID,0) = 0 )
		DELETE WordHeader where isnull(PhraseCategoryID,0) = @PhraseCategoryID
	END


	WHILE ( @ID <= @RecordCount )
	BEGIN
		
		DECLARE @WordHeaderID bigint
		DECLARE @TempWordHeaderID bigint
		DECLARE @ImageFile nvarchar(50)

		SELECT @TempWordHeaderID = WordHeaderID, @ImageFile = ImageFile FROM @WordHeader WHERE ID = @ID
		
		INSERT INTO WordHeader ( CreateDate, CreatedByID, ImageFile, PhraseCategoryID, KeyWord, WordType )
		SELECT CreateDate, CreatedByID, ImageFile, PhraseCategoryID, KeyWord, WordType
		FROM @WordHeader 
		where ID = @ID
		
		SET @WordHeaderID = SCOPE_IDENTITY()
		
		INSERT INTO Word ( LanguageCode, WordMapID, Word, SoundFile, ImageFile ,CreateDate, CreatedBy, SchoolID )
		SELECT LanguageCode, @WordHeaderID, Word, SoundFile, @ImageFile ,CreateDate, CreatedBy,SchoolID
		FROM @Word 
		WHERE WordMapID = @TempWordHeaderID
		
		set @WordHeaderID = null
		set @TempWordHeaderID = null
		set @ImageFile = null
		
		set @ID = @ID + 1
	
	END
 
	
end	

