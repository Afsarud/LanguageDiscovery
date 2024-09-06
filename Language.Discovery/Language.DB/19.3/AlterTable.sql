ALTER TABLE WordHeader
add UserCreatedWord bit default(0)

ALTER TABLE UserMessage
alter column Keyword nvarchar(max)