	
	--SET IDENTITY_INSERT OR_03292017.DBO.WordHeader ON
	--GO


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
			
			
			INSERT INTO OR_03292017.dbo.WordHeader(WordHeaderID,[CreateDate],[CreatedByID],[ModifiedDate],[ModifiedByID],[ImageFile],[PhraseCategoryID],[Keyword])
			SELECT [WordHeaderID]+@IDAddends,[CreateDate],[CreatedByID],[ModifiedDate],[ModifiedByID],[ImageFile],[PhraseCategoryID],[Keyword]
			FROM [WordHeader] where WordHeaderID in (select WordHeaderID from @WordHeader)

		commit TRAN

	END TRY
	
BEGIN CATCH

	ROLLBACK TRAN

	DECLARE @ErrorMessage NVARCHAR(4000);
	SELECT @ErrorMessage=ERROR_MESSAGE()
	RAISERROR(@ErrorMessage, 10, 1);
END CATCH


	SET IDENTITY_INSERT OR_03292017.DBO.wordheader OFF
	GO
