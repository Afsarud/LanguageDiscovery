create procedure usp_SaveComment
	@ScheduleId int,
	@Comment nvarchar(200),
	@UserColor nvarchar(20),
	@PartnerColor nvarchar(20)
as
begin

	UPDATE Schedule set Comment = @Comment, 
	UserColor = Case WHEN @UserColor = '' THEN NULL ELSE @UserColor END, 
	PartnerColor= Case WHEN @PartnerColor = '' THEN NULL ELSE @PartnerColor END  
	where ScheduleId =@ScheduleId

end