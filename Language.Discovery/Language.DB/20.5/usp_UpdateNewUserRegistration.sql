CREATE PROCEDURE usp_UpdateNewUserRegistration
	@ObjectID varchar(50)
AS
BEGIN

	UPDATE NewUserRegistration SET IsRegistered = 1, RegistrationDate = getdate()
	WHERE ObjectID = @ObjectID

END