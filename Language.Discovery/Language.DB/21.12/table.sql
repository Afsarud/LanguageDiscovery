alter table Schedule
add UserConfirmationToken uniqueidentifier,
	IsUserConfirmed bit,
	PartnerConfirmationToken uniqueidentifier,
	IsPartnerConfirmed bit,
	UserConfirmationDateTime datetime,
	PartnerConfirmationDateTime datetime,
	Comment nvarchar(200),
	UserColor nvarchar(20),
	PartnerColor nvarchar(20)
