ALTER procedure [dbo].[usp_DeletePhraseCategory]
	@PhraseCategoryHeaderID bigint
as
begin


	IF  NOT EXISTS( select 1 from Palette
						inner join PhraseCategory on Palette.PhraseCategoryID = PhraseCategory.PhraseCategoryID
						inner join Sentence on Palette.PaletteID = Sentence.PaletteID
					 where PhraseCategory.GroupID = @PhraseCategoryHeaderID )
		AND NOT EXISTS( select 1 from WordHeader
						inner join PhraseCategory on WordHeader.PhraseCategoryID = PhraseCategory.PhraseCategoryID
					 where PhraseCategory.GroupID = @PhraseCategoryHeaderID )
	begin
		DELETE PhraseCategory where GroupID = @PhraseCategoryHeaderID
		DELETE PhraseCategoryHeader where PhraseCategoryHeaderID= @PhraseCategoryHeaderID
	end

end	

