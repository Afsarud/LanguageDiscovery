USE [Palaygo_04242021]
GO
/****** Object:  StoredProcedure [dbo].[usp_UpdateTalkSubscription]    Script Date: 12/25/2021 11:51:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create PROCEDURE [dbo].[usp_UpdateTalkSessionTimeByUserName]
	@UserName nvarchar(100),
	@SessionTime int
AS
BEGIN
	
	declare @BalanceTime as int
	DECLARE @IsActive bit = 1
	DECLARE @UserID bigint
	DECLARE @TimeSpent bigint
	DECLARE @TempSessionTime bigint
	DECLARE @TempBalanceTime bigint
	
	SELECT @UserID = UserID FROM [User] where UserName = @UserName

		UPDATE UserTalkSubscription 
		SET SessionTime = @SessionTime
		WHERE UserID = @UserID AND IsActive = 1

	    --exec usp_InsertTalkHistory @UserName, @TimeSpent, @PartnerUserName

END





