ALTER procedure [dbo].[usp_GetTopCategoryList]
	@LanguageCode nvarchar(10)
as
Begin

	SELECT TC.*, TH.IsMain,TH.IsDefault, th.IsTalk
	FROM TopCategory TC 
	INNER JOIN TopCategoryHeader TH on TC.TopCategoryHeaderID = TH.TopCategoryHeaderID
	WHERE LanguageCode = @LanguageCode 

end	

