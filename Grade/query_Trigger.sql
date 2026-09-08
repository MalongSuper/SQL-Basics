-- Trigger
USE GradeManagement;
GO

-- Trigger: The number of students in a class does not exceed 5
CREATE TRIGGER NumberofStudents
ON Enrollment
FOR INSERT, UPDATE
AS
DECLARE @Number TINYINT
SET @Number = (SELECT COUNT(StudentID) FROM Enrollment WHERE ClassCode IN (SELECT ClassCode FROM INSERTED))
IF @Number > 5
BEGIN
    RAISERROR('Number of Students does not exceed 5')
    ROLLBACK TRANSACTION
END;
GO

-- Testing Query
SELECT ClassCode, COUNT(StudentID) AS NumberofStudents FROM Enrollment GROUP BY ClassCode

