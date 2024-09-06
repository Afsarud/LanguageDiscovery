USE [Palaygo_04242021]
GO
/****** Object:  StoredProcedure [dbo].[usp_GetPhraseCategory]    Script Date: 4/17/2022 10:29:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
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
	
	SELECT PH.*,PC.PhraseCategoryID, PC.LanguageCode, PC.PhraseCategoryCode, PC.GroupID, TC.IsTalk, T.TopCategoryName, PH.HideInScheduler
	FROM PhraseCategoryHeader PH
	INNER JOIN PhraseCategory PC ON PH.PhraseCategoryHeaderID = PC.GroupID
	INNER JOIN TopCategoryHeader TC ON PH.TopCategoryHeaderID = TC.TopCategoryHeaderID
	INNER JOIN TopCategory T ON TC.TopCategoryHeaderID = T.TopCategoryHeaderID and T.LanguageCode = 'en-US'
	--INNER JOIN (
	--	SELECT PH.*,PC.PhraseCategoryID, PC.LanguageCode, PC.PhraseCategoryCode, PC.GroupID
	--	FROM PhraseCategoryHeader PH
	--	INNER JOIN PhraseCategory PC ON PH.PhraseCategoryHeaderID = PC.GroupID
	--	WHERE PC.LanguageCode = @LanguageCode --AND (PH.LevelID = @LevelID OR PH.LevelID = 0)
	--	AND (isnull(@SchoolID,0) = 0 OR PH.SchoolID = 0 OR PH.SchoolID = @SchoolID)
	--) sub on PC.GroupID = sub.GroupID
	WHERE PC.LanguageCode = @LanguageCode --AND (PH.LevelID = @LevelID OR PH.LevelID = 0)
	AND (isnull(@SchoolID,0) = 0 OR PH.SchoolID = 0 OR PH.SchoolID = @SchoolID)
	ORDER BY PH.Ordinal ASC
	
	
END


