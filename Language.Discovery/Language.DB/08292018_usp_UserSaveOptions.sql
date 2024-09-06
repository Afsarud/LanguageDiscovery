SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure [dbo].[usp_UserSaveOptions]
	@UserID bigint,
	@SequenceOptionFlag bit = 0,
	@NativeOptionFlag bit = 0, 
	@SubLanguageOptionFlag bit = 0,
	@SubLanguage2OptionFlag bit = 0,
	@SoundAndMail bit = 0
as
begin

	UPDATE [User] 
	set SequenceOptionFlag = @SequenceOptionFlag,
		NativeOptionFlag = @NativeOptionFlag,
		SubLanguageOptionFlag = @SubLanguageOptionFlag,
		SubLanguage2OptionFlag = @SubLanguage2OptionFlag,
		SoundAndMail = @SoundAndMail,
		IsOptionUpdated = 1
	WHERE UserID = @UserID 
	
end
