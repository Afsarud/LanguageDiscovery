USE [Palaygo_04242021]
GO
/****** Object:  StoredProcedure [dbo].[usp_GetScheduleByUserId]    Script Date: 9/14/2021 8:38:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure [dbo].[usp_GetScheduleByUserId]
	@UserId int
AS
BEGIN
	declare @IsSupport bit = 0
	declare @CountryId int
	Select @IsSupport = IsSupport, @CountryId = CountryID From [User] where UserID = @UserId

	IF @IsSupport = 1
	BEGIN
		SELECT *, '' as UserName FROM Schedule 
		--WHERE (UserId = @UserId OR PartnerId = @UserId)
		--and Schedule > GETDATE()
		--and Schedule BETWEEN convert(varchar(10),getdate(), 101) + ' 00:00:01' AND convert(varchar(10),getdate(), 101) + ' 23:59:59'
		--AND getdate() between DATEADD(HOUR, -1, schedule) and DATEADD(HOUR, 2, schedule)

	END
	ELSE
	BEGIN
		SELECT *, '' as UserName FROM Schedule 
		WHERE (UserId = @UserId OR PartnerId = @UserId)
		--and Schedule > GETDATE()
		--and Schedule BETWEEN convert(varchar(10),getdate(), 101) + ' 00:00:01' AND convert(varchar(10),getdate(), 101) + ' 23:59:59'
		--AND getdate() between DATEADD(HOUR, -1, schedule) and DATEADD(HOUR, 2, schedule)

		union all 

		select 0 , getdate(), @UserId, UserId,getdate(), UserName as UserName
		from [user] where IsSupport = 1 --Username = 'Palaygo Test' or FirstName = 'Palaygo Test'
		--OR  Username = 'Tom@demo2019au' or Username = 'yujiro@tokyojp' or UserName = 'Cathy@koalaschool'
		--or Username = 'ferdieen@abc' or Username = 'ferdiejp@abc' 
		--OR  Username = '7@iu24jp' or Username = '5@ss528au'

	END

	--SELECT *, '' as UserName FROM Schedule 
	--WHERE (UserId = @UserId OR PartnerId = @UserId)
	----and Schedule > GETDATE()
	----and Schedule BETWEEN convert(varchar(10),getdate(), 101) + ' 00:00:01' AND convert(varchar(10),getdate(), 101) + ' 23:59:59'
	----AND getdate() between DATEADD(HOUR, -1, schedule) and DATEADD(HOUR, 2, schedule)

	--union all 

	--select 0 , getdate(), @UserId, UserId,getdate(), UserName as UserName
	--from [user] where IsSupport = 1 --Username = 'Palaygo Test' or FirstName = 'Palaygo Test'
	----OR  Username = 'Tom@demo2019au' or Username = 'yujiro@tokyojp' or UserName = 'Cathy@koalaschool'
	----or Username = 'ferdieen@abc' or Username = 'ferdiejp@abc' 
	----OR  Username = '7@iu24jp' or Username = '5@ss528au'
END

