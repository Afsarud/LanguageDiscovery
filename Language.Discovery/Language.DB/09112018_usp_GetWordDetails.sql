ALTER procedure [dbo].[usp_GetWordDetails]
	@WordHeaderID bigint
as
begin

	SELECT *
	from WordHeader
	where WordHeaderID = @WordHeaderID
	
	SELECT *
	from Word
	where WordMapID = @WordHeaderID
	

end	


