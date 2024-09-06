CREATE procedure [dbo].[usp_InsertUserOtherPoints]
	@UserID int,
	@Type nvarchar(10),
	@Points int
as
begin

		INSERT INTO UserOtherPoints
		VALUES ( @UserID, @Type, @Points, GETDATE() )

end

