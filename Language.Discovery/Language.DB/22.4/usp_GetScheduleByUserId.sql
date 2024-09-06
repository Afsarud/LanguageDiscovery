ALTER procedure [dbo].[usp_GetScheduleByUserId]
	@UserId int
AS
BEGIN
	declare @IsSupport bit = 0
	declare @CountryId int
	Select @IsSupport = IsSupport, @CountryId = CountryID From [User] where UserID = @UserId

	IF @IsSupport = 1
	BEGIN
	
		SELECT [ScheduleId]
			  ,[Schedule]
			  ,[UserId]
			  ,[PartnerId]
			  ,[CreateDate]
			  ,[UserConfirmationToken]
			  ,[IsUserConfirmed]
			  ,[PartnerConfirmationToken]
			  ,[IsPartnerConfirmed]
			  ,[UserConfirmationDateTime]
			  ,[PartnerConfirmationDateTime]
			  ,[Comment]
			  , '' as UserName
		  FROM [dbo].[Schedule]

		union all 

		select 0 , getdate(), @UserId, UserId,getdate(),
		null as UserConfirmationToken, cast(1 as bit)  as IsUserConfirmed,
		null as PartnerConfirmationToken, cast(1 as bit)  as IsPartnerConfirmed, null as UserConfirmationDateTime,
		null PartnerConfirmationDateTime,  '' as Comment,UserName as UserName
		from [user] where IsSupport = 1 and UserID <> @UserId
		or Username = 'ferdieen@abc' or Username = 'mai@tokyojp' 
		--WHERE (UserId = @UserId OR PartnerId = @UserId)
		--and Schedule > GETDATE()
		--and Schedule BETWEEN convert(varchar(10),getdate(), 101) + ' 00:00:01' AND convert(varchar(10),getdate(), 101) + ' 23:59:59'
		--AND getdate() between DATEADD(HOUR, -1, schedule) and DATEADD(HOUR, 2, schedule)

	END
	ELSE
	BEGIN
		SELECT [ScheduleId]
			  ,[Schedule]
			  ,[UserId]
			  ,[PartnerId]
			  ,[CreateDate]
			  ,[UserConfirmationToken]
			  ,[IsUserConfirmed]
			  ,[PartnerConfirmationToken]
			  ,[IsPartnerConfirmed]
			  ,[UserConfirmationDateTime]
			  ,[PartnerConfirmationDateTime]
			  ,[Comment]
			  , '' as UserName
			  ,PhraseCategoryID
			  ,PartnerPhraseCategoryID
		  FROM [dbo].[Schedule]
		WHERE (UserId = @UserId OR PartnerId = @UserId)
		--and Schedule > GETDATE()
		--and Schedule BETWEEN convert(varchar(10),getdate(), 101) + ' 00:00:01' AND convert(varchar(10),getdate(), 101) + ' 23:59:59'
		--AND getdate() between DATEADD(HOUR, -1, schedule) and DATEADD(HOUR, 2, schedule)

		union all 

		select 0 , getdate(), @UserId, UserId,getdate(),
		null, CAST( 0 as bit),
		null, CAST( 0 as bit), null ,
		null , '',  UserName as UserName
		,0 as PhraseCategoryID
		,0 as PartnerPhraseCategoryID
		from [user] where IsSupport = 1 --AND CountryId = @CountryId --Username = 'Palaygo Test' or FirstName = 'Palaygo Test'
		--OR  Username = 'Tom@demo2019au' or Username = 'yujiro@tokyojp' or UserName = 'Cathy@koalaschool'
		or Username = 'ferdieen@abc' or Username = 'mai@tokyojp'  
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

