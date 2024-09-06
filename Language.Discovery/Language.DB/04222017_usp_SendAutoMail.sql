ALTER procedure [dbo].[usp_SendAutoMail]
	@UserID int,
	@UserMailID bigint output
as

BEGIN

	if exists(select 1 
			  from [user] u 
			  inner join SchoolInfo s on u.SchoolID = s.SchoolID
			  inner join SchoolType st on s.SchoolTypeID = st.SchoolTypeID
			  where st.IsRobot = 1 and u.UserID = @UserID)
	begin
		return
	end
	
	declare @IsDemo bit
	declare @UserTypeID int

	declare @uid as int
	set @uid = @UserID 
	declare @Messages as table
	(
		[Message] nvarchar(max)
	)
	
	SELECT @IsDemo = IsDemo, @UserTypeID = UserTypeID From [user] where UserID = @uid

	--declare @UserMailID as bigint
	declare @SenderID as bigint
	declare @Unreadmessage int
	
	declare @FirstDate as datetime

	select top 1 @FirstDate = CreateDate from UserMessage where RecepientID = @UserID order by CreateDate desc

	set @FirstDate = DATEADD(hour, 8, @FirstDate) 
	
	if  @FirstDate is null OR  getdate()  >  @FirstDate
	begin
	
			INSERT INTO @Messages
				select NativeLanguageMessage 
				from usermessage um
				inner join [user] U on um.RecepientID = u.UserID
				inner join SchoolInfo S on u.SchoolID = s.SchoolID 
				where recepientid = @uid and isnull(s.SchoolKey ,0) = 1
				and um.IsActive = 1
				group by  SenderID, um.createdate, NativeLanguageMessage
			UNION ALL
				select [LearningLanguageMessage] 
				from usermessage um
				inner join [user] U on um.RecepientID = u.UserID
				inner join SchoolInfo S on u.SchoolID = s.SchoolID 
				where recepientid = @uid and isnull(s.SchoolKey ,0) = 1
				and um.IsActive = 1
				group by  SenderID, um.createdate, [LearningLanguageMessage]
		
			SELECT  Top 1 @UserMailID = ISNULL(UserMailID,0), @SenderID = SenderID 
			FROM UserMessage UM
			inner join [user] U1 on RecepientID = u1.UserID
			inner join [user] U2 on SenderID = u2.UserID
			inner join SchoolInfo S1 on u1.SchoolID = s1.SchoolID
			inner join SchoolInfo S2 on u2.SchoolID = s2.SchoolID
			where datediff(dd,UM.CreateDate, GETDATE()) <= 10
			and IsFromNewFriends = 1
			--and UserMailID not in (SELECT isnull(AutoSendOriginalMessageID,0) FROM UserMessage where RecepientID = @UserID  )
			and NativeLanguageMessage not in (select [Message] From @Messages)
			and [LearningLanguageMessage] not in (select [Message] From @Messages)
			and Reviewed = 1 and isnull(HasFilteredWords,0) = 0 and um.IsActive = 1
			and isnull(s1.SchoolKey,0) = 1 and isnull(s2.SchoolKey,0) = 1
			and u2.IsDemo = @IsDemo and U2.UserTypeID = @UserTypeID
			order by NEWID() 
			
			if isnull(@UserMailID,0) > 0
			begin
				
				INSERT INTO [UserMessage]
				SELECT [Subject]
					   ,SenderID
					   ,@UserID
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
				FROM UserMessage
				WHERE UserMailID = @UserMailID
			--end
		END
	End

	set @UserMailID = isnull(@UserMailID,0)
	
END



