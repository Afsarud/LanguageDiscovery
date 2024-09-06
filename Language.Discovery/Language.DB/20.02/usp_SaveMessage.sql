ALTER PROCEDURE [dbo].[usp_SaveMessage]	
	@xml xml,
	@IsCC bit = 0,
	@MessageIDs nvarchar(50) = '0' out 
	--@Subject nvarchar(50)
 --  ,@SenderID bigint
 --  ,@RecepientID bigint
 --  ,@NativeLanguageMessage nvarchar(max)
 --  ,@LearningLanguageMessage nvarchar(max)
as
BEGIN

set @MessageIDs = 0

DECLARE @RetryCount INT
DECLARE @Success    BIT
set @RetryCount = 1
set @Success = 0
WHILE @RetryCount < =  3 AND @Success = 0
BEGIN
BEGIN TRY
    BEGIN TRANSACTION;

--<ArrayOfUserMessageContract xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">
--  <UserMessageContract>
--    <UserMailID>0</UserMailID>
--    <Subject />
--    <SenderID>4</SenderID>
--    <RecepientID>6</RecepientID>
--    <CreateDate>0001-01-01T00:00:00</CreateDate>
--    <NativeLanguageMessage>I&amp;amp;nbsp;Love&amp;amp;nbsp;Football&amp;amp;nbsp;&amp;lt;br/&amp;gt;</NativeLanguageMessage>
--    <LearningLanguageMessage>ラブ&amp;amp;nbsp;私&amp;amp;nbsp;サッカー&amp;amp;nbsp;&amp;lt;br/&amp;gt;</LearningLanguageMessage>
--    <ReadDate>0001-01-01T00:00:00</ReadDate>
--    <IsActive>false</IsActive>
--    <IsReply>false</IsReply>
--  </UserMessageContract>
--  <UserMessageContract>
--    <UserMailID>0</UserMailID>
--    <Subject />
--    <SenderID>4</SenderID>
--    <RecepientID>5</RecepientID>
--    <CreateDate>0001-01-01T00:00:00</CreateDate>
--    <NativeLanguageMessage>I&amp;amp;nbsp;Love&amp;amp;nbsp;Football&amp;amp;nbsp;&amp;lt;br/&amp;gt;</NativeLanguageMessage>
--    <LearningLanguageMessage>ラブ&amp;amp;nbsp;私&amp;amp;nbsp;サッカー&amp;amp;nbsp;&amp;lt;br/&amp;gt;</LearningLanguageMessage>
--    <ReadDate>0001-01-01T00:00:00</ReadDate>
--    <IsActive>false</IsActive>
--    <IsReply>false</IsReply>
--  </UserMessageContract>
--  <UserMessageContract>
--    <UserMailID>0</UserMailID>
--    <Subject />
--    <SenderID>4</SenderID>
--    <RecepientID>3</RecepientID>
--    <CreateDate>0001-01-01T00:00:00</CreateDate>
--    <NativeLanguageMessage>I&amp;amp;nbsp;Love&amp;amp;nbsp;Football&amp;amp;nbsp;&amp;lt;br/&amp;gt;</NativeLanguageMessage>
--    <LearningLanguageMessage>ラブ&amp;amp;nbsp;私&amp;amp;nbsp;サッカー&amp;amp;nbsp;&amp;lt;br/&amp;gt;</LearningLanguageMessage>
--    <ReadDate>0001-01-01T00:00:00</ReadDate>
--    <IsActive>false</IsActive>
--    <IsReply>false</IsReply>
--  </UserMessageContract>
--</ArrayOfUserMessageContract>

	DECLARE @Message as table
	(
	   ID int identity(1,1),
	   [Subject] nvarchar(50)
	   ,[SenderID] bigint
	   ,[RecepientID] bigint
	   ,[CreateDate] datetime
	   ,[NativeLanguageMessage] nvarchar(max)
	   ,[LearningLanguageMessage] nvarchar(max)
	   ,[NativeLanguageMessageRecepient] nvarchar(max)
	   ,[LearningLanguageMessageRecepient] nvarchar(max)
	   ,[IsActive] bit
	   ,[HasFilteredWords] bit
	   ,Reviewed bit
	   ,Keyword nvarchar(max)
	   ,IsFromNewFriends bit
	   ,NeedResponse bit
	   ,IsDirectReply bit
	   ,IsRejected bit
	   ,PriorityCount int
	)

	DECLARE @NewFriendsMessage as table
	(
		RecepientID bigint,
		NewFriendMessageCount int
	)

	DECLARE @RandomUser as table
	(
		ID int identity(1,1),
		RecepientID bigint
	)

	declare @IsMailCheck bit
	DECLARE @SenderID bigint
	declare @SchoolID int
	declare @HasFilteredWords bit
	declare @Reviewd bit
	declare @IsDemo bit
	
	

	INSERT INTO @Message
	SELECT XTbl.value('(Subject)[1]', 'nvarchar(100)'),
		   XTbl.value('(SenderID)[1]', 'bigint'),
		   XTbl.value('(RecepientID)[1]', 'bigint'),
		   GETDATE(),
		   XTbl.value('(NativeLanguageMessage)[1]', 'nvarchar(max)'),
		   XTbl.value('(LearningLanguageMessage)[1]', 'nvarchar(max)'),
		   XTbl.value('(NativeLanguageMessageRecepient)[1]', 'nvarchar(max)'),
		   XTbl.value('(LearningLanguageMessageRecepient)[1]', 'nvarchar(max)'),
		   1,
		   XTbl.value('(HasFilteredWords)[1]', 'bit'),
		   0,
		   XTbl.value('(Keyword)[1]', 'nvarchar(max)'),
		   XTbl.value('(IsFromNewFriends)[1]', 'bit'),
		   XTbl.value('(NeedResponse)[1]', 'bit'),
		   XTbl.value('(IsDirectReply)[1]', 'bit'),
		   XTbl.value('(IsRejected)[1]', 'bit'),
		   0
		   FROM  @xml.nodes('ArrayOfUserMessageContract/UserMessageContract') AS XD(XTbl)
	
	select top 1 @SenderID = SenderID From @Message
	select top 1 @SchoolID = SchoolID, @IsDemo = (IsDemo &  case when Reference is not null then 1 else 0 end) From [User] where UserID = @SenderID
	select @HasFilteredWords = dbo.ufn_CheckForFilteredWords(NativeLanguageMessage + LearningLanguageMessage)
	from @Message 
	IF ISNULL(@SchoolID,0) > 0
	begin
		select @IsMailCheck = MailCheck from SchoolInfo where SchoolID = @SchoolID
		UPDATE @Message SET Reviewed = ~(@HasFilteredWords | @IsMailCheck) where IsRejected = 0
	end

	INSERT INTO @NewFriendsMessage
	SELECT um.RecepientID, count(1) 
	FROM UserMessage um  with(nolock)
	INNER JOIN @Message m on um.RecepientID = m.RecepientID and um.IsFromNewFriends = 1
	inner join [user] u on u.UserID = um.SenderID
	WHERE um.ReadDate IS NULL AND um.Reviewed = 1 and isnull(um.HasFilteredWords,0) = 0 AND um.IsActive = 1 and um.IsFromNewFriends = 1
	group by um.RecepientID
	
	IF @IsCC = 1
	BEGIN
		INSERT INTO @RandomUser
		SELECT top 2 UserID FROM [User] WHERE IsActive = 1 AND IsOnline = 1 and IsDemo = @IsDemo and UserTypeID = 3
		AND UserID not in (select RecepientID from @NewFriendsMessage)
		AND UserID not in (select RecepientID from @Message)
		and UserID <> @SenderID
		ORDER BY NEWID()

		DECLARE @RandomUserCount int
		SELECT @RandomUserCount = count(*) from @RandomUser
		IF isnull(@RandomUserCount,0) = 0
		BEGIN
			DECLARE @MaxId int
			SELECT @MaxId = Max(ID) FROM @Message
			UPDATE @Message SET PriorityCount = 1 WHERE IsDirectReply = 1 and ID = @MaxId
		END
		ELSE
		BEGIN
			DECLARE @tempid INT = 1
			DECLARE @MaxtempId INT = 0
			SELECT @MaxtempId = MAX(ID) FROM @RandomUser
			WHILE @tempid <= @MaxtempId
			BEGIN
				declare @tempuserid as int
				select @tempuserid  = RecepientID from @RandomUser where ID = @tempid 
				INSERT INTO @Message
				select top 1 [Subject]
					   ,[SenderID]
					   ,@tempuserid
					   ,[CreateDate]
					   ,[NativeLanguageMessage]
					   ,[LearningLanguageMessage]
					   ,[NativeLanguageMessageRecepient]
					   ,[LearningLanguageMessageRecepient]
					   ,[IsActive]
					   ,[HasFilteredWords]
					   ,Reviewed
					   ,Keyword
					   ,IsFromNewFriends
					   ,@IsDemo 
					   ,IsDirectReply
					   ,IsRejected
					   ,0
				from @Message m
				SET @tempid = @tempid + 1
			END
		
		END
	END

	INSERT INTO [UserMessage]
			   ([Subject]
			   ,[SenderID]
			   ,[RecepientID]
			   ,[CreateDate]
			   ,[NativeLanguageMessage]
			   ,[LearningLanguageMessage]
			   ,[NativeLanguageMessageRecepient]
			   ,[LearningLanguageMessageRecepient]
			   ,[IsActive]
			   ,[HasFilteredWords]
			   ,Reviewed
			   ,Keyword
			   ,IsFromNewFriends
			   ,NeedResponse
			   ,IsDirectReply
			   ,PriorityCount
			   )
	select	   [Subject]
			   ,[SenderID]
			   ,m.[RecepientID]
			   ,[CreateDate]
			   ,[NativeLanguageMessage]
			   ,[LearningLanguageMessage]
			   ,[NativeLanguageMessageRecepient]
			   ,[LearningLanguageMessageRecepient]
			   ,[IsActive]
			   ,dbo.ufn_CheckForFilteredWords(NativeLanguageMessage + LearningLanguageMessage)
			   ,Reviewed
			   ,Keyword
			   ,IsFromNewFriends
			   ,@IsDemo 
			   ,IsDirectReply
			   ,PriorityCount
	from @Message m
	left join @NewFriendsMessage nm on m.RecepientID = nm.RecepientID 
	--where nm.NewFriendMessageCount is null or nm.NewFriendMessageCount < 20
	
	DECLARE @ID int 
	declare @RecordCount int
	
	select @RecordCount = COUNT(1) from @Message
	set @ID = 1
	WHILE ( @ID <= @RecordCount )
	BEGIN
		DECLARE @UserID BIGINT
		DECLARE @UserIDToAdd BIGINT
		
		SELECT @UserID = SenderID, @UserIDToAdd = RecepientID FROM @Message WHERE ID = @ID
		
		IF(not EXISTS( SELECT 1 FROM UserFriends WHERE MainUserID = @UserID AND FriendUserID = @UserIDToAdd ) )
		BEGIN
			INSERT INTO UserFriends
			VALUES (@UserID, @UserIDToAdd, GETDATE())

			INSERT INTO UserFriends
			VALUES (@UserIDToAdd, @UserID, GETDATE())
		END
		SET @UserID = NULL
		SET @UserIDToAdd = NULL
		
		SET @ID = @ID + 1
	
	END
--SELECT XTbl.value('(Subject)[1]', 'nvarchar(100)'),
--	   XTbl.value('(SenderID)[1]', 'bigint'),
--	   XTbl.value('(RecepientID)[1]', 'bigint'),
--	   GETDATE(),
--	   XTbl.value('(NativeLanguageMessage)[1]', 'nvarchar(max)'),
--	   XTbl.value('(LearningLanguageMessage)[1]', 'nvarchar(max)'),
--	   1,
--	   XTbl.value('(HasFilteredWords)[1]', 'bit')
--       FROM  @xml.nodes('ArrayOfUserMessageContract/UserMessageContract') AS XD(XTbl)

--INSERT INTO [UserMessage]
--           ([Subject]
--           ,[SenderID]
--           ,[RecepientID]
--           ,[CreateDate]
--           ,[NativeLanguageMessage]
--           ,[LearningLanguageMessage]
--           ,[IsActive])
--     VALUES
--           (@Subject
--           ,@SenderID
--           ,@RecepientID
--           ,getdate()
--           ,@NativeLanguageMessage
--           ,@LearningLanguageMessage
--           ,1)

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
END