SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure [dbo].[usp_GetRandomSuggestion]
as
begin

	
	declare @PaletteSuggestionID bigint
	declare @Paletteid bigint

	select @paletteid = PaletteSuggestion.PaletteID 
	from PaletteSuggestion
	inner join palette on palettesuggestion.PaletteID = palette.PaletteID
	where GETDATE() between StartDate and EndDate --and IsActive = 1
	order by newid()
	
		SELECT P.* 
		FROM Palette P
		where P.PaletteID = @Paletteid
		
		SELECT * FROM Sentence where PaletteID = @Paletteid
		
		SELECT * 
		FROM Phrase P
		INNER JOIN Sentence S ON P.SentenceID = S.SentenceID
		WHERE S.PaletteID  = @Paletteid AND Word <> ''
end


