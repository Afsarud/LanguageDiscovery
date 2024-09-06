ALTER procedure [dbo].[usp_GetMessageTrailBySenderID]
	@SenderID bigint,
	@RecepientID bigint,
	@PageNumber INT = 1,
	@RowsPerPage INT = 5
as
begin	

DECLARE @UserMessage as table
	(
		ID [bigint] IDENTITY(1,1) NOT NULL,
		UserMailID bigint NOT NULL,
		[Subject] nvarchar(50) NULL,
		[SenderID] bigint NOT NULL,
		[RecepientID] bigint NOT NULL,
		[CreateDate] datetime NOT NULL,
		[NativeLanguageMessage] nvarchar(max) NULL,
		[LearningLanguageMessage] nvarchar(max) NULL,
		[NativeLanguageMessageRecepient] nvarchar(max) NULL,
		[LearningLanguageMessageRecepient] nvarchar(max) NULL,
		[ReadDate] datetime NULL,
		[IsActive] bit NOT NULL,
		IsReply bit,
		RecepientAvatar nvarchar(50),
		SenderAvatar nvarchar(50),
		IsLike bit,
		Keyword nvarchar(500),
		IsFromNewFriends bit
	)

	INSERT INTO @UserMessage
	SELECT UserMailID, [Subject], [SenderID] , [RecepientID],UserMessage.[CreateDate],
	 replace([NativeLanguageMessage],'firstword','') NativeLanguageMessage, replace([LearningLanguageMessage],'secondword','') [LearningLanguageMessage], isnull([NativeLanguageMessageRecepient],'') NativeLanguageMessageRecepient, 
	 isnull([LearningLanguageMessageRecepient],'') LearningLanguageMessageRecepient, [ReadDate],UserMessage.[IsActive], 
	 Cast(0 as bit)  as IsReply, isnull(U.Avatar,'') AS RecepientAvatar,isnull(u1.Avatar,'') as SenderAvatar, IsLike, Keyword, IsFromNewFriends
	FROM UserMessage
	inner join [User] u on UserMessage.RecepientID = u.UserID
	inner join [User] u1 on UserMessage.SenderID = u1.UserID	
	WHERE (SenderID = @SenderID AND RecepientID = @RecepientID) AND Reviewed = 1 and isnull(HasFilteredWords,0) = 0 AND UserMessage.IsActive = 1
	and UserMessage.IsDeleted = 0
	
	union all

	SELECT UserMailID, [Subject], [SenderID] , [RecepientID],UserMessage.[CreateDate],
	 replace([NativeLanguageMessage],'firstword','') NativeLanguageMessage, replace([LearningLanguageMessage],'secondword','') [LearningLanguageMessage], isnull([NativeLanguageMessageRecepient],'') NativeLanguageMessageRecepient, 
	 isnull([LearningLanguageMessageRecepient],'') LearningLanguageMessageRecepient, [ReadDate],UserMessage.[IsActive], 
	Cast(1 as bit)  as IsReply, isnull(U.Avatar,'') AS RecepientAvatar,isnull(u1.Avatar,'') as SenderAvatar, IsLike, Keyword, IsFromNewFriends
	FROM UserMessage
	inner join [User] u on UserMessage.RecepientID = u.UserID
	inner join [User] u1 on UserMessage.SenderID = u1.UserID	
	WHERE 
	(SenderID = @RecepientID AND RecepientID = @SenderID) AND Reviewed = 1 and isnull(HasFilteredWords,0) = 0 AND UserMessage.IsActive = 1
--	and (UserMessage.SenderID <> @RecepientID  AND UserMessage.IsFromNewFriends = 0)
	and UserMessage.IsDeleted = 0
	--Order by UserMessage.CreateDate ASC
	

	--DELETE @UserMessage WHERE SenderID = @RecepientID and IsFromNewFriends = 1
	
	

	Select * from (
	SELECT top 30 * FROM @UserMessage
	Order by CreateDate desc) um
	order by CreateDate asc



END





