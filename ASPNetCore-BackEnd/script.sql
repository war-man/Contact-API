USE [ContactAPP]
GO
/****** Object:  User [IIS APPPOOL\apicontact]    Script Date: 5/28/2021 2:06:21 PM ******/
CREATE USER [IIS APPPOOL\apicontact] FOR LOGIN [IIS APPPOOL\apicontact] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  Table [dbo].[Contacts]    Script Date: 5/28/2021 2:06:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Contacts](
	[ContactId] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [varchar](15) NOT NULL,
	[LastName] [varchar](15) NOT NULL,
	[Phone] [varchar](20) NOT NULL,
	[Email] [varchar](20) NULL,
	[IsFavorite] [bit] NULL,
	[IsDeleted] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[ContactId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 5/28/2021 2:06:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Username] [varchar](200) NOT NULL,
	[Password] [varchar](200) NOT NULL,
	[Email] [varchar](200) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Contacts] ON 

INSERT [dbo].[Contacts] ([ContactId], [FirstName], [LastName], [Phone], [Email], [IsFavorite], [IsDeleted]) VALUES (1, N'abcd', N'abd', N'938751116', N'a@gmail.com', 1, 0)
INSERT [dbo].[Contacts] ([ContactId], [FirstName], [LastName], [Phone], [Email], [IsFavorite], [IsDeleted]) VALUES (2, N'dkfaskfafna', N'fasfsakfbabf', N'975123456', N'a@gmail.com', 0, 0)
INSERT [dbo].[Contacts] ([ContactId], [FirstName], [LastName], [Phone], [Email], [IsFavorite], [IsDeleted]) VALUES (3, N'fafafa', N'rwqrwqrq', N'938751116', N'a@gmail.com', 0, 0)
INSERT [dbo].[Contacts] ([ContactId], [FirstName], [LastName], [Phone], [Email], [IsFavorite], [IsDeleted]) VALUES (4, N'dasdasda', N'asafs', N'109955', N'a@gmail.com', 0, 1)
INSERT [dbo].[Contacts] ([ContactId], [FirstName], [LastName], [Phone], [Email], [IsFavorite], [IsDeleted]) VALUES (5, N'ryyyvnnj', N'cnnnvvb', N'938751116', N'as@gmail.com', 0, 1)
INSERT [dbo].[Contacts] ([ContactId], [FirstName], [LastName], [Phone], [Email], [IsFavorite], [IsDeleted]) VALUES (6, N'rrttt', N'ffjj', N'258074136', N'a@gmail.com', 0, 0)
SET IDENTITY_INSERT [dbo].[Contacts] OFF
GO
SET IDENTITY_INSERT [dbo].[Users] ON 

INSERT [dbo].[Users] ([Id], [Username], [Password], [Email]) VALUES (1, N'abc', N'123456', N'a@gmail.com')
SET IDENTITY_INSERT [dbo].[Users] OFF
GO
ALTER TABLE [dbo].[Contacts] ADD  DEFAULT ((0)) FOR [IsFavorite]
GO
ALTER TABLE [dbo].[Contacts] ADD  DEFAULT ((0)) FOR [IsDeleted]
GO
