create procedure  usp_ChangePassword
	@UserID bigint,
	@Password nvarchar(100)
as
begin
	UPDATE [User] set Password = @Password, PasswordExpiration = DATEADD(m,6,GETDATE()) WHERE UserID = @UserID
end
