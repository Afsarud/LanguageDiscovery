SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure [dbo].[usp_SendAutoMail]
	@UserID int,
	@UserMailID bigint output
as

BEGIN
declare @TempUserID int = @UserID
DECLARE @RetryCount INT
DECLARE @Success    BIT
set @RetryCount = 1
set @Success = 0
WHILE @RetryCount < =  3 AND @Success = 0
BEGIN
BEGIN TRY
    BEGIN TRANSACTION;
	if exists(select 1 
			  from [user] u 
			  inner join SchoolInfo s on u.SchoolID = s.SchoolID
			  inner join SchoolType st on s.SchoolTypeID = st.SchoolTypeID
			  where st.IsRobot = 1 and u.UserID = @TempUserID)
	begin
		rollback
		return
	end
	
	declare @IsDemo bit
	declare @UserTypeID int
	declare @LevelId int
	declare @AllowSameCountry bit
	declare @CountryID int
	declare @SchoolTypeID int
	declare @IsDemoAuto bit

	declare @uid as int
	set @uid = @TempUserID 
	declare @Messages as table
	(
		[Message] nvarchar(max)
	)
	
	SELECT @IsDemo = U.IsDemo, @UserTypeID = U.UserTypeID ,
	@LevelId = u.LevelID, @AllowSameCountry = s.AllowSameCountry,
	@CountryID = U.CountryID, @SchoolTypeID = st.SchoolTypeID,
	@IsDemoAuto = st.IsRobot
	From [user] U
	inner join SchoolInfo S on u.SchoolID = s.SchoolID
	inner join SchoolType ST on s.SchoolTypeID = st.SchoolTypeID
	where U.UserID = @uid

	--declare @UserMailID as bigint
	declare @SenderID as bigint
	declare @Unreadmessage int
	
	declare @FirstDate as datetime

	select top 1 @FirstDate = CreateDate from UserMessage where RecepientID = @TempUserID order by CreateDate desc

	set @FirstDate = DATEADD(hour, 4, @FirstDate) 
	
	if  @FirstDate is null OR  getdate()  >  @FirstDate
	begin
	
			IF @LevelId = 4
			BEGIN
				INSERT INTO @Messages
					select NativeLanguageMessage 
					from usermessage um with(nolock)
					inner join [user] U on um.RecepientID = u.UserID
					inner join SchoolInfo S on u.SchoolID = s.SchoolID 
					where recepientid = @uid and isnull(s.SchoolKey ,0) = 1
					and um.IsActive = 1 AND U.LevelID = @LevelId
					group by  SenderID, um.createdate, NativeLanguageMessage
				UNION ALL
					select [LearningLanguageMessage] 
					from usermessage um with(nolock)
					inner join [user] U on um.RecepientID = u.UserID
					inner join SchoolInfo S on u.SchoolID = s.SchoolID 
					where recepientid = @uid and isnull(s.SchoolKey ,0) = 1
					and um.IsActive = 1 AND U.LevelID = @LevelId
					group by  SenderID, um.createdate, [LearningLanguageMessage]
			END
			ELSE
			BEGIN
				INSERT INTO @Messages
					select NativeLanguageMessage 
					from usermessage um with(nolock)
					inner join [user] U on um.RecepientID = u.UserID
					inner join SchoolInfo S on u.SchoolID = s.SchoolID 
					where recepientid = @uid and isnull(s.SchoolKey ,0) = 1
					and um.IsActive = 1
					group by  SenderID, um.createdate, NativeLanguageMessage
				UNION ALL
					select [LearningLanguageMessage] 
					from usermessage um with(nolock)
					inner join [user] U on um.RecepientID = u.UserID
					inner join SchoolInfo S on u.SchoolID = s.SchoolID 
					where recepientid = @uid and isnull(s.SchoolKey ,0) = 1
					and um.IsActive = 1
					group by  SenderID, um.createdate, [LearningLanguageMessage]
			END
			IF @IsDemoAuto = 1
			BEGIN
				SELECT  Top 1 @UserMailID = ISNULL(UserMailID,0), @SenderID = SenderID 
				FROM UserMessage UM with(nolock)
				inner join [user] U1 on RecepientID = u1.UserID
				inner join [user] U2 on SenderID = u2.UserID
				inner join SchoolInfo S1 on u1.SchoolID = s1.SchoolID
				inner join SchoolInfo S2 on u2.SchoolID = s2.SchoolID
				where datediff(dd,UM.CreateDate, GETDATE()) <= 100
				--and IsFromNewFriends = 1
				--and UserMailID not in (SELECT isnull(AutoSendOriginalMessageID,0) FROM UserMessage where RecepientID = @TempUserID  )
				and NativeLanguageMessage not in (select [Message] From @Messages)
				and [LearningLanguageMessage] not in (select [Message] From @Messages)
				and Reviewed = 1 and isnull(HasFilteredWords,0) = 0 and um.IsActive = 1
				and isnull(s1.SchoolKey,0) = 1 and isnull(s2.SchoolKey,0) = 1
				and u2.IsDemo = @IsDemo and U2.UserTypeID = @UserTypeID
				AND ( (@AllowSameCountry = 1 AND U2.UserTypeID = @UserTypeID ) OR u2.CountryID <> @CountryID )
				AND S2.SchoolTypeID = @SchoolTypeID
				AND (UM.PriorityCount > 0 and PriorityCount <= 3)
				order by NEWID() 

				IF ISNULL(@UserMailID,0) = 0 
				BEGIN
					SELECT  Top 1 @UserMailID = ISNULL(UserMailID,0), @SenderID = SenderID 
					FROM UserMessage UM with(nolock)
					inner join [user] U1 on RecepientID = u1.UserID
					inner join [user] U2 on SenderID = u2.UserID
					inner join SchoolInfo S1 on u1.SchoolID = s1.SchoolID
					inner join SchoolInfo S2 on u2.SchoolID = s2.SchoolID
					where datediff(dd,UM.CreateDate, GETDATE()) <= 100
					and IsFromNewFriends = 1
					--and UserMailID not in (SELECT isnull(AutoSendOriginalMessageID,0) FROM UserMessage where RecepientID = @TempUserID  )
					and NativeLanguageMessage not in (select [Message] From @Messages)
					and [LearningLanguageMessage] not in (select [Message] From @Messages)
					and Reviewed = 1 and isnull(HasFilteredWords,0) = 0 and um.IsActive = 1
					and isnull(s1.SchoolKey,0) = 1 and isnull(s2.SchoolKey,0) = 1
					and u2.IsDemo = @IsDemo and U2.UserTypeID = @UserTypeID
					AND ( (@AllowSameCountry = 1 AND U2.UserTypeID = @UserTypeID ) OR u2.CountryID <> @CountryID )
					AND S2.SchoolTypeID = @SchoolTypeID
					order by NEWID() 
				END
			END
			ELSE IF @LevelId = 4
			BEGIN
				SELECT  Top 1 @UserMailID = ISNULL(UserMailID,0), @SenderID = SenderID 
				FROM UserMessage UM with(nolock)
				inner join [user] U1 on RecepientID = u1.UserID
				inner join [user] U2 on SenderID = u2.UserID
				inner join SchoolInfo S1 on u1.SchoolID = s1.SchoolID
				inner join SchoolInfo S2 on u2.SchoolID = s2.SchoolID
				where datediff(dd,UM.CreateDate, GETDATE()) <= 100
				--and IsFromNewFriends = 1
				--and UserMailID not in (SELECT isnull(AutoSendOriginalMessageID,0) FROM UserMessage where RecepientID = @TempUserID  )
				and NativeLanguageMessage not in (select [Message] From @Messages)
				and [LearningLanguageMessage] not in (select [Message] From @Messages)
				and Reviewed = 1 and isnull(HasFilteredWords,0) = 0 and um.IsActive = 1
				and isnull(s1.SchoolKey,0) = 1 and isnull(s2.SchoolKey,0) = 1
				and u2.IsDemo = @IsDemo and U2.UserTypeID = @UserTypeID and u2.LevelID = @LevelId
				AND ( (@AllowSameCountry = 1 AND U2.UserTypeID = @UserTypeID ) OR u2.CountryID <> @CountryID )
				ANd (UM.PriorityCount > 0 and PriorityCount <= 3)
				order by NEWID() 

				IF ISNULL(@UserMailID,0) = 0 
				BEGIN
					SELECT  Top 1 @UserMailID = ISNULL(UserMailID,0), @SenderID = SenderID 
					FROM UserMessage UM with(nolock)
					inner join [user] U1 on RecepientID = u1.UserID
					inner join [user] U2 on SenderID = u2.UserID
					inner join SchoolInfo S1 on u1.SchoolID = s1.SchoolID
					inner join SchoolInfo S2 on u2.SchoolID = s2.SchoolID
					where datediff(dd,UM.CreateDate, GETDATE()) <= 100
					and IsFromNewFriends = 1
					--and UserMailID not in (SELECT isnull(AutoSendOriginalMessageID,0) FROM UserMessage where RecepientID = @TempUserID  )
					and NativeLanguageMessage not in (select [Message] From @Messages)
					and [LearningLanguageMessage] not in (select [Message] From @Messages)
					and Reviewed = 1 and isnull(HasFilteredWords,0) = 0 and um.IsActive = 1
					and isnull(s1.SchoolKey,0) = 1 and isnull(s2.SchoolKey,0) = 1
					and u2.IsDemo = @IsDemo and U2.UserTypeID = @UserTypeID and u2.LevelID = @LevelId
					AND ( (@AllowSameCountry = 1 AND U2.UserTypeID = @UserTypeID ) OR u2.CountryID <> @CountryID )
					order by NEWID() 
				END
			END
			ELSE 
			BEGIN
				SELECT  Top 1 @UserMailID = ISNULL(UserMailID,0), @SenderID = SenderID 
				FROM UserMessage UM with(nolock)
				inner join [user] U1 on RecepientID = u1.UserID
				inner join [user] U2 on SenderID = u2.UserID
				inner join SchoolInfo S1 on u1.SchoolID = s1.SchoolID
				inner join SchoolInfo S2 on u2.SchoolID = s2.SchoolID
				where datediff(dd,UM.CreateDate, GETDATE()) <= 100
				--and IsFromNewFriends = 1
				--and UserMailID not in (SELECT isnull(AutoSendOriginalMessageID,0) FROM UserMessage where RecepientID = @TempUserID  )
				and NativeLanguageMessage not in (select [Message] From @Messages)
				and [LearningLanguageMessage] not in (select [Message] From @Messages)
				and Reviewed = 1 and isnull(HasFilteredWords,0) = 0 and um.IsActive = 1
				and isnull(s1.SchoolKey,0) = 1 and isnull(s2.SchoolKey,0) = 1
				and u2.IsDemo = @IsDemo and U2.UserTypeID = @UserTypeID
				and u2.LevelID <> 4 -- test level
				AND ( (@AllowSameCountry = 1 AND U2.UserTypeID = @UserTypeID ) OR u2.CountryID <> @CountryID )
				AND (UM.PriorityCount > 0 and PriorityCount <= 3)
				order by NEWID() 

				IF ISNULL(@UserMailID,0) = 0 
				BEGIN
					SELECT  Top 1 @UserMailID = ISNULL(UserMailID,0), @SenderID = SenderID 
					FROM UserMessage UM with(nolock)
					inner join [user] U1 on RecepientID = u1.UserID
					inner join [user] U2 on SenderID = u2.UserID
					inner join SchoolInfo S1 on u1.SchoolID = s1.SchoolID
					inner join SchoolInfo S2 on u2.SchoolID = s2.SchoolID
					where datediff(dd,UM.CreateDate, GETDATE()) <= 100
					and IsFromNewFriends = 1
					--and UserMailID not in (SELECT isnull(AutoSendOriginalMessageID,0) FROM UserMessage where RecepientID = @TempUserID  )
					and NativeLanguageMessage not in (select [Message] From @Messages)
					and [LearningLanguageMessage] not in (select [Message] From @Messages)
					and Reviewed = 1 and isnull(HasFilteredWords,0) = 0 and um.IsActive = 1
					and isnull(s1.SchoolKey,0) = 1 and isnull(s2.SchoolKey,0) = 1
					and u2.IsDemo = @IsDemo and U2.UserTypeID = @UserTypeID
					and u2.LevelID <> 4 -- test level
					AND ( (@AllowSameCountry = 1 AND U2.UserTypeID = @UserTypeID ) OR u2.CountryID <> @CountryID )
				order by NEWID() 
				END 
			END
			
			IF ISNULL(@UserMailID,0) > 0
			BEGIN
				
				INSERT INTO [UserMessage]
				SELECT [Subject]
					   ,SenderID
					   ,@TempUserID
					   ,GETDATE()
					   ,[NativeLanguageMessage]
					   ,[LearningLanguageMessage]
					   ,null
					   ,1
					   ,1
					   ,[ReviewedByID]
					   ,GETDATE()
					   ,[HasFilteredWords]
					   ,[IsFeedBack]
					   ,[OriginalRecepientID]
					   ,0
					   ,[Keyword]
					   ,0
					   ,0
					   ,[ResponseToUserMailID]
					   ,0
					   ,0
					   ,0
					   ,@UserMailID
					   ,NativeLanguageMessageRecepient
					   ,LearningLanguageMessageRecepient
					   ,1
					   ,0
					   ,0
				FROM UserMessage with(nolock)
				WHERE UserMailID = @UserMailID

				update UserMessage set PriorityCount = PriorityCount + 1 where UserMailID = @UserMailID
			--end
		END
	End

	SET @UserMailID = isnull(@UserMailID,0)
	
   COMMIT TRANSACTION;
	set  @Success = 1
END TRY
BEGIN CATCH 
      ROLLBACK TRANSACTION
 
      SELECT  ERROR_NUMBER() AS [Error Number],
      ERROR_MESSAGE() AS [ErrorMessage];     
  
      -- Now we check the error number to 
      -- only use retry logic on the errors we 
      -- are able to handle.
      --
      -- You can set different handlers for different 
      -- errors
      IF ERROR_NUMBER() IN (  1204, -- SqlOutOfLocks
                              1205, -- SqlDeadlockVictim
                              1222 -- SqlLockRequestTimeout
                              )
      BEGIN
            SET @RetryCount = @RetryCount + 1  
            -- This delay is to give the blocking 
            -- transaction time to finish.
            -- So you need to tune according to your 
            -- environment
            WAITFOR DELAY '00:00:02'  
      END 
      ELSE    
      BEGIN
            -- If we don't have a handler for current error
            -- then we throw an exception and abort the loop
			 SET @RetryCount = 4
            ;THROW
      END
   END CATCH
END
end