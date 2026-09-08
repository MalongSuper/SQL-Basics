USE Library;
GO

-- Primary Key & Foreign Key
ALTER TABLE BookCollection
ADD CONSTRAINT pk_BookColId PRIMARY KEY (BookColId);
GO

ALTER TABLE Book
ADD CONSTRAINT pk_BookNumber PRIMARY KEY (BookNumber);
GO

ALTER TABLE Reader 
ADD CONSTRAINT pk_ReaderId PRIMARY KEY (ReaderId);
GO

ALTER TABLE Borrowed
ADD CONSTRAINT pk_Reader_BorrowedBook PRIMARY KEY (Reader, BorrowedBook);
GO