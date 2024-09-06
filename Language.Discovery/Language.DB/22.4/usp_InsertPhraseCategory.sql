ALTER procedure [dbo].[usp_InsertPhraseCategory]
	@LevelID int,
	@SchoolID int,
	@UserID bigint,
	@FolderName nvarchar(50) = null,
	@IsDemo bit = 0,
	@DisplayInUI bit = 0,
	@TopCategoryHeaderID int,
	@HideInScheduler bit = 0,
	@xml xml,
	@ID bigint output
as
begin

	INSERT INTO PhrasecategoryHeader ( CreateDate, CreatedByID, LevelID, SchoolID, FolderName, IsDemo, DisplayInUI, TopCategoryHeaderID, HideInScheduler)
	values ( GETDATE(), @UserID, @LevelID, @SchoolID, @FolderName, @IsDemo, @DisplayInUI, @TopCategoryHeaderID, @HideInScheduler)
		
	SET @ID = SCOPE_IDENTITY()
	
	INSERT INTO PhraseCategory ( LanguageCode, GroupID, PhraseCategoryCode)
	SELECT XTbl.value('(LanguageCode)[1]', 'nvarchar(10)'),
		@ID,
		XTbl.value('(PhraseCategoryCode)[1]', 'nvarchar(50)')
	FROM  @xml.nodes('ArrayOfPhraseCategoryContract/PhraseCategoryContract') AS XD(XTbl)
	
end	


