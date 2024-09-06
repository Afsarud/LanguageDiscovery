ALTER procedure [dbo].[usp_InsertConferenceRoom]
	@Room nvarchar(250),
	@Caller nvarchar(100),
	@Callee nvarchar(100),
	@RoomKey nvarchar(20) = null
as
begin

	declare @CalleSchoolCodeId nvarchar(50)
	declare @CallerSchoolCodeId nvarchar(50)
	declare @CalleSchoolId INT
	declare @CallerSchoolId int

	IF CHARINDEX('@', @Caller) > 0
	BEGIN
		SELECT @CallerSchoolCodeId = SUBSTRING(@Caller, CHARINDEX('@', @Caller)+1 , len(@Caller))
	END
	ELSE
	BEGIN
		SELECT @CallerSchoolCodeId = SUBSTRING(@Caller, CHARINDEX('.', @Caller)+1 , len(@Caller))
	END

	IF CHARINDEX('@', @Callee) > 0
	BEGIN
		SELECT @CalleSchoolCodeId = SUBSTRING(@Callee, CHARINDEX('@', @Callee)+1 , len(@Callee))
	END
	ELSE
	BEGIN
		SELECT @CalleSchoolCodeId = SUBSTRING(@Callee, CHARINDEX('.', @Callee)+1 , len(@Callee))
	END

	select @CalleSchoolId = SchoolID from SchoolInfo where SchoolCode = @CalleSchoolCodeId
	select @CallerSchoolId = SchoolID from SchoolInfo where SchoolCode = @CallerSchoolCodeId
	

	INSERT INTO ConferenceRoom 
	values(@Room, @Caller, @Callee, @CallerSchoolId, @CalleSchoolId, getdate(), @RoomKey)

end
