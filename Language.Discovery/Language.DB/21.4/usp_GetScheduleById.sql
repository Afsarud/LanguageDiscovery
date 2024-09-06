CREATE PROCEDURE usp_GetMatchByScheduleId
	@Id int
AS
BEGIN
	SELECT S.ScheduleId, S.UserId, U.FirstName [Name], S.PartnerId, P.FirstName PartnerName, 
		U.GradeID Grade, U.Gender, P.Gender PartnerGender, P.GradeID PartnerGrade,
		C.CountryCode Country, PC.CountryCode PartnerCountry, S.Schedule, u.UserName, u.[Password],
		P.UserName PartnerUserName, P.[Password] PartnerPassword
	FROM Schedule S
	inner JOIN [User] U ON S.UserId = U.UserID
	inner join Country C on U.CountryID = C.CountryID
	left join [User] P ON S.PartnerId = P.UserID
	left join Country PC on P.CountryID = PC.CountryID
	WHERE ScheduleId = @Id

END