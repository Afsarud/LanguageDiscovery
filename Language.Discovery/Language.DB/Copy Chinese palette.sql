BEGIN TRAN

	BEGIN TRY

		declare @palette as table
		(
			Paletteid bigint
		)

		declare @Sentence as table
		(
			SentenceID bigint,
			Paletteid bigint
		)
		declare @Phrase as table
		(
			PhraseID bigint,
			SentenceID bigint
		)

		INSERT INTO @palette
		select p.PaletteID 
		from Palette P
		inner join Sentence s on p.PaletteID = s.PaletteID
		where SentenceLanguageCode = 'zh-CN' and P.PaletteID <> 31


		INSERT INTO @Sentence
		SELECT SentenceID, PaletteID from Sentence 
		where PaletteID in (select PaletteID from @palette)

		INSERT @Phrase
		select Phraseid, SentenceID 
		from Phrase
		where SentenceID in ( select SentenceID from @Sentence )

				select s.*
		from Palette P
		inner join Sentence s on p.PaletteID = s.PaletteID
		where SentenceLanguageCode = 'zh-CN'


		--select * from @palette
		--select * from @Sentence
		--select * from @Phrase

			declare @IDAddends bigint = 5000

			UPDATE Palette SET PaletteID = PaletteID + @IDAddends
			where PaletteID in (select Paletteid from @palette)

			UPDATE Sentence SET PaletteID = PaletteID + @IDAddends, SentenceID = SentenceID + @IDAddends
			where SentenceID in (select SentenceID from @Sentence)

			UPDATE Phrase SET PhraseID = PhraseID + @IDAddends, SentenceID = SentenceID + @IDAddends
			where SentenceID in (select SentenceID from @Sentence)

			select s.*
		from Palette P
		inner join Sentence s on p.PaletteID = s.PaletteID
		where SentenceLanguageCode = 'zh-CN'

		commit TRAN

	END TRY
	
BEGIN CATCH

	ROLLBACK TRAN

	DECLARE @ErrorMessage NVARCHAR(4000);
	SELECT @ErrorMessage=ERROR_MESSAGE()
	RAISERROR(@ErrorMessage, 10, 1);
END CATCH

