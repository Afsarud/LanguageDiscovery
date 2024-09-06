ALTER procedure [dbo].[usp_GetPaletteDetails]
	@PaletteID bigint
as
begin
	
	SELECT * from Palette WHERE PaletteID = @PaletteID
	
	SELECT S.*
	from Sentence S
	WHERE PaletteID = @PaletteID

	SELECT SS.*
	from Sentence S
	inner JOIN SentenceSound SS on S.SentenceID = SS.SentenceID
	WHERE PaletteID = @PaletteID


	select S.PaletteID, S.SentenceLanguageCode, S.Keyword,
		PH.PhraseID, PH.Ordinal, PH.ParentID, PH.SentenceID,
		PH.Word, PH.WordImageFile, PH.WordMapID, PH.WordSoundFile,
		PH.WordType
	from Phrase PH
	INNER JOIN Sentence S ON PH.SentenceID = S.SentenceID
	where S.PaletteID = @PaletteID

end	

