USE [msdb]
GO

/****** Object:  Job [Update User Rank - Prod]    Script Date: 6/14/2021 11:00:13 PM ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [[Uncategorized (Local)]]    Script Date: 6/14/2021 11:00:14 PM ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[Uncategorized (Local)]' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[Uncategorized (Local)]'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'Update User Rank - Prod', 
		@enabled=1, 
		@notify_level_eventlog=2, 
		@notify_level_email=0, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'update user rank', 
		@category_name=N'[Uncategorized (Local)]', 
		@owner_login_name=N'sa', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [update]    Script Date: 6/14/2021 11:00:14 PM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'update', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'	declare @UserID bigint = 0

	declare @Multiplier as int = 1
	DECLARE @UserCountryId as int
	DECLARE @UserCountryLanguage as nvarchar(10)
	DECLARE @UserLearningCountryId as int
	DECLARE @UserCountryLearningLanguage as nvarchar(10)
	DECLARE @AUMessageCount as int
	DECLARE @JPMessageCount as int

	declare @UserRank as TABLE 
	(
		UserID1 bigint,
		StarCount1 int,
		MessageCount1 int
	)

	DECLARE @LevelID INT
	SELECT @LevelID=isnull(LevelID,0), @UserCountryLanguage = NativeLanguage, @UserCountryLearningLanguage = LearningLanguage 
	FROM [User] WHERE UserID = @UserID 

	SELECT @UserCountryId = CountryId FROM [Language] WHERE LanguageCode = @UserCountryLanguage
	SELECT @UserLearningCountryId = CountryId FROM [Language] WHERE LanguageCode = @UserCountryLearningLanguage


	--AU
	SELECT @AUMessageCount = Count(u.UserID ) 
	FROM  UserMessage UM with(nolock)
	INNER JOIN [user] u on UM.SenderID = u.UserID
	WHERE  ((@LevelID <> 0 and u.levelid = @levelID)  OR U.LevelID not in (3,4))
	and u.CountryID = 1 AND UM.CreateDate>=DATEADD(DAY,-500,GETDATE())
	--GROUP BY U.USerID
	
	--JP
	SELECT @JPMessageCount = Count(u.UserID )
	FROM  UserMessage UM with(nolock)
	INNER JOIN [user] u on UM.SenderID = u.UserID
	WHERE  ((@LevelID <> 0 and u.levelid = @levelID)  OR U.LevelID not in (3,4))
	and u.CountryID = 2 AND UM.CreateDate>=DATEADD(DAY,-500,GETDATE())
	
	IF @AUMessageCount * 100.0/@JPMessageCount < 50
		SET @Multiplier = 10


	INSERT INTO @UserRank
	SELECT UserId, StarCount, MessageCount
	FROM
	(
		select xx.UserID,StarCount, (y.c1 + z.c2) * case when CountryID = 1 THEN @Multiplier ELSE 1 END   MessageCount, CountryID
		from (
		SELECT U.UserID,U.UserName, C.Flag, S.Name1 as SchoolName, 
			COUNT(islike)*10 AS StarCount, 
			U.Avatar, S.SchoolCode,  U.FirstName, u.CountryID
		FROM  UserMessage UM with(nolock)
		INNER JOIN [user] u on UM.SenderID = u.UserID
		INNER JOIN [Country] C on u.CountryID = C.CountryID
		INNER JOIN [SchoolInfo] S on U.SchoolID = S.SchoolID
		WHERE UM.SenderID > 0 and IsLike = 1 AND (isnull(@UserID,0) = 0 or U.UserID = @UserID) AND ((@LevelID <> 0 and u.levelid = @levelID)  OR U.LevelID not in (3,4))
		AND U.IsActive = 1
		GROUP BY U.USerID,U.UserName,C.Flag, S.Name1 , U.Avatar, S.SchoolCode, U.FirstName, U.CountryID
		) xx
		INNER JOIN 
		(
			SELECT U.UserID,Count(u.UserID ) c1
			FROM  UserMessage UM with(nolock)
			INNER JOIN [user] u on UM.SenderID = u.UserID
			WHERE  (isnull(@UserID,0) = 0 or U.UserID = @UserID) AND ((@LevelID <> 0 and u.levelid = @levelID)  OR U.LevelID not in (3,4))
			GROUP BY U.USerID
		) y on xx.UserID= y.UserID 
		INNER JOIN 
		(
			SELECT U.UserID,Count(u.UserID ) c2
			FROM  UserMessage UM with(nolock)
			INNER JOIN [user] u on UM.RecepientID = u.UserID
			WHERE  (isnull(@UserID,0) = 0 or U.UserID = @UserID) AND ((@LevelID <> 0 and u.levelid = @levelID)  OR U.LevelID not in (3,4))
			GROUP BY U.USerID
		) z on xx.UserID= z.UserID 
	) x
	ORDER BY StarCount DESC

	--SELECT * FROM  @UserRank
	--select * from userrank

	INSERT INTO UserRank (UserID, StarCount, MessageCount)
	SELECT UserID1, StarCount1, MessageCount1
	FROM  @UserRank
	where UserID1 NOT IN (SELECT UserID FROM UserRank)


	UPDATE UserRank set StarCount = CASE WHEN StarCount > TUR.StarCount1 THEN StarCount ELSE TUR.StarCount1 END, 
	MessageCount = CASE WHEN MessageCount > TUR.MessageCount1 THEN MessageCount ELSE TUR.MessageCount1 END
	FROM UserRank AS UR
	INNER JOIN @UserRank TUR ON UR.UserID = TUR.UserID1
', 
		@database_name=N'Palaygo_Prod', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'update user rank sched', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=1, 
		@freq_subday_interval=0, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=0, 
		@active_start_date=20200814, 
		@active_end_date=99991231, 
		@active_start_time=0, 
		@active_end_time=235959, 
		@schedule_uid=N'e6aac6e1-cf05-4ca5-b575-77f1deccbe65'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:
GO


