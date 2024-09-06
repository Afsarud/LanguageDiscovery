USE [Palaygo.11222018]
GO
/****** Object:  StoredProcedure [dbo].[usp_DiscoverNewFriends]    Script Date: 10/30/2019 11:15:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER procedure [dbo].[usp_DiscoverNewFriends]
	@InterestXml xml,
	@CityID int = 0,
	@Name nvarchar(50) = null,
	@SearcheeID bigint,
	@GenderXml as xml = null,
	@IsAddUser bit = 0
as
begin

	DECLARE @CountryID int
	DECLARE @LevelID int
	DECLARE @CityHeaderID int
	DECLARE @IsDemo int
	DECLARE @Top int 
	DECLARE @AllowSameCountry int 
	DECLARE @IsAfterSchool bit
	DECLARE @SchoolTypeID int
	DECLARE @SchoolTypeDemo bit
	DECLARE @UserTypeID int
	DECLARE @NativeLanguage nvarchar(20)
	DECLARE @LearningLanguage nvarchar(20)
	DECLARE @NativeMessageCount as int
	DECLARE @LearningMessageCount as int
	DECLARE @UserCountryId as int
	DECLARE @UserCountryLanguage as nvarchar(10)
	DECLARE @UserLearningCountryId as int




	declare @TempUser as Table
	(
		UserID bigint,
		FirstName nvarchar(100),
		LastName nvarchar(100),
		[Address] nvarchar(100),
		Avatar nvarchar(100),
		LastLogin datetime,
		MessageCount int,
		CityID int,
		Gender nvarchar(100),
		UserName nvarchar(100),
		StatusText nvarchar(100)
	)
	
	declare @TempUserZero as Table
	(
		UserID bigint,
		FirstName nvarchar(100),
		LastName nvarchar(100),
		[Address] nvarchar(100),
		Avatar nvarchar(100),
		LastLogin datetime,
		MessageCount int,
		CityID int,
		Gender nvarchar(100),
		UserName nvarchar(100),
		StatusText nvarchar(100)
	)

	declare @TempUserDate as Table
	(
		LastLogin2 date,
		LastLogin datetime
	)
	--Declare @EnableSameCountry varchar(1)
	
	--SELECT @EnableSameCountry = [Value] FROM SystemConfig WHERE [Name] = 'EnableSameCountry'
	set @Top = case when charindex('@', @Name) > 0 then 500 else 5 end
	select @CountryID = U.CountryID, @LevelID = U.LevelID, @IsDemo=isnull(U.IsDemo,0) ,
	@AllowSameCountry = isnull(S.AllowSameCountry ,0), @IsAfterSchool = U.AfterSchool ,
	@SchoolTypeID = s.SchoolTypeID, @SchoolTypeDemo = ST.IsRobot, @UserTypeID = U.UserTypeID,
	@NativeLanguage = ISNULL(u.NativeLanguage,''),
	@LearningLanguage = ISNULL(u.LearningLanguage,'')
	from [user] U
	inner join SchoolInfo S on U.SchoolID = S.SchoolID 
	inner join SchoolType ST on S.SchoolTypeID = ST.SchoolTypeID 
	where U.UserID = @SearcheeID
	
	DECLARE @Interest as table
	(
		InterestID int
	)
	
	DECLARE @GenderTable as table
	(
		Name nvarchar(10)
	)
	
	declare @CityIds as Table
	(
		CityID int
	)
	
	select @CityHeaderID = CityHeaderID  from City where CityID = @CityID 
	
	Insert into @CityIds 
	select CityID from City where CityHeaderID = @CityHeaderID 
	
	INSERT INTO @Interest
	SELECT InterestID 
	FROM Interest
	WHERE WordMapID IN 
	(
		SELECT Distinct WordMapID 
		FROM Interest 
		WHERE InterestID IN 
		( 
			SELECT XTbl.value('(ID)[1]', 'int')
			FROM  @InterestXml.nodes('Interests/IDS') AS XD(XTbl)
		)
	)
	
	INSERT INTO @GenderTable 
	SELECT XTbl.value('(Name)[1]', 'nvarchar(10)')
	FROM  @GenderXml.nodes('Genders/Names') AS XD(XTbl)

	DECLARE @COUNT  INT
	SELECT @COUNT = COUNT(1) FROM @Interest


	
	declare @UserMessage as table
	(
		UserID int,
		MessageCount int,
		LikeCount int	
	)

	INSERT INTO @UserMessage
	SELECT u.UserID,isnull(COUNT(um.RecepientID),0) as MessageCount,  isnull(sum(case when um.IsLike = 1 then 1 else 0 end),0) as LikeCount
	FROM [user] u 
	LEFT JOIN UserMessage um with(nolock) on  u.UserID = um.RecepientID 
	where u.IsActive = 1 and LastLogin is not null and LevelID in (1,2,6, @LevelID) and (CountryID <>@CountryID ) and UserID <> @SearcheeID
	GROUP BY u.userid


	--Use this logic for multi country
	SELECT @UserCountryId = CountryId FROM [Language] WHERE LanguageCode = @NativeLanguage
	SELECT @UserLearningCountryId = CountryId FROM [Language] WHERE LanguageCode = @LearningLanguage
	--AU
	SELECT @NativeMessageCount = Count(u.UserID ) 
	FROM  UserMessage UM with(nolock)
	INNER JOIN [user] u on UM.SenderID = u.UserID
	WHERE  ((@LevelID <> 0 and u.levelid = @levelID)  OR U.LevelID not in (3,4))
	and u.CountryID = @UserCountryId AND UM.CreateDate>=DATEADD(DAY,-500,GETDATE())
	--GROUP BY U.USerID
	
	--JP
	SELECT @LearningMessageCount = Count(u.UserID )
	FROM  UserMessage UM with(nolock)
	INNER JOIN [user] u on UM.SenderID = u.UserID
	WHERE  ((@LevelID <> 0 and u.levelid = @levelID)  OR U.LevelID not in (3,4))
	and u.CountryID = @UserLearningCountryId AND UM.CreateDate>=DATEADD(DAY,-500,GETDATE())
	
	DECLARE @Ratio as decimal = 100
	DECLARE @JPRatio as decimal
	DECLARE @ShouldIncreaseNativeUsersList as bit = 0
	
	IF @LearningMessageCount > @NativeMessageCount 
	begin
		SET @Ratio = @NativeMessageCount * 100.0/@LearningMessageCount 
	end
	
	IF @Ratio < 50
	BEGIN
		SET @ShouldIncreaseNativeUsersList = 1
	END

	if @IsAddUser = 1
	begin
		set @Top = 25
	end

	DECLARE @Temptop as INT = 50
	IF @LevelID = 4 
	BEGIN

		INSERT INTO @TempUserZero
		select top (@Top) temp.*, ISNULL(U.StatusText ,'') StatusText
		from
		(
			select  x.UserID,FirstName, LastName, IsNull(C.CityName,'') + '<br/>' + isnull(x.CountryName,'') as [Address], Avatar, LastLogin, x.MessageCount, CityID , Gender , UserName
			from 
			(
				SELECT  [user].UserID,FirstName, LastName, [User].[Address], Avatar, LastLogin, City.CityHeaderID, Country.CountryName, UM.MessageCount, Gender , [user].UserName
				FROM [User]  
				left JOIN @UserMessage UM on [user].UserID = UM.UserID
				left JOIN UserInterest ON  [user].UserID = UserInterest.UserID
				left JOIN Country on [User].CountryID = Country.CountryID 
				left JOIN City ON [User].CityID = City.CityID
				inner join SchoolInfo S on [User].SchoolID = S.SchoolID 
				WHERE ([User].IsOnline = 1 OR (not Exists( select 1 from @Interest ) OR UserInterest.InterestID IN  (
					SELECT InterestID FROM @Interest
				)) )
				AND (not Exists( select 1 from @GenderTable ) OR [user].Gender IN  ( SELECT Name FROM @GenderTable))
				AND [User].UserID <> @SearcheeID 
				and [user].UserTypeID in (@UserTypeID)
				AND ( (@AllowSameCountry = 1 AND [user].UserTypeID in (@UserTypeID) ) OR [User].CountryID <> @CountryID ) 
				AND ([User].LevelID in (@LevelID)  OR ( [User].IsRobot = 1 AND [User].LevelID = 4 ))--primary and secondary only
				AND (charindex('@', @Name) > 0 OR ([User].IsActive = 1 
				AND (([User].LastLogin is not null AND Datediff(day,[User].LastLogin, getdate()) <= 1000))) OR [User].IsRobot = 1 )
				AND (isnull(@Name,'') = '' or ([User].UserName like '%' + @Name + '%' or [User].FirstName like '%' + @Name + '%'))
				AND (isnull([User].IsDemo,0) = @IsDemo ) 
				and isnull([User].IsRobot,0) = @SchoolTypeDemo
				AND ISNULL(UM.MessageCount,0) = 0
				--and ((@IsAfterSchool = 0 and [User].AfterSchool in (1,0) )
				--		OR  (@IsAfterSchool = 1 and [User].AfterSchool = @IsAfterSchool ))
				and isnull(s.SchoolKey,0) = 1

				union all 

				SELECT  [user].UserID,FirstName, LastName, [User].[Address], Avatar, LastLogin, City.CityHeaderID, Country.CountryName, UM.MessageCount, Gender , [user].UserName
				FROM [User]  
				left JOIN @UserMessage UM on [user].UserID = UM.UserID
				left JOIN UserInterest ON  [user].UserID = UserInterest.UserID
				left JOIN Country on [User].CountryID = Country.CountryID 
				left JOIN City ON [User].CityID = City.CityID
				inner join SchoolInfo S on [User].SchoolID = S.SchoolID 
				WHERE ([User].IsOnline = 1 OR (not Exists( select 1 from @Interest ) OR UserInterest.InterestID IN  (
					SELECT InterestID FROM @Interest
				)) )
				AND (not Exists( select 1 from @GenderTable ) OR [user].Gender IN  ( SELECT Name FROM @GenderTable))
				AND [User].UserID <> @SearcheeID 
				and [user].UserTypeID in (@UserTypeID)
				AND ( (@AllowSameCountry = 1 AND [user].UserTypeID in (@UserTypeID) ) OR [User].CountryID <> @CountryID ) 
				AND ([User].LevelID in (@LevelID)  OR ( [User].IsRobot = 1 AND [User].LevelID = 4 ))--primary and secondary only
				AND (charindex('@', @Name) > 0 OR ([User].IsActive = 1 
				AND (([User].LastLogin is not null AND Datediff(day,[User].LastLogin, getdate()) <= 1000))) OR [User].IsRobot = 1 )
				AND (isnull(@Name,'') = '' or ([User].UserName like '%' + @Name + '%' or [User].FirstName like '%' + @Name + '%'))
				AND (isnull([User].IsDemo,0) = @IsDemo ) 
				and isnull([User].IsRobot,0) = @SchoolTypeDemo
				AND ISNULL(UM.LikeCount,0) < 100
				--and ((@IsAfterSchool = 0 and [User].AfterSchool in (1,0) )
				--		OR  (@IsAfterSchool = 1 and [User].AfterSchool = @IsAfterScho
			) x
			left join City C on x.CityHeaderID = C.CityHeaderID and C.LanguageCode = 'en-US'
			where (@CityID = 0 OR c.CityID in (select CityID from @CityIds ) )
			group by x.UserID,FirstName, LastName, isnull(C.CityName,'') +  '<br/>'  + isnull(x.CountryName,'') , Avatar, LastLogin, x.MessageCount, cityid, Gender , UserName
		) temp
		LEFT JOIN [User] U on U.UserID = temp.UserID
		ORDER BY newid(),temp.LastLogin desc	

		INSERT INTO @TempUser
		select top (@Temptop) temp.*, ISNULL(U.StatusText ,'') StatusText
		from
		(
			select  x.UserID,FirstName, LastName, IsNull(C.CityName,'') + '<br/>' + isnull(x.CountryName,'') as [Address], Avatar, LastLogin, x.MessageCount, CityID , Gender , UserName
			from 
			(
			SELECT  [user].UserID,FirstName, LastName, [User].[Address], Avatar, LastLogin, City.CityHeaderID, Country.CountryName, UM.MessageCount, Gender , [user].UserName
				FROM [User]  
				left JOIN @UserMessage UM on [user].UserID = UM.UserID
				left JOIN UserInterest ON  [user].UserID = UserInterest.UserID
				left JOIN Country on [User].CountryID = Country.CountryID 
				left JOIN City ON [User].CityID = City.CityID
				inner join SchoolInfo S on [User].SchoolID = S.SchoolID 
				WHERE ([User].IsOnline = 1 OR (not Exists( select 1 from @Interest ) OR UserInterest.InterestID IN  (
					SELECT InterestID FROM @Interest
				)) )
				AND (not Exists( select 1 from @GenderTable ) OR [user].Gender IN  ( SELECT Name FROM @GenderTable))
				AND [User].UserID <> @SearcheeID 
				and [user].UserTypeID in (@UserTypeID)
				AND ( (@AllowSameCountry = 1 AND [user].UserTypeID in (@UserTypeID) ) OR [User].CountryID <> @CountryID ) 
				AND ([User].LevelID in (@LevelID)  OR ( [User].IsRobot = 1 AND [User].LevelID = 4 ))--primary and secondary only
				AND (charindex('@', @Name) > 0 OR ([User].IsActive = 1 
				AND (([User].LastLogin is not null AND Datediff(day,[User].LastLogin, getdate()) <= 1000))) OR [User].IsRobot = 1 )
				AND (isnull(@Name,'') = '' or ([User].UserName like '%' + @Name + '%' or [User].FirstName like '%' + @Name + '%'))
				AND (isnull([User].IsDemo,0) = @IsDemo ) 
				and isnull([User].IsRobot,0) = @SchoolTypeDemo
				--and ((@IsAfterSchool = 0 and [User].AfterSchool in (1,0) )
				--		OR  (@IsAfterSchool = 1 and [User].AfterSchool = @IsAfterSchool ))
				and isnull(s.SchoolKey,0) = 1
				AND ISNULL(UM.MessageCount,0) > 0
			) x
			left join City C on x.CityHeaderID = C.CityHeaderID and C.LanguageCode = 'en-US'
			where (@CityID = 0 OR c.CityID in (select CityID from @CityIds ) )
			group by x.UserID,FirstName, LastName, isnull(C.CityName,'') +  '<br/>'  + isnull(x.CountryName,'') , Avatar, LastLogin, x.MessageCount, cityid, Gender , UserName
		) temp
		LEFT JOIN [User] U on U.UserID = temp.UserID
		ORDER BY newid(),temp.LastLogin desc	

	END
	ELSE
	BEGIN
		INSERT INTO @TempUserZero
		select top (@Top) temp.*, ISNULL(U.StatusText ,'') StatusText
		from
		(
			select  x.UserID,FirstName, LastName, IsNull(C.CityName,'') +  '<br/>'  + isnull(x.CountryName,'') as [Address], Avatar, LastLogin, x.MessageCount, CityID , Gender , UserName
			from 
			(
				SELECT  [user].UserID,FirstName, LastName, [User].[Address], Avatar, LastLogin, City.CityHeaderID, Country.CountryName, UM.MessageCount, Gender , [user].UserName
				FROM [User]  
				left JOIN @UserMessage UM on [user].UserID = UM.UserID
				left JOIN UserInterest ON  [user].UserID = UserInterest.UserID
				left JOIN Country on [User].CountryID = Country.CountryID 
				left JOIN City ON [User].CityID = City.CityID
				left join SchoolInfo S on [User].SchoolID = S.SchoolID 
				WHERE ([User].IsOnline = 1 OR (not Exists( select 1 from @Interest ) OR UserInterest.InterestID IN  (
					SELECT InterestID FROM @Interest
				)) )
				AND (not Exists( select 1 from @GenderTable ) OR [user].Gender IN  ( SELECT Name FROM @GenderTable))
				AND [User].UserID <> @SearcheeID 
				and [user].UserTypeID in (@UserTypeID)
				AND ( (@AllowSameCountry = 1 AND [user].UserTypeID in (@UserTypeID) ) OR [User].CountryID <> @CountryID ) 
				AND ([User].LevelID in (1,2,6, @LevelID)  OR ( [User].IsRobot = 1 AND [User].LevelID = 4 ))--primary and secondary only
				AND (charindex('@', @Name) > 0 OR ([User].IsActive = 1 
				AND (([User].LastLogin is not null AND Datediff(day,[User].LastLogin, getdate()) <= 1000)))
					OR [User].IsRobot = 1 ) 
				AND (isnull(@Name,'') = '' or ([User].UserName like '%' + @Name + '%' or [User].FirstName like '%' + @Name + '%'))
				AND (isnull([User].IsDemo,0) = @IsDemo ) 
				and isnull([User].IsRobot,0) = @SchoolTypeDemo
				and isnull(s.SchoolKey,0) = 1
				AND ISNULL(UM.MessageCount,0) = 0

				union all

				SELECT  [user].UserID,FirstName, LastName, [User].[Address], Avatar, LastLogin, City.CityHeaderID, Country.CountryName, UM.MessageCount, Gender , [user].UserName
				FROM [User]  
				left JOIN @UserMessage UM on [user].UserID = UM.UserID
				left JOIN UserInterest ON  [user].UserID = UserInterest.UserID
				left JOIN Country on [User].CountryID = Country.CountryID 
				left JOIN City ON [User].CityID = City.CityID
				left join SchoolInfo S on [User].SchoolID = S.SchoolID 
				WHERE ([User].IsOnline = 1 OR (not Exists( select 1 from @Interest ) OR UserInterest.InterestID IN  (
					SELECT InterestID FROM @Interest
				)) )
				AND (not Exists( select 1 from @GenderTable ) OR [user].Gender IN  ( SELECT Name FROM @GenderTable))
				AND [User].UserID <> @SearcheeID 
				and [user].UserTypeID in (@UserTypeID)
				AND ( (@AllowSameCountry = 1 AND [user].UserTypeID in (@UserTypeID) ) OR [User].CountryID <> @CountryID ) 
				AND ([User].LevelID in (1,2,6, @LevelID)  OR ( [User].IsRobot = 1 AND [User].LevelID = 4 ))--primary and secondary only
				AND (charindex('@', @Name) > 0 OR ([User].IsActive = 1 
				AND (([User].LastLogin is not null AND Datediff(day,[User].LastLogin, getdate()) <= 1000)))
					OR [User].IsRobot = 1 ) 
				AND (isnull(@Name,'') = '' or ([User].UserName like '%' + @Name + '%' or [User].FirstName like '%' + @Name + '%'))
				AND (isnull([User].IsDemo,0) = @IsDemo ) 
				and isnull([User].IsRobot,0) = @SchoolTypeDemo
				and isnull(s.SchoolKey,0) = 1
				AND ISNULL(UM.LikeCount,0) < 100

			) x
			left join City C on x.CityHeaderID = C.CityHeaderID and C.LanguageCode = 'en-US'
			where (@CityID = 0 OR c.CityID in (select CityID from @CityIds ) )
			group by x.UserID,FirstName, LastName, isnull(C.CityName,'') +  '<br/>'  + isnull(x.CountryName,'') , Avatar, LastLogin, x.MessageCount, cityid, Gender , UserName
		) temp
		LEFT JOIN [User] U on U.UserID = temp.UserID
		--where ((@IsAfterSchool = 0 and U.AfterSchool in (1,0) )
		--				OR  (@IsAfterSchool = 1 and U.AfterSchool = @IsAfterSchool ))
		ORDER BY newid(),temp.LastLogin desc

		INSERT INTO @TempUser
		select top (@Temptop) temp.*, ISNULL(U.StatusText ,'') StatusText
		from
		(
			select  x.UserID,FirstName, LastName, IsNull(C.CityName,'') +  '<br/>'  + isnull(x.CountryName,'') as [Address], Avatar, LastLogin, x.MessageCount, CityID , Gender , UserName
			from 
			(
			SELECT  [user].UserID,FirstName, LastName, [User].[Address], Avatar, LastLogin, City.CityHeaderID, Country.CountryName, UM.MessageCount, Gender , [user].UserName
				FROM [User]  
				left JOIN @UserMessage UM on [user].UserID = UM.UserID
				left JOIN UserInterest ON  [user].UserID = UserInterest.UserID
				left JOIN Country on [User].CountryID = Country.CountryID 
				left JOIN City ON [User].CityID = City.CityID
				left join SchoolInfo S on [User].SchoolID = S.SchoolID 
				WHERE ([User].IsOnline = 1 OR (not Exists( select 1 from @Interest ) OR UserInterest.InterestID IN  (
					SELECT InterestID FROM @Interest
				)) )
				AND (not Exists( select 1 from @GenderTable ) OR [user].Gender IN  ( SELECT Name FROM @GenderTable))
				AND [User].UserID <> @SearcheeID 
				and [user].UserTypeID in (@UserTypeID)
				AND ( (@AllowSameCountry = 1 AND [user].UserTypeID in (@UserTypeID) ) OR [User].CountryID <> @CountryID ) 
				AND ([User].LevelID in (1,2,6, @LevelID)  OR ( [User].IsRobot = 1 AND [User].LevelID = 4 ))--primary and secondary only
				AND (charindex('@', @Name) > 0 OR ([User].IsActive = 1 
				AND (([User].LastLogin is not null AND Datediff(day,[User].LastLogin, getdate()) <= 100)))
					OR [User].IsRobot = 1 ) 
				AND (isnull(@Name,'') = '' or ([User].UserName like '%' + @Name + '%' or [User].FirstName like '%' + @Name + '%'))
				AND (isnull([User].IsDemo,0) = @IsDemo ) 
				and isnull([User].IsRobot,0) = @SchoolTypeDemo
				and isnull(s.SchoolKey,0) = 1
				AND ISNULL(UM.MessageCount,0) > 0
			
			) x
			left join City C on x.CityHeaderID = C.CityHeaderID and C.LanguageCode = 'en-US'
			where (@CityID = 0 OR c.CityID in (select CityID from @CityIds ) )
			group by x.UserID,FirstName, LastName, isnull(C.CityName,'') +  '<br/>'  + isnull(x.CountryName,'') , Avatar, LastLogin, x.MessageCount, cityid, Gender , UserName
		) temp
		LEFT JOIN [User] U on U.UserID = temp.UserID
		--where ((@IsAfterSchool = 0 and U.AfterSchool in (1,0) )
		--				OR  (@IsAfterSchool = 1 and U.AfterSchool = @IsAfterSchool ))
		ORDER BY newid(),temp.LastLogin desc
	END

	--INSERT INTO @TempUserDate 
	--SELECT LastLogin, LastLogin FROM @TempUser

	--SELECT  TOP (@Top) U.* 
	--FROM @TempUserZero U

	--UNION ALL
		
	--SELECT  TOP (@Top) U.* 
	--FROM @TempUser U
	--INNER JOIN ( select LastLogin2, Max(LastLogin) LastLogin from @TempUserDate
	--			group by LastLogin2 ) X ON x.LastLogin = U.LastLogin
	--ORDER BY MessageCount ASC


			
	;WITH CTE (UserID,FirstName, LastName, [Address], Avatar, LastLogin, MessageCount, CityID , Gender , UserName, StatusText, DuplicateCount, ShouldIncreaseNativeUsersList)
	AS
	(
	  SELECT UserID,FirstName, LastName, [Address], Avatar, LastLogin, MessageCount, CityID , Gender , UserName, StatusText,
	  ROW_NUMBER() OVER(PARTITION BY UserID,FirstName, LastName, [Address], Avatar, LastLogin, MessageCount, CityID , Gender , UserName, StatusText
		   ORDER BY UserID) AS DuplicateCount, @ShouldIncreaseNativeUsersList as ShouldIncreaseNativeUsersList
	  FROM @TempUser
	) SELECT * from CTE Where DuplicateCount = 1

	UNION ALL

	SELECT  TOP (@Top) U.*, 0 , @ShouldIncreaseNativeUsersList ShouldIncreaseNativeUsersList
	FROM @TempUserZero U

end


