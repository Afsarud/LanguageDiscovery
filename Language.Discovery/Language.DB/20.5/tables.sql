alter table ConferenceRoom
add CalleSchoolId int default(null),
    CallerSchoolId int default(null)

alter table UserMessage
add SentFromPool bit default(0)

alter table [User]
ADD DontShowQuickGuide bit default(0)

/****** Object:  Table [dbo].[NewUserRegistration]    Script Date: 5/22/2020 8:40:05 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[NewUserRegistration](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [nvarchar](50) NOT NULL,
	[LastName] [nvarchar](50) NOT NULL,
	[Email] [nvarchar](50) NOT NULL,
	[SchoolName] [nvarchar](50) NOT NULL,
	[Gender] [nvarchar](10) NOT NULL,
	[Telephone] [nvarchar](20) NULL,
	[CreateDate] [datetime] NOT NULL,
	[ObjectID] [nvarchar](50) NOT NULL,
	[ExpiryDate] [datetime] NOT NULL,
	[IsRegistered] [bit] NOT NULL,
	[RegistrationDate] [datetime] NULL,
 CONSTRAINT [PK_NewUserRegistration] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[NewUserRegistration] ADD  CONSTRAINT [DF_NewUserRegistration_IsUsed]  DEFAULT ((0)) FOR [IsRegistered]
GO

