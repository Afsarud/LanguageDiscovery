alter PROCEDURE [dbo].[usp_SaveMessage]	
	@xml xml,
	@MessageIDs nvarchar(50) = '0' out 
	--@Subject nvarchar(50)
 --  ,@SenderID bigint
 --  ,@RecepientID bigint
 --  ,@NativeLanguageMessage nvarchar(max)
 --  ,@LearningLanguageMessage nvarchar(max)
as
BEGIN

set @MessageIDs = 0

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
	   ,Keyword nvarchar(250)
	   ,IsFromNewFriends bit
	   ,NeedResponse bit
	   ,IsDirectReply bit
	   ,IsRejected bit
	)

	DECLARE @NewFriendsMessage as table
	(
		RecepientID bigint,
		NewFriendMessageCount int
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
		   XTbl.value('(Keyword)[1]', 'nvarchar(250)'),
		   XTbl.value('(IsFromNewFriends)[1]', 'bit'),
		   XTbl.value('(NeedResponse)[1]', 'bit'),
		   XTbl.value('(IsDirectReply)[1]', 'bit'),
		   XTbl.value('(IsRejected)[1]', 'bit')
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
	FROM UserMessage um 
	INNER JOIN @Message m on um.RecepientID = m.RecepientID and um.IsFromNewFriends = 1
	inner join [user] u on u.UserID = um.SenderID
	WHERE um.ReadDate IS NULL AND um.Reviewed = 1 and isnull(um.HasFilteredWords,0) = 0 AND um.IsActive = 1 and um.IsFromNewFriends = 1
	group by um.RecepientID
		
	
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
			   )
	select [Subject]
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
	from @Message m
	left join @NewFriendsMessage nm on m.RecepientID = nm.RecepientID 
	where nm.NewFriendMessageCount is null or nm.NewFriendMessageCount < 20
	
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
END




GO