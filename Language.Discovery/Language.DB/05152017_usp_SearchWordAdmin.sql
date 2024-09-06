ALTER PROCEDURE [dbo].[usp_SearchWordAdmin]
	
	@SchoolID bigint = 0,
	@RowsPerPage INT = 10,
	@PageNumber as INT = 1,
	@Word as nvarchar(50) = null,
	@Keyword as NVARCHAR(50) = null,
	@LanguageCode nvarchar(10) = null,
	@CategoryID as bigint = 0,
	@IsExport bit = 0,
	@VirtualCount int output
as
begin	
	declare @tempword as table
	(
		RowNum bigint identity(1,1),
		WordHeaderID bigint
	)
	
	declare @words as table
	(
		WordHeaderID bigint
	)
	
	INSERT INTO @tempword
	SELECT Distinct WH.WordHeaderID
	FROM WordHeader WH
	inner join Word W on WH.WordHeaderID= W.WordMapID
	WHERE (isnull(@Word,'') = '' Or W.Word like  '%' + @Word + '%') AND (isnull(@Keyword,'') = '' OR WH.Keyword like  '%' + @Keyword + '%') 
	AND (@CategoryID = 0 OR WH.PhraseCategoryID = @CategoryID) --AND W.LanguageCode = @LanguageCode 
	AND (@SchoolID = 0 OR W.SchoolID = @SchoolID)

	INSERT INTO @words
	select WordHeaderID from @tempword w
	WHERE w.RowNum BETWEEN ((@PageNumber-1)*@RowsPerPage)+1
	AND @RowsPerPage*(@PageNumber) 

	select @VirtualCount = COUNT(1) from @tempword

	SELECT *
	FROM WordHeader 
	WHERE WordHeaderID IN ( select * FROM @words  )
	
	SELECT * 
	FROM WordHeader WH
	INNER JOIN Word W ON WH.WordHeaderID = W.WordMapID
	where WH.WordHeaderID IN ( select * FROM @words  )
	OR (@IsExport = 0 AND W.LanguageCode = @LanguageCode)


	--IF @IsExport = 1
	--	BEGIN
	
	--	END
	--ELSE
	--	BEGIN
	--		SELECT * 
	--		FROM WordHeader WH
	--		INNER JOIN Word W ON WH.WordHeaderID = W.WordMapID
	--		where WH.WordHeaderID IN ( select * FROM @words  )
	--		AND W.LanguageCode = @LanguageCode
	--	END

end
