USE [Palaygo.11222018]
GO
/****** Object:  StoredProcedure [dbo].[usp_GetMailExchangeLog]    Script Date: 5/13/2020 9:01:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure [dbo].[usp_GetMailExchangeLog]
	@SchoolID int = 0,
	@Sender nvarchar(100) = null,
	@Recipient nvarchar(100) = null,
	@StartDate datetime = null,
	@EndDate datetime =null
as
begin

SELECT distinct * FROM
(
	
	SELECT UM.*, US.UserName as Sender, UR.FirstName + '@' + SR.SchoolCode Recepient, S.Name1, S.Name2
	FROM UserMessage UM with(nolock)
	INNER JOIN [User] US on UM.SenderID = US.UserID
	INNER JOIN [User] UR on UM.RecepientID= UR.UserID
	INNER JOIN SchoolInfo S on US.SchoolID = S.SchoolID
	INNER JOIN SchoolInfo SR on UR.SchoolID = SR.SchoolID
	WHERE (@SchoolID = 0 OR S.SchoolID = @SchoolID)
	AND (ISNULL(@Sender,'') = '' or US.UserName + US.FirstName + US.LastName LIKE '%' + @Sender + '%'  ) 
	AND  (ISNULL(@Recipient,'') = '' or UR.UserName + UR.FirstName + UR.LastName LIKE '%' + @Recipient + '%'  )
--	AND ((@StartDate IS NULL OR @EndDate IS NULL) or UM.CreateDate BETWEEN @StartDate AND @EndDate)
	AND ((@StartDate IS NULL OR @EndDate IS NULL) or UM.CreateDate BETWEEN @StartDate AND convert(varchar(10),@EndDate, 101) + ' 23:59:59')
	AND UM.IsActive = 1
	AND ISNULL(UM.SentFromPool,0) = 0
	AND Year(UM.CreateDate) = Year(getdate())
	UNION ALL
	
	SELECT UM.*, US.UserName as Sender, UR.FirstName + '@' + SR.SchoolCode Recepient, SR.Name1, SR.Name2
	FROM UserMessage UM with(nolock)
	INNER JOIN [User] US on UM.SenderID = US.UserID
	INNER JOIN [User] UR on UM.RecepientID= UR.UserID
	INNER JOIN SchoolInfo S on US.SchoolID = S.SchoolID
	INNER JOIN SchoolInfo SR on UR.SchoolID = SR.SchoolID
	WHERE (@SchoolID = 0 OR SR.SchoolID = @SchoolID)
	AND (ISNULL(@Sender,'') = '' or US.UserName + US.FirstName + US.LastName LIKE '%' + @Sender + '%'  ) 
	AND  (ISNULL(@Recipient,'') = '' or UR.UserName + UR.FirstName + UR.LastName LIKE '%' + @Recipient + '%'  )
	--AND ((@StartDate IS NULL OR @EndDate IS NULL) or UM.CreateDate BETWEEN @StartDate AND @EndDate)
	AND ((@StartDate IS NULL OR @EndDate IS NULL) or UM.CreateDate BETWEEN @StartDate AND convert(varchar(10),@EndDate, 101) + ' 23:59:59')
	AND UM.IsActive = 1
	AND ISNULL(UM.SentFromPool,0) = 0
	AND Year(UM.CreateDate) = Year(getdate())
) temp
order by temp.CreateDate
	

end




