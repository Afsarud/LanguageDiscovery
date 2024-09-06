USE [Palaygo_04242021]
GO
/****** Object:  StoredProcedure [dbo].[usp_GetMySchedule]    Script Date: 12/7/2021 9:35:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure [dbo].[usp_GetMySchedule]
	@UserId int
AS
BEGIN
	SELECT ScheduleId,Schedule, [UserId],  [PartnerId], [CreateDate] , '' as UserName FROM Schedule 
	WHERE (UserId = @UserId OR PartnerId = @UserId)
	and Schedule > GETDATE()

	union all 

	select 0 , getdate(), @UserId, UserId,getdate(), UserName as UserName
	from [user] where Username = 'Palaygo Test' or FirstName = 'Palaygo Test'
	--OR  Username = 'Tom@demo2019au' or Username = 'yujiro@tokyojp' or UserName = 'Cathy@koalaschool'
	--or Username = 'nene@palaygouk' OR  Username = 'ferdieen@abc' or Username = 'ferdiejp@abc' 
	--OR  Username = '7@iu24jp' or Username = '5@ss528au'
END
