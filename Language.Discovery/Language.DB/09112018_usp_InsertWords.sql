ALTER procedure [dbo].[usp_InsertWords]
	@ImageFile nvarchar(50) = null,
	@PhraseCategoryID bigint = null,
	@UserID bigint,
	@Keyword nvarchar(50),
	@WordType nvarchar(50),
	@xml xml,
	@ID bigint output
as
begin

	INSERT INTO WordHeader ( CreateDate, CreatedByID, ImageFile, PhraseCategoryID, KeyWord,WordType )
	values ( GETDATE(), @UserID, @ImageFile, @PhraseCategoryID, @Keyword, @WordType)
		
	SET @ID = SCOPE_IDENTITY()
	
	INSERT INTO Word ( LanguageCode, WordMapID, Word, SoundFile, CreateDate, CreatedBy, SchoolID )
	SELECT XTbl.value('(LanguageCode)[1]', 'nvarchar(10)'),
		@ID,
		XTbl.value('(Word)[1]', 'nvarchar(50)'),
		XTbl.value('(SoundFile)[1]', 'nvarchar(50)'),
		GETDATE(),
		@UserID,
		XTbl.value('(SchoolID)[1]', 'int')
	FROM  @xml.nodes('ArrayOfWordContract/WordContract') AS XD(XTbl)
	
end	


