BEGIN TRAN

	BEGIN TRY

		declare @id as bigint
		INSERT INTO PhraseCategoryHeader values (GETDATE(), 9,0,0, null, null, 2, '',1,1,2)
		set @id = SCOPE_IDENTITY()
		
		
		insert into PhraseCategory (GroupID, LanguageCode, PhraseCategoryCode) values ( @id,'en-US','Questions' ),
										  ( @id,'ja-JP',N'しつもん' ),
										  ( @id,'ja-KA',N'' ),
										  ( @id,'ja-RO',N'' ),
										  ( @id,'zh-CN',N'問題' ),
										  ( @id,'zh-X',N'' ),
										  ( @id,'zh-PN',N'' )
		
		INSERT INTO PhraseCategoryHeader values (GETDATE(), 9,0,0, null, null, 2, '',1,1,2)
		set @id = SCOPE_IDENTITY()
		
		insert into PhraseCategory  (GroupID, LanguageCode, PhraseCategoryCode)  values ( @id,'en-US','Answers/Normal' ),
										  ( @id,'ja-JP',N'こたえ・ふつうぶん' ),
										  ( @id,'ja-KA',N'' ),
										  ( @id,'ja-RO',N'' ),
										  ( @id,'zh-CN',N'答' ),
										  ( @id,'zh-X',N'' ),
										  ( @id,'zh-PN',N'' )
										  
		INSERT INTO PhraseCategoryHeader values (GETDATE(), 9,0,0, null, null, 2, '',1,1,2)
		set @id = SCOPE_IDENTITY()
		
		insert into PhraseCategory(GroupID, LanguageCode, PhraseCategoryCode)  values ( @id,'en-US','Conjunctions' ),
										  ( @id,'ja-JP',N'せつぞくし' ),
										  ( @id,'ja-KA',N'接続詞' ),
										  ( @id,'ja-RO',N'setsuzokushi' ),
										  ( @id,'zh-CN',N'连词' ),
										  ( @id,'zh-X',N'' ),
										  ( @id,'zh-PN',N'' )	

		select * from PhraseCategory
		commit TRAN

	END TRY
	
BEGIN CATCH

	ROLLBACK TRAN

	DECLARE @ErrorMessage NVARCHAR(4000);
	SELECT @ErrorMessage=ERROR_MESSAGE()
	RAISERROR(@ErrorMessage, 10, 1);
END CATCH
										  	