Create procedure [dbo].[usp_GetPhraseCategoryDetailsByHeaderID]
	@PhraseCategoryHeaderID bigint
as
begin


	SELECT *
	from PhraseCategoryHeader
	where PhraseCategoryHeaderID = @PhraseCategoryHeaderID
	
	SELECT *
	from PhraseCategory
	where GroupID = @PhraseCategoryHeaderID
	

end	



