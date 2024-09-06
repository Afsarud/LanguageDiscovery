USE [Palaygo_04242021]
GO
/****** Object:  StoredProcedure [dbo].[usp_UpdateSchedule]    Script Date: 12/25/2021 8:05:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure [dbo].[usp_UpdateSchedule]
	@ScheduleId int,
	@Date datetime,
	@UserName nvarchar(50),
	@PartnerUserName nvarchar(50)
as
begin
	DECLARE @UserId int
	DECLARE @PartnerId int

	SELECT @UserId = UserId from [User] where UserName = @UserName
	SELECT @PartnerId = UserId from [User] where UserName = @PartnerUserName

	UPDATE Schedule SET Schedule = @Date, UserId = @UserId, PartnerId =@PartnerId, 
		UserConfirmationToken = NEWID(),
		PartnerConfirmationToken = NEWID(),
		IsUserConfirmed = null, 
		IsPartnerConfirmed = null,
		UserConfirmationDateTime = null,
		PartnerConfirmationDateTime = null
		WHERE ScheduleId = @ScheduleId

	
end