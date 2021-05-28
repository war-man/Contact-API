CREATE DATABASE ContactAPP;

use ContactAPP;

CREATE TABLE Contacts (
    ContactId INT PRIMARY KEY IDENTITY (1, 1),
    FirstName VARCHAR (15) NOT NULL,
    LastName VARCHAR (15) NOT NULL,
    Phone VARCHAR(20) NOT NULL,
    Email VARCHAR(20),
	IsFavorite BIT DEFAULT 0,
	IsDeleted BIT DEFAULT 0
);
CREATE TABLE Users (
  Id int PRIMARY KEY IDENTITY (1, 1),
  Username varchar(200) NOT NULL,
  Password varchar(200) NOT NULL,
  Email varchar(200) NOT NULL,
)