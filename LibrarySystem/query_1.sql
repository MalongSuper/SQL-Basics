CREATE DATABASE Library;
GO

USE Library;
GO

CREATE TABLE BookCollection (
  BookColId VARCHAR(10) NOT NULL,
  Title VARCHAR(100),
  PublishedYear INT,
  Summary VARCHAR(100),
  Author VARCHAR(100),
  Publisher VARCHAR(50),
  Pages INT
);
GO

CREATE TABLE Book (
  BookNumber INT NOT NULL,
  Status TINYINT CHECK(Status IN (0, 1)),
  ImportDate DATE,
  BookCol VARCHAR(10),
  InputPrice NUMERIC(6, 0)
);
GO

CREATE TABLE Reader (
  ReaderId VARCHAR(6) NOT NULL,
  Fname VARCHAR(100),
  Lname VARCHAR(25),
  BDate DATE,
  Email VARCHAR(100),
  PhoneNumber VARCHAR(10)
);
GO

CREATE TABLE Borrowed (
  Reader VARCHAR(6) NOT NULL,
  BorrowedBook INT NOT NULL,
  BorrowedDate DATE,
  ReturnDate DATE,
  DueDate TINYINT
);
GO

