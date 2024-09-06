ALTER TABLE SchoolInfo
ADD SoundAndMail bit DEFAULT(0)

ALTER TABLE [User]
ADD SoundAndMail bit DEFAULT(0)

UPDATE SchoolInfo SET SoundAndMail = 1
UPDATE [User] SET SoundAndMail = 1

ALTER TABLE UserMessage
ADD IsAutoMail bit default(0)
UPDATE UserMessage SET IsAutoMail = 0