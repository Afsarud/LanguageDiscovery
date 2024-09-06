CREATE PROCEDURE usp_InsertNewUserRegistration
	@FirstName nvarchar(50),
	@LastName nvarchar(50),
	@Email nvarchar(50),
	@SchoolName nvarchar(50),
	@Gender nvarchar(10),
	@Telephone nvarchar(20),
	@ObjectID varchar(50),
	@ID int output
AS
BEGIN


	INSERT INTO NewUserRegistration ([FirstName],[LastName],[Email],[SchoolName],[Gender], Telephone, CreateDate, [ObjectID], ExpiryDate)
	VALUES (@FirstName, @LastName, @Email, @SchoolName, @Gender, @Telephone, getdate(), @ObjectID ,DateADD(DAY, 5, getdate()))

	SET @ID = SCOPE_IDENTITY()

END



