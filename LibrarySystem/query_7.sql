USE Library;
GO

-- a) Find the list of readers (reader ID, last name, first name) who are lecturers (IDs start with 'gv') and whose birthdate is not NULL.
CREATE VIEW [View_ReaderTeacher] AS
SELECT ReaderId, Lname, Fname FROM Reader WHERE ReaderId LIKE 'GV%' AND BDate IS NOT NULL;
GO

-- b) Find the book titles (book ID, title) authored by Diane Pye or Simon Greenall, published in 2010.
CREATE VIEW [View_BookCollectionAuthor] AS
SELECT BookColId, Title FROM BookCollection WHERE Author IN ('Diane Pye', 'Simon Greenall') AND PublishedYear = 2010;
GO

-- c) Find the list of books (book ID, purchase price, title ID, title) borrowed but overdue and not yet returned.
CREATE VIEW [View_NotReturnedBook] AS
SELECT bk.BookNumber AS BookNumber, bk.InputPrice AS InputPrice, 
bc.BookColId AS BookCol, bc.Title AS BookTitle FROM Borrowed br 
JOIN Book bk ON bk.BookNumber = br.BorrowedBook
JOIN BookCollection bc ON bc.BookColId = bk.BookCol
WHERE br.ReturnDate IS NULL AND DATEDIFF(DAY, br.BorrowedDate, GETDATE()) > br.DueDate;
GO


-- d) Count the number of readers who are lecturers and those who are students.
CREATE VIEW [View_TeachersStudents] AS
SELECT COUNT(CASE WHEN ReaderId LIKE 'GV%' THEN 1 ELSE NULL END) AS NumofTeachers,
COUNT(CASE WHEN ReaderId LIKE 'SV%' THEN 1 ELSE NULL END) AS NumofStudents
FROM Reader;
GO

-- e) How many times were books borrowed each month?
CREATE VIEW [View_BorrowedbyMonth] AS
SELECT DATEPART(year, BorrowedDate) AS Year, DATEPART(month, BorrowedDate) AS Month, COUNT(BorrowedBook) AS NumberofBorrowedBooks
FROM Borrowed GROUP BY DATEPART(year, BorrowedDate), DATEPART(month, BorrowedDate);
GO


-- f) Which readers (last name, first name) borrowed books with the title "Camb First Certificate in English 5 TB"?
CREATE VIEW [View_BorrowedEnglishBook] AS
SELECT r.Fname, r.Lname FROM Reader r 
JOIN Borrowed br ON r.ReaderId = br.Reader
JOIN Book bk ON bk.BookNumber = br.BorrowedBook
JOIN BookCollection bc ON bc.BookColId = bk.BookCol
WHERE bc.Title = 'Camb First Certificate in English 5 TB';
GO

-- g) Find the average purchase price of each book title.
CREATE VIEW [View_AveragePrice] AS
SELECT BookCol AS BookColId, AVG(InputPrice) AS AveragePrice FROM Book GROUP BY BookCol;
GO

-- h) Find readers and the total price they would pay if they haven't returned overdue books (based on purchase price).
CREATE VIEW [View_TotalPriceforNotReturnedBook] AS
SELECT r.Fname, r.Lname, SUM(InputPrice) AS TotalPrice FROM Reader r 
JOIN Borrowed br ON br.Reader = r.ReaderId
JOIN Book bk ON bk.BookNumber = br.BorrowedBook
WHERE br.ReturnDate IS NULL AND DATEDIFF(DAY, br.BorrowedDate, GETDATE()) > br.DueDate 
GROUP BY r.Fname, r.Lname;
GO

-- i) Find book titles (title ID, title) that have been borrowed more than 3 times.
CREATE VIEW [View_BookBorrowedNumberThree] AS
SELECT bc.BookColId, bc.Title, COUNT(br.BorrowedBook) AS BorrowedNumber FROM Borrowed br 
JOIN Book bk ON bk.BookNumber = br.BorrowedBook
JOIN BookCollection bc ON bc.BookColId = bk.BookCol
GROUP BY bc.BookColId, bc.Title
HAVING COUNT(br.BorrowedBook) >= 3;
GO

-- j) Find readers (reader ID, last name, first name) who always returned books on time (never overdue).
CREATE VIEW [View_ReaderReturnBookWithinDueDate] AS
SELECT r.ReaderId, r.Fname, r.Lname, DATEDIFF(DAY, br.BorrowedDate, GETDATE()) AS Range 
FROM Borrowed br
JOIN Reader r ON r.ReaderId = br.Reader
WHERE DATEDIFF(DAY, br.BorrowedDate, GETDATE()) <= br.DueDate;
GO