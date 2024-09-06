USE [Palaygo_04242021]
GO
/****** Object:  StoredProcedure [dbo].[usp_GetMatchByScheduleId]    Script Date: 4/27/2022 12:24:08 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[usp_GetMatchByScheduleId]
	@Id int
AS
BEGIN

	SELECT S.ScheduleId, S.UserId, U.FirstName [Name], S.PartnerId, P.FirstName PartnerName, 
		U.GradeID Grade, U.Gender, P.Gender PartnerGender, P.GradeID PartnerGrade,
		C.CountryCode Country, PC.CountryCode PartnerCountry, S.Schedule, u.UserName, u.[Password],
		P.UserName PartnerUserName, P.[Password] PartnerPassword, U.LinkKey UserLinkKey, P.LinkKey PartnerLinkKey, 
		S.UserConfirmationToken, S.IsUserConfirmed, S.UserConfirmationDateTime, S.PartnerConfirmationToken, S.IsPartnerConfirmed, S.PartnerConfirmationDateTime,
		PCC.PhraseCategoryCode UserTopic, PCCP.PhraseCategoryCode PartnerTopic
	FROM Schedule S
	inner JOIN [User] U ON S.UserId = U.UserID
	inner join Country C on U.CountryID = C.CountryID
	left join [User] P ON S.PartnerId = P.UserID
	left join Country PC on P.CountryID = PC.CountryID
	left join PhraseCategory PCC on PCC.PhraseCategoryID = S.PhraseCategoryID
	left join PhraseCategory PCCP on PCCP.PhraseCategoryID= S.PartnerPhraseCategoryID
	WHERE ScheduleId = @Id

END
