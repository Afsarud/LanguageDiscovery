USE [Palaygo.11222018]
GO
/****** Object:  StoredProcedure [dbo].[usp_GetSchoolList]    Script Date: 2/6/2020 10:01:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure [dbo].[usp_GetSchoolList]
	@LanguageCode nvarchar(10) = null,
	@IsSchool bit = 0
as
begin

	IF @IsSchool = 1
	BEGIN
		SELECT * FROM SchoolInfo
		order by CreateDate desc
	END
	ELSE
	BEGIN
		SELECT * FROM SchoolInfo
		WHERE SchoolKey = 1
		order by CreateDate desc
	END
end


