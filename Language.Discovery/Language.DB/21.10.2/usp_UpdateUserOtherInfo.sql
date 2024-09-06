ALTER procedure [dbo].[usp_UpdateUserOtherInfo]
	@UserID bigint,
	@Password nvarchar(50) = null,
	@ClassID int = 0,
	@Gender nvarchar(20) = null,
	@CityID int = 0,
	@DateOfBirth datetime = null,
	@GradeID int = 0
as
begin

	UPDATE [User] SET [Password] = CASE WHEN ISNULL(@Password,'') = '' THEN [Password] ELSE @Password END,
					  ClassID =  CASE WHEN @ClassID = 0 THEN ClassID ELSE @ClassID END,
					  Gender =  CASE WHEN ISNULL(@Gender,'') = '' THEN Gender ELSE @Gender END,
					  CityID =  CASE WHEN @CityID = 0 THEN CityID ELSE @CityID END,
					  DateOfBirth =  CASE WHEN @DateOfBirth is null THEN DateOfBirth ELSE @DateOfBirth END,
					  GradeID =  CASE WHEN @GradeID = 0 THEN GradeID ELSE @GradeID END,
					  PasswordExpiration = CASE WHEN ISNULL(@Password,'') = '' THEN PasswordExpiration ELSE DATEADD(M,6, GETDATE()) END
	WHERE UserID = @UserID

	

end


