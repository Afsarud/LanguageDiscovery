CREATE PROCEDURE usp_GetTeacherRegistration
	@ObjectID varchar(50)
AS
BEGIN
	SELECT * FROM NewUserRegistration WHERE ObjectID = @ObjectID
END