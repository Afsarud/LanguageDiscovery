	
	SET IDENTITY_INSERT OR_03292017.DBO.word ON
	GO


BEGIN TRAN

	BEGIN TRY

		declare @WordHeader as table
		(
			WordHeaderID bigint
		)

		declare @Word as table
		(
			WordID bigint,
			WordMapID bigint
		)

		
		INSERT INTO @WordHeader
		select WordMapID
		from Word
		where LanguageCode = 'zh-CN' 

		INSERT INTO @Word
		select WordID, WordMapID
		from Word
		where WordMapID in (select * from @WordHeader)


			declare @IDAddends bigint = 8000
			
			
			INSERT INTO OR_03292017.dbo.Word([WordID],[LanguageCode],[WordMapID],[Word],[Keyword],[PluralForm],[SoundFile],[ImageFile],[SchoolID]
				  ,[PhraseCategoryID],[CreateDate],[CreatedBy],[Ordinal],[ParentID])
			SELECT [WordID]+17000,[LanguageCode],[WordMapID]+@IDAddends,[Word],[Keyword],[PluralForm],[SoundFile],[ImageFile],[SchoolID]
				  ,[PhraseCategoryID],[CreateDate],[CreatedBy],[Ordinal],[ParentID]
			  FROM [dbo].[Word] where WordID in (select WordID from @Word)


		commit TRAN

	END TRY
	
BEGIN CATCH

	ROLLBACK TRAN

	DECLARE @ErrorMessage NVARCHAR(4000);
	SELECT @ErrorMessage=ERROR_MESSAGE()
	RAISERROR(@ErrorMessage, 10, 1);
END CATCH


	SET IDENTITY_INSERT OR_03292017.DBO.word OFF
	GO


	----select * from word where wordmapid = 83
	--select * from word where WordID = 10300

	--select * from OR_03292017.dbo.Word where WordID = 16300

	--select *
	--	from Word
	--	where LanguageCode = 'zh-CN' 