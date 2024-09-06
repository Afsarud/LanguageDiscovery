ALTER PROCEDURE [dbo].[usp_InsertInfo]
	@InfoMessage nvarchar(max)
   ,@InfoType nvarchar(10)
   ,@ImageFile nvarchar(100) = null
   ,@ID int output
as
begin

UPDATE [Info]
SET [IsActive] = 0
WHERE [InfoType] = @InfoType
   
INSERT INTO [Info] ([InfoMessage],[InfoType],[IsActive], ImageFile)
VALUES (@InfoMessage,@InfoType,1, @ImageFile)
      
 SET @ID = SCOPE_IDENTITY()
end



