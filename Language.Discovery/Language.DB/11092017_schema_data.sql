
alter table topcategoryheader
add IsTalk bit

alter table PhraseCategoryHeader
add IsDefault bit default(0)


update PhraseCategoryHeader set IsDefault = 0

update TopCategoryHeader set IsTalk = 0

INSERT INTO TopCategoryHeader values(getdate(), 0,1,1)


INSERT INTO TopCategory values (6, N'Talk', 'en-US'),
		(6,N'トーク', 'ja-JP'),
		(6,N'谈论', 'zh-CN')


declare @id as bigint
insert into PhraseCategoryHeader values ( getdate(), 9,0,0, null, null, 38,'',0,0,6,1 )
set @id = SCOPE_IDENTITY()
insert into PhraseCategory values (@id, 'en-US','Talk',null, null, null, null, null),
				(@id, 'ja-JP',N'トーク',null, null, null, null, null),
				(@id, 'zh-CN',N'谈论',null, null, null, null, null)