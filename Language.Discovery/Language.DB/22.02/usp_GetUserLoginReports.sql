USE [Palaygo_UAT]
GO
/****** Object:  StoredProcedure [dbo].[usp_GetUserLoginReports]    Script Date: 2/8/2022 10:21:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure [dbo].[usp_GetUserLoginReports]
	@UserName nvarchar(50) = null,
	@SchoolID int = 0,
	@Sort nvarchar(50) = null,
	@Order nvarchar(10) = 'A',
	@StartDate datetime = null,
	@EndDate datetime = null
as
begin

	SELECT * FROM (
	SELECT distinct U.*, temp.LoginCount, SI.Name1,SI.Name2
	FROM [User] U
	INNER JOIN UserLog UL on U.UserID = UL.UserID
	INNER JOIN SchoolInfo SI on U.SchoolID = SI.SchoolID-- OR U.SchoolID = 0
	INNER JOIN ( SELECT UserID, COUNT( LoginDate ) LoginCount 
				FROM UserLog GROUP BY UserID) temp on U.UserID = temp.UserID
	where (@SchoolID = 0 or U.SchoolID = @SchoolID) 
	AND (ISNULL(@UserName,'') = '' OR U.UserName+U.FirstName+U.LastName like '%' + @UserName + '%' )
	AND ((@StartDate IS NULL OR @EndDate IS NULL) or UL.LoginDate BETWEEN @StartDate AND convert(varchar(10),@EndDate, 101) + ' 23:59:59')
	AND U.UserTypeID  in (2, 3) 

	union all

	SELECT distinct U.*, temp.LoginCount, '' Name1, '' Name2
	FROM [User] U
	INNER JOIN ( SELECT UserID, COUNT( LoginDate ) LoginCount 
				FROM UserLog GROUP BY UserID) temp on U.UserID = temp.UserID
	INNER JOIN UserLog UL on U.UserID = UL.UserID
	where (ISNULL(@UserName,'') = '' OR U.UserName+U.FirstName+U.LastName like '%' + @UserName + '%' )
	AND ((@StartDate IS NULL OR @EndDate IS NULL) or UL.LoginDate BETWEEN @StartDate AND convert(varchar(10),@EndDate, 101) + ' 23:59:59')
	AND U.UserTypeID  = 1
	) U
	ORDER BY 
				case when @Sort = 'UserName' AND @Order = 'A' then U.UserName  End ASc, 
				CASe when @Sort = 'School' AND @Order = 'A' then U.Name1 END ASc,
				case when @Sort = 'UserName' AND @Order = 'D' then U.UserName  End desc, 
				CASe when @Sort = 'School' AND @Order = 'D' then U.Name1 END desc
	
	
end