alter table ConferenceRoom
add RoomKey nvarchar(20)

alter table schoolinfo
add EnableParentInfo bit default(0)


declare @id int
insert into TopCategoryHeader values( getdate() , 0,0,0,0,0)

SET @id = SCOPE_IDENTITY()
INSERT INTO TopCategory values (@id, 'My Room', 'en-US'), (@id, N'マイルーム', 'ja-JP'), (@id, N'マイルーム', 'zh-CN')