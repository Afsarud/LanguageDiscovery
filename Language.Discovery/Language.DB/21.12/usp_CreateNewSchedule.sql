USE [Palaygo_04242021]
GO
/****** Object:  StoredProcedure [dbo].[usp_CreateNewSchedule]    Script Date: 12/16/2021 8:09:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure [dbo].[usp_CreateNewSchedule]
	@Date datetime,
	@UserName nvarchar(50),
	@PartnerUserName nvarchar(50),
	@ID int output
as
begin
	DECLARE @UserId int
	DECLARE @PartnerId int

	SELECT @UserId = UserId from [User] where UserName = @UserName
	SELECT @PartnerId = UserId from [User] where UserName = @PartnerUserName

	INSERT INTO Schedule(Schedule, UserId, PartnerId, CreateDate, UserConfirmationToken, PartnerConfirmationToken, IsUserConfirmed, IsPartnerConfirmed) 
		VALUES(@Date, @UserId, @PartnerId, GETDATE(), NEWID(), NEWID(), null , null)

	set @ID = Scope_Identity()
	
end