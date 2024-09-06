ALTER TABLE SchoolInfo
ADD ShowRomanji bit default(0),
	EnabledFreeMessage bit default(0)

ALTER TABLE [User]
ADD EnabledFreeMessage bit default(0)