SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_UpdateUserDontShowQuickGuide]
	@UserID bigint,
	@DontShowQuickGuide bit = 0
as
begin

	UPDATE [User] SET DontShowQuickGuide = @DontShowQuickGuide WHERE UserID = @UserID

end
