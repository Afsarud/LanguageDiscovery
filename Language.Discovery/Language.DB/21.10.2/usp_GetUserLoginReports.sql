ALTER procedure [dbo].[usp_GetUserLoginReports]
	@UserName nvarchar(50) = null,
	@SchoolID int = 0,
	@Sort nvarchar(50) = null,
	@Order nvarchar(10) = 'A'
as
begin

	SELECT * FROM (
	SELECT U.*, temp.LoginCount, SI.Name1,SI.Name2
	FROM [User] U
	INNER JOIN SchoolInfo SI on U.SchoolID = SI.SchoolID OR U.SchoolID = 0
	INNER JOIN ( SELECT UserID, COUNT( LoginDate ) LoginCount 
				FROM UserLog GROUP BY UserID) temp on U.UserID = temp.UserID
	where (@SchoolID = 0 or U.SchoolID = @SchoolID) 
	AND (ISNULL(@UserName,'') = '' OR U.UserName+U.FirstName+U.LastName like '%' + @UserName + '%' )
	AND U.UserTypeID  in (2, 3) 

	union all

	SELECT U.*, temp.LoginCount, '' Name1, '' Name2
	FROM [User] U
	INNER JOIN ( SELECT UserID, COUNT( LoginDate ) LoginCount 
				FROM UserLog GROUP BY UserID) temp on U.UserID = temp.UserID
	where (ISNULL(@UserName,'') = '' OR U.UserName+U.FirstName+U.LastName like '%' + @UserName + '%' )
	AND U.UserTypeID  = 1
	) U
	ORDER BY 
				case when @Sort = 'UserName' AND @Order = 'A' then U.UserName  End ASc, 
				CASe when @Sort = 'School' AND @Order = 'A' then U.Name1 END ASc,
				case when @Sort = 'UserName' AND @Order = 'D' then U.UserName  End desc, 
				CASe when @Sort = 'School' AND @Order = 'D' then U.Name1 END desc
	
	
end