--lisa@bb123au
--kay@bb123au
--frank@sh123cn

INSERT INTO Country 
values ('CH','China', 'china.png')

INSERT INTO [Language] 
values ( 'zh-CN', 'Chinese', 'zh-PN', 'zn-X', 3)

alter table Word
alter column LanguageCode nvarchar(20) null

alter table PhraseCategory
alter column LanguageCode nvarchar(10) null

alter table UserMessage
add [NativeLanguageMessageRecepient] nvarchar(max) null,
[LearningLanguageMessageRecepient] nvarchar(max) null

insert into TopCategory values (1, '开始', 'zh-CN' ),(2, '主文本', 'zh-CN' ), (3, '结束', 'zh-CN' )

ALTER TABLE SchoolInfo
Add NativeLanguage nvarchar(10),
	LearningLanguage nvarchar(10)

Update SchoolInfo set NativeLanguage = l.LanguageCode, 
	LearningLanguage = case when s.CountryID = 1 THEN 'ja-JP' 
							when s.CountryID = 2 THEN 'en-US'
							when s.CountryID = 3 THEN 'en-US'
FROM SchoolInfo S
INNER JOIN [Language] l ON S.CountryID = l.CountryID 
WHERE

---------City





declare @cityheaderid as int

insert into CityHeader values ( GETDATE() )
set @cityheaderid = SCOPE_IDENTITY()
Insert into City values ( @cityheaderid, 'Beijing','en-US',3 )
Insert into City values ( @cityheaderid, N'北京','zh-CN',3 )

insert into CityHeader values ( GETDATE() )
set @cityheaderid = SCOPE_IDENTITY()
Insert into City values ( @cityheaderid, 'Shanghai','en-US',3 )
Insert into City values ( @cityheaderid, N'上海','zh-CN',3 )

insert into CityHeader values ( GETDATE() )
set @cityheaderid = SCOPE_IDENTITY()
Insert into City values ( @cityheaderid, 'Hong Kong','en-US',3 )
Insert into City values ( @cityheaderid, N'香港','zh-CN',3 )

insert into CityHeader values ( GETDATE() )
set @cityheaderid = SCOPE_IDENTITY()
Insert into City values ( @cityheaderid, 'Nanjing','en-US',3 )
Insert into City values ( @cityheaderid, N'南京','zh-CN',3 )

insert into CityHeader values ( GETDATE() )
set @cityheaderid = SCOPE_IDENTITY()
Insert into City values ( @cityheaderid, 'Hangzhou','en-US',3 )
Insert into City values ( @cityheaderid, N'杭州','zh-CN',3 )

insert into CityHeader values ( GETDATE() )
set @cityheaderid = SCOPE_IDENTITY()
Insert into City values ( @cityheaderid, 'Xi’an','en-US',3 )
Insert into City values ( @cityheaderid, N'西安','zh-CN',3 )

insert into CityHeader values ( GETDATE() )
set @cityheaderid = SCOPE_IDENTITY()
Insert into City values ( @cityheaderid, 'Tianjin','en-US',3 )
Insert into City values ( @cityheaderid, N'天津','zh-CN',3 )

--end City

--About me

INSERT INTO AboutMe 
 values( 1, N'我有兄弟。', 'zh-CN')
,( 2, N'我有姐妹。', 'zh-CN')
,( 3, N'我有兄弟姐妹。', 'zh-CN')
,( 4, N'我有宠物。', 'zh-CN')
,( 5, N'我喜欢动物。', 'zh-CN')
,( 6, N'我喜欢运动。', 'zh-CN')
,( 7, N'我喜欢音乐。', 'zh-CN')
,( 8, N'我喜欢的游戏。', 'zh-CN')
,( 9, N'我喜欢看电影。', 'zh-CN')
,( 10, N'我玩乐器。', 'zh-CN')
,( 11, N'我已经出国。', 'zh-CN')
,( 12, N'我好好教训。', 'zh-CN')
,( 13, N'我感兴趣的是外语。', 'zh-CN')
,( 14, N'我喜欢读书。', 'zh-CN')
,( 15, N'我喜欢甜食。', 'zh-CN')
,( 16, N'我有我喜欢的一些特定的字符。', 'zh-CN')
,( 17, N'我喜欢的水果。', 'zh-CN')
--end about me

--Interest

INSERT INTO Interest 
VALUES ( 2, N'运动','zh-CN')
,( 3, N'音乐','zh-CN')
,( 4, N'游戏','zh-CN')
,( 5, N'动物','zh-CN')
,( 6, N'动漫','zh-CN')
,( 7, N'餐饮','zh-CN')


--end interest
