USE [Palaygo.11222018]
GO
/****** Object:  StoredProcedure [dbo].[usp_DeleteUserPalette]    Script Date: 9/9/2020 12:23:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[usp_DeleteUserPalette]
	@UserID bigint,
	@xml xml
AS
BEGIN

	DECLARE @UserPalette as table
	(
		UserID bigint,
		PaletteID bigint
	)

	DECLARE @UserSentence as table
	(
		SentenceID bigint
	)

	INSERT INTO @UserPalette
	SELECT @UserID,
			PX.value('(ID)[1]', 'bigint')
	FROM  @xml.nodes('UserPalettes/IDS') AS XD(PX)

	INSERT INTO @UserSentence
	SELECT [SentenceID] FROM [dbo].[MySentence] where PaletteID in (SELECT PaletteID from @UserPalette) and UserID = @UserID

	delete UserPalette where PaletteID in (select PaletteID from @UserPalette) and UserID = @UserID
	delete MyPalette where PaletteID in (select PaletteID from @UserPalette)  and UserID = @UserID
	delete MySentence where PaletteID in (select PaletteID from @UserPalette)  and UserID = @UserID	
	delete MyPhrase where SentenceID in (select SentenceID from @UserSentence)  and UserID = @UserID	

END
