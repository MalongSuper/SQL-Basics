USE Library;
GO

ALTER TABLE Book
ADD CONSTRAINT fk_BookCol FOREIGN KEY (BookCol) REFERENCES BookCollection(BookColId);
GO

ALTER TABLE Borrowed
ADD CONSTRAINT fk_Reader FOREIGN KEY (Reader) REFERENCES Reader(ReaderId);
GO

ALTER TABLE Borrowed
ADD CONSTRAINT fk_BorrowedBook FOREIGN KEY (BorrowedBook) REFERENCES Book(BookNumber);
GO


