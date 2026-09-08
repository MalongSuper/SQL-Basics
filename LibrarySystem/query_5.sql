USE Library;
GO

ALTER TABLE Reader
ADD CONSTRAINT chk_ReaderId CHECK(ReaderId LIKE 'GV_[0-9][0-9][0-9]' OR (ReaderId LIKE 'SV_[0-9][0-9][0-9]'));
GO

ALTER TABLE Borrowed
ADD CONSTRAINT chk_Borrowed_ReturnDate CHECK(ReturnDate >= BorrowedDate);
GO

ALTER TABLE BookCollection
ADD CONSTRAINT chk_Pages CHECK(Pages >= 10);
GO


ALTER TABLE Book
ADD CONSTRAINT chk_InputPrice CHECK(InputPrice IS NULL OR InputPrice > 0);
GO

ALTER TABLE Borrowed
ADD CONSTRAINT chk_Reader CHECK((Reader LIKE 'GV%' AND DueDate = 60) OR (Reader LIKE 'SV%' AND DueDate = 30));
GO