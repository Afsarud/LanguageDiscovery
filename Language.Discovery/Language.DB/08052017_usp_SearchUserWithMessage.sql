ALTER procedure [dbo].[usp_SearchUserWithMessage]
	@Name nvarchar(50) = null,
	@SearcheeID bigint
as
begin

	set nocount on
	declare @SearcheeUserID bigint
	
	SET @SearcheeUserID = @SearcheeID
	
	declare @SearcheeLevelID int
	SELECT @SearcheeLevelID = LevelID FROM [User] where UserID = @SearcheeUserID
	
	declare @users as table
	(
		UserID bigint,
		RecipientID bigint,
		UnreadMessageCount int
	)
	INSERT INTO @USERS
	SELECT SenderID, RecepientID, Count(SenderID) 
	FROM UserMessage 
	WHERE recepientid = @SearcheeUserID and ReadDate IS NULL AND Reviewed = 1 and isnull(HasFilteredWords,0) = 0 AND IsActive = 1
	Group By SenderID, RecepientID
	
	
	declare @replied as table
	(
		CreateDate Datetime,
		SenderID bigint,
		RecepientID bigint,
		x bit
	)

	declare @DirectReply as table
	(
		SenderID bigint,
		RecepientID bigint,
		RepliedDate datetime
		--HasDirectReply bit default(0)
	)

	insert into @DirectReply
	SELECT SenderID, RecepientID, Max(createdate)--case when count(isdirectreply) > 0 then 1 else 0 end
	FROM UserMessage (nolock)
	WHERE recepientid = @SearcheeUserID and ReadDate IS NULL AND Reviewed = 1 and isnull(HasFilteredWords,0) = 0 AND IsActive = 1 and IsDirectReply = 1
	Group By SenderID, RecepientID

	--SELECT MAX(UM.CREATEDATE) CreateDate, SenderID, RecepientID
	--FROM UserMessage UM
	--INNER JOIN [User] U on U.UserID = UM.SenderID or U.UserID = UM.RecepientID 
	--inner join SchoolInfo si on U.SchoolID = si.SchoolID
	--WHERE SenderID = @SearcheeUserID OR RecepientID = @SearcheeUserID and IsDirectReply = 1
	--AND Reviewed = 1 and 
	--isnull(HasFilteredWords,0) = 0 AND UM.IsActive = 1
	--and Userid <> @SearcheeUserID
	--group by SenderID, RecepientID
	
	insert into @replied 
	SELECT * FROM (
	SELECT MAX(Um.CreateDate) CreateDate, SenderID, RecepientID, case when senderid = @SearcheeUserID then 1 else 0 end x
	FROM UserMessage UM (nolock)
	INNER JOIN [User] on [user].UserID = UM.SenderID or [user].UserID = UM.RecepientID 
	inner join SchoolInfo si on [user].SchoolID = si.SchoolID
	--left JOIN City ON [User].CityID = City.CityID and City.LanguageCode = 'en-US'
	WHERE SenderID = @SearcheeUserID OR RecepientID = @SearcheeUserID
	AND Reviewed = 1 and 
	isnull(HasFilteredWords,0) = 0 AND UM.IsActive = 1
	and UserID <> @SearcheeUserID
	GROUP BY SenderID,RecepientID 
	) X 
	ORDER BY CreateDate DESC
	
	
	
	select distinct  x.UserID, UserName,FirstName, LastName, C.CityName + ',' + x.CountryName as [Address], isnull(Avatar,'') Avatar, StatusText, 
		IsOnline, x.CreateDate, isnull(xx.UnReadMessageCount,0) UnReadMessageCount, SchoolID, r.x IsReplied,dr.RepliedDate
	from
	(
	SELECT u.UserID,UserName,FirstName, LastName, U.[Address], isnull(Avatar,'') Avatar, StatusText, 
		IsOnline, MAX(UM.CREATEDATE) AS CreateDate --, Max(UM.CreateDate) CreateDate
		,City.CityHeaderID, Country.CountryName, si.SchoolID--,  1 IsReplied  --dbo.ufn_IsLastMessageMine(u.UserID, @SearcheeID) as IsReplied 
		FROM [User] U
		--INNER JOIN UserFriends ON  [user].UserID = UserFriends.FriendUserID 
		INNER JOIN UserMessage UM (nolock) on U.UserID = UM.SenderID or U.UserID = UM.RecepientID --HM 72 and isnull(UM.IsFromNewFriends,0) = 0
		left JOIN Country on U.CountryID = Country.CountryID 
		left JOIN City ON U.CityID = City.CityID
		inner join SchoolInfo si on U.SchoolID = si.SchoolID
		WHERE (@Name is null or ( UserName like  @Name + '%' OR FirstName like @Name + '%')) --and  MainUserID = @SearcheeID AND ReadDate is null
		AND (U.UserID in (SELECT DISTINCT SenderID 
						FROM UserMessage (nolock)
						WHERE RecepientID = @SearcheeUserID	
						)
		OR u.UserID in (SELECT DISTINCT RecepientID 
						FROM UserMessage (nolock)
						WHERE SenderID = @SearcheeUserID			
						)	)	
		--and [User].UserTypeID = 3 -- Student Only
		--AND [User].LevelID = @SearcheeLevelID
		and (UM.RecepientID = @SearcheeUserID OR UM.SenderID = @SearcheeUserID) and UM.Reviewed = 1 and UM.IsActive = 1
		and isnull(si.SchoolKey,0) = 1
		
		--and UM.IsFromNewFriends = case when UM.SenderID = @SearcheeUserID  then 0 else 1 end  
		--and (UM.SenderID = @SearcheeUserID and UM.IsFromNewFriends = 0 )
		--    OR (UM.SenderID <> @SearcheeUserID AND UM.IsFromNewFriends in (1,0))
		group by u.UserID,UserName,FirstName, LastName, U.[Address], Avatar, StatusText, IsOnline, City.CityHeaderID, Country.CountryName,si.SchoolID
	) x
	left join @users xx on xx.UserID = x.UserID 
	left join City C on x.CityHeaderID = C.CityHeaderID and C.LanguageCode = 'en-US'
	left JOIN @replied R ON R.CreateDate = x.CreateDate 
	left join @DirectReply dr on x.UserID = dr.SenderID
	where x.UserID <> @SearcheeUserID
	order by x.CreateDate  desc --dr.RepliedDate desc,

	set nocount off
end

