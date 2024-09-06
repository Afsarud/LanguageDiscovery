CREATE PROCEDURE [dbo].[usp_UpdateSchoolTotalTime]
 @ID int,
 @TotalTime int 
as
BEGIN

	UPDATE SchoolInfo SET TalkTime = @TotalTime WHERE SchoolID = @ID

END


