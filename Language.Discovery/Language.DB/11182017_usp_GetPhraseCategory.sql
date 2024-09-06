ALTER PROCEDURE [dbo].[usp_GetPhraseCategory]
	@LanguageCode nvarchar(10) = null,
	@LevelID int = 0,
	@SchoolID int = null
AS
BEGIN
	SET NOCOUNT ON;
	
	--SELECT * 
	--FROM PhraseCategory
	--WHERE LanguageCode = @LanguageCode AND (@LevelID = 0 OR LevelID = @LevelID)
	
	--SELECT PH.*,PC.PhraseCategoryID, PC.LanguageCode, PC.PhraseCategoryCode, PC.GroupID
	--FROM PhraseCategoryHeader PH
	--INNER JOIN PhraseCategory PC ON PH.PhraseCategoryHeaderID = PC.GroupID
	--WHERE PC.LanguageCode = @LanguageCode AND (PH.LevelID = @LevelID OR PH.LevelID = 0)
	--ORDER BY PH.Ordinal ASC
	
	SELECT PH.*,PC.PhraseCategoryID, PC.LanguageCode, sub.PhraseCategoryCode, PC.GroupID, TC.IsTalk
	FROM PhraseCategoryHeader PH
	INNER JOIN PhraseCategory PC ON PH.PhraseCategoryHeaderID = PC.GroupID
	INNER JOIN TopCategoryHeader TC ON PH.TopCategoryHeaderID = TC.TopCategoryHeaderID
	INNER JOIN (
		SELECT PH.*,PC.PhraseCategoryID, PC.LanguageCode, PC.PhraseCategoryCode, PC.GroupID
		FROM PhraseCategoryHeader PH
		INNER JOIN PhraseCategory PC ON PH.PhraseCategoryHeaderID = PC.GroupID
		WHERE PC.LanguageCode = @LanguageCode --AND (PH.LevelID = @LevelID OR PH.LevelID = 0)
		AND (isnull(@SchoolID,0) = 0 OR PH.SchoolID = 0 OR PH.SchoolID = @SchoolID)
	) sub on PC.GroupID = sub.GroupID
	WHERE PC.LanguageCode = 'en-US' --AND (PH.LevelID = @LevelID OR PH.LevelID = 0)
	AND (isnull(@SchoolID,0) = 0 OR PH.SchoolID = 0 OR PH.SchoolID = @SchoolID)
	ORDER BY PH.Ordinal ASC
	
	
END


