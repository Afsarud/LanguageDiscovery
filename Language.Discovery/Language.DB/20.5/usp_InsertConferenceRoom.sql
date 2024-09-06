USE [Palaygo.11222018]
GO
/****** Object:  StoredProcedure [dbo].[usp_InsertConferenceRoom]    Script Date: 5/18/2020 6:52:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure [dbo].[usp_InsertConferenceRoom]
	@Room nvarchar(250),
	@Caller nvarchar(100),
	@Callee nvarchar(100)
as
begin

	declare @CalleSchoolCodeId nvarchar(50)
	declare @CallerSchoolCodeId nvarchar(50)
	declare @CalleSchoolId INT
	declare @CallerSchoolId int

	IF CHARINDEX('@', @Caller) > 0
	BEGIN
		SELECT @CallerSchoolCodeId = SUBSTRING(@Caller, CHARINDEX('@', @Caller) , len(@Caller))
	END
	ELSE
	BEGIN
		SELECT @CallerSchoolCodeId = SUBSTRING(@Caller, CHARINDEX('.', @Caller) , len(@Caller))
	END

	IF CHARINDEX('@', @Callee) > 0
	BEGIN
		SELECT @CalleSchoolCodeId = SUBSTRING(@Callee, CHARINDEX('@', @Callee) , len(@Callee))
	END
	ELSE
	BEGIN
		SELECT @CalleSchoolCodeId = SUBSTRING(@Callee, CHARINDEX('.', @Callee) , len(@Callee))
	END

	select @CalleSchoolId = SchoolID from SchoolInfo where '@' + SchoolCode = @CalleSchoolCodeId
	select @CallerSchoolId = SchoolID from SchoolInfo where '@' + SchoolCode = @CallerSchoolCodeId
	

	INSERT INTO ConferenceRoom 
	values(@Room, @Caller, @Callee, @CallerSchoolId, @CalleSchoolId, getdate())

end
