ALTER procedure [dbo].[usp_SearchUserAdmin]
 @RowsPerPage INT = 10,
 @PageNumber as INT = 1,
 @FirstName nvarchar(50) = null,
 @LastName nvarchar(50) = null,
 @ClassID int = 0,
 @CountryID int = 0,
 @CityID int = 0,
 @SchoolID int = 0,
 @UserName nvarchar(50) = null,
 @VirtualCount as int output
as
begin

declare @tempuser as table
 (
  UserID int
 )
 
 ;WITH U AS 
 (
  SELECT Distinct U.UserID,  ROW_NUMBER() OVER (ORDER BY CreateDate desc) AS RowNum 
  FROM [User] U
  WHERE (@FirstName IS NULL OR U.FirstName LIKE '%' + @FirstName + '%')
  AND (@LastName IS NULL OR U.LastName LIKE '%' + @LastName + '%')
  AND (@UserName IS NULL OR U.UserName = @UserName )
  AND (@ClassID = 0 OR U.ClassID = @ClassID)
  AND (@CountryID = 0 OR U.CountryID = @CountryID)
  AND (@CityID = 0 OR U.CityID = @CityID)
  AND (@SchoolID = 0 OR U.SchoolID= @SchoolID)
 )
 INSERT INTO @tempuser
 SELECT UserID FROM u
 WHERE u.RowNum BETWEEN ((@PageNumber-1)*@RowsPerPage)+1
 AND @RowsPerPage*(@PageNumber)

 SELECT @VirtualCount = count(1) 
 FROM [User] U
  WHERE (@FirstName IS NULL OR U.FirstName LIKE '%' + @FirstName + '%')
  AND (@LastName IS NULL OR U.LastName LIKE '%' + @LastName + '%')
  AND (@UserName IS NULL OR U.UserName = @UserName )
  AND (@ClassID = 0 OR U.ClassID = @ClassID)
  AND (@CountryID = 0 OR U.CountryID = @CountryID)
  AND (@CityID = 0 OR U.CityID = @CityID)
  AND (@SchoolID = 0 OR U.SchoolID= @SchoolID)

 SELECT U.UserID, U.FirstName, U.LastName, Cl.ClassName, C.CountryName, Cy.CityName, SI.Name1, U.UserName, U.CreateDate, U.GradeID
 FROM [User] U 
 LEFT JOIN Class Cl ON U.ClassID = Cl.ClassID
 LEFT JOIN Country C ON U.CountryID = C.CountryID
 LEFT JOIN City Cy ON U.CityID = Cy.CityID
 LEFT JOIN SchoolInfo SI on U.SchoolID = SI.SchoolID
 WHERE U.UserID in ( select * FROM @tempuser  )
 Order By CreateDate desc
end


