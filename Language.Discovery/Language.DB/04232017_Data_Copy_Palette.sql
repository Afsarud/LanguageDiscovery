--select * from Palette

--select * from Sentence where SentenceLanguageCode = 'zh-CN'
--select * from Sentence where PaletteID = 2308

--USE [CN_03292017]
--GO

--/****** Object:  Table [dbo].[Sentence]    Script Date: 4/23/2017 7:05:19 PM ******/
--SET ANSI_NULLS ON
--GO

--SET QUOTED_IDENTIFIER ON
--GO


BEGIN TRAN

	BEGIN TRY

		declare @TempSentence as table
		(
			ID int IDENTITY(1,1) NOT NULL,
			[SentenceID] [bigint],
			[PaletteID] [bigint] NULL,
			[CreateDate] [datetime] NOT NULL,
			[CreatedBy] [bigint] NOT NULL,
			[SentenceSoundFile] [nvarchar](50) NULL,
			[SentenceImageFile] [nvarchar](50) NULL,
			[SentenceLanguageCode] [nvarchar](10) NULL,
			[Keyword] [nvarchar](50) NULL
		)

		DECLARE @Sentence as Table
		(
			ID int identity(1,1),
			SentenceID bigint,
			PaletteID bigint,
			CreateDate datetime,
			CreatedBy bigint,
			SentenceLanguageCode nvarchar(10),
			SentenceSoundFile nvarchar(50),
			Keyword nvarchar(50)
		)
	
		DECLARE @Phrase as Table
		(
			SentenceID bigint,
			WordMapID bigint,
			Word nvarchar(50),
			Keyword nvarchar(50),
			WordSoundFile nvarchar(250),
			WordImageFile nvarchar(250),
			Ordinal int
		)


		INSERT INTO @TempSentence
		select * from Sentence where SentenceLanguageCode = 'zh-CN'


		declare @count as int
		declare @ID as int = 1
		declare @currentpaletteid as bigint
		declare @newpaletteid as bigint


		declare @runningcount as int = 1
		select @count = count(1) from Sentence where SentenceLanguageCode = 'zh-CN'

		while @runningcount < @count
		begin

			-------Palette
			select @currentpaletteid = PaletteID from @TempSentence where ID = @ID

			INSERT INTO OR_03292017.dbo.Palette 
			SELECT [SchoolID],[PhraseCategoryID],[CreateDate],[CreatedBy],[ApprovedDate],[ApprovedBy],[Approved],[DefaultLanguageCode],[GroupID],[LanguageCode],[LevelID]
			from Palette where PaletteID = @currentpaletteid

			set @newpaletteid = SCOPE_IDENTITY()

			-------End Palette

			-------Sentence
			--Loop Sentence here

			Insert into @Sentence
			select SentenceID,@newpaletteid,[CreateDate],[CreatedBy],[SentenceSoundFile],[SentenceImageFile],[SentenceLanguageCode],[Keyword]
			from Sentence where PaletteID = @currentpaletteid 

			declare @currentsentenceid as bigint
			declare @newsentenceid as bigint
			declare @SID as int = 1
			declare @SCount as int 
			select @SCount = count(1) from @Sentence
	
			WHILE @SID < @SCount 
			BEGIN
				SELECT @currentsentenceid = Sentenceid FROM @Sentence WHERE ID = @SID

				INSERT INTO OR_03292017.dbo.Sentence
				select @newpaletteid,[CreateDate],[CreatedBy],[SentenceSoundFile],null,[SentenceLanguageCode],[Keyword]
				from @Sentence where SentenceID = @currentsentenceid

				set @newsentenceid = SCOPE_IDENTITY()

				--start phrase

				insert into Phrase
				select @newsentenceid,[WordMapID],[Word],[Keyword],[PluralForm],[WordSoundFile],[WordImageFile],[Ordinal],[ParentID]
				FROM Phrase
				where SentenceID = @currentsentenceid

				SET @SID = @SID + 1
				set @newsentenceid = NULL
				SET  @currentsentenceid = NULL

				--end phrase

			END

			-------End Sentence

			SET @ID = @ID + 1
			SET @newpaletteid = NULL
			SET @currentpaletteid = NULL

		end

		commit TRAN

	END TRY
	
BEGIN CATCH

	ROLLBACK TRAN

	DECLARE @ErrorMessage NVARCHAR(4000);
	SELECT @ErrorMessage=ERROR_MESSAGE()
	RAISERROR(@ErrorMessage, 10, 1);
END CATCH


