ALTER procedure [dbo].[usp_UpdatePhraseCategory]
	@PhraseCategoryHeaderID bigint,
	@LevelID int,
	@SchoolID int,
	@UserID bigint,
	@FolderName nvarchar(50) = null,
	@IsDemo bit = 0,
	@DisplayInUI bit = 0,
	@TopCategoryHeaderID int,
	@HideInScheduler bit = 0,
	@xml xml
as
begin

	declare @temp as table
	(
		PhraseCategoryID bigint,
		GroupID bigint,
		LanguageCode nvarchar(10),
		PhraseCategoryCode nvarchar(50)
	)
	
	INSERT INTO @temp
	SELECT XTbl.value('(PhraseCategoryID)[1]', 'bigint'),
		XTbl.value('(GroupID)[1]', 'bigint'),
		XTbl.value('(LanguageCode)[1]', 'nvarchar(10)'),
		XTbl.value('(PhraseCategoryCode)[1]', 'nvarchar(50)')
		FROM  @xml.nodes('ArrayOfPhraseCategoryContract/PhraseCategoryContract') AS XD(XTbl)
		

	UPDATE PhrasecategoryHeader SET LevelID = @LevelID, SchoolID = @SchoolID,
		ModifiedDate = GETDATE(), ModifiedByID = @UserID, FolderName= isnull(@FolderName, FolderName), IsDemo = @isdemo,
		DisplayInUI = @DisplayInUI, TopCategoryHeaderID = @TopCategoryHeaderID, HideInScheduler = @HideInScheduler


	WHERE PhraseCategoryHeaderID = @PhraseCategoryHeaderID
		
	
	UPDATE PhraseCategory SET LanguageCode = T.LanguageCode,
		PhraseCategoryCode = T.PhraseCategoryCode
	FROM PhraseCategory PC
	INNER JOIN @temp T ON PC.PhraseCategoryID = T.PhraseCategoryID
	
	INSERT INTO PhraseCategory ( LanguageCode, GroupID, PhraseCategoryCode)
	Select LanguageCode, @PhraseCategoryHeaderID, PhraseCategoryCode FROM @temp
	WHERE PhraseCategoryID = 0
	
	
end	

