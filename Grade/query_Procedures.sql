USE GradeManagement;
GO

-- Proc1: Input parameters are student ID (mssv) and subject code (msmh).
-- Outputs:
-- 1. Number of attempts
-- 2. Highest score
-- 3. Average score for the subject
CREATE PROCEDURE Proc1
@StudentID CHAR(7),
@SubjectCode CHAR(9),
@Attempts INT OUTPUT,
@MaxGrade DECIMAL(5, 2) OUTPUT,
@AVGGrade DECIMAL(5, 2) OUTPUT
AS
BEGIN
    IF NOT EXISTS (SELECT * FROM Enrollment e JOIN Class c ON e.ClassCode = c.ClassCode 
    WHERE StudentId = @StudentID AND SubjectCode = @SubjectCode)
        BEGIN
            PRINT 'Cannot find information of Student' + ' ' + @StudentID + ' ' + 'with Subject' + ' ' + @SubjectCode
            PRINT 'This can be due to the following: '
            PRINT '1) The Subject either not exists or The student does not participate in any class of that subject'
            PRINT '2) The Student might not exist in the database'
        END
    ELSE
        PRINT 'Student ID' + ': ' + @StudentID
        PRINT 'Subject Code' + ': ' + @SubjectCode
        SELECT @Attempts = COUNT(c.SubjectCode), @MaxGrade = MAX(e.Grade), @AVGGrade = AVG(e.Grade) FROM Enrollment e
        JOIN Class c ON e.ClassCode = c.ClassCode
        GROUP BY StudentId, SubjectCode HAVING StudentId = @StudentID AND SubjectCode = @SubjectCode
END
GO

DECLARE  @Attempts INT, @MaxGrade DECIMAL(5, 2), @AVGGrade DECIMAL(5, 2)
EXEC Proc1 @StudentID = N'2300008', @SubjectCode = N'I3201DV01', @Attempts = @Attempts OUTPUT,
@MaxGrade = @MaxGrade OUTPUT, @AVGGrade = @AVGGrade OUTPUT
PRINT 'Attempts:' + ' ' + CONVERT(VARCHAR, @Attempts)
PRINT 'Max Grade:' + ' ' + CONVERT(VARCHAR, @MaxGrade)
PRINT 'Average Grade:' + ' ' + CONVERT(VARCHAR, @AVGGrade)
GO

DECLARE  @Attempts INT, @MaxGrade DECIMAL(5, 2), @AVGGrade DECIMAL(5, 2)
EXEC Proc1 @StudentID = N'2300008', @SubjectCode = N'IT201DV01', @Attempts = @Attempts OUTPUT,
@MaxGrade = @MaxGrade OUTPUT, @AVGGrade = @AVGGrade OUTPUT
PRINT 'Attempts:' + ' ' + CONVERT(VARCHAR, @Attempts)
PRINT 'Max Grade:' + ' ' + CONVERT(VARCHAR, @MaxGrade)
PRINT 'Average Grade:' + ' ' + CONVERT(VARCHAR, @AVGGrade)
GO

-- In Case The Procedure is incorrect
DROP PROCEDURE Proc1
GO

-- Query for Testing
SELECT * FROM Enrollment e JOIN Class c ON e.ClassCode = c.ClassCode
GO


-- Proc2: Input parameter is class code (malop).
-- Outputs:
-- English translation of the original exercise comment.
-- 2. Number of students who passed
-- 3. Number of students who failed
CREATE PROCEDURE Proc2
@ClassCode CHAR(12),
@ClassSize INT OUTPUT,
@PassedStudents INT OUTPUT,
@FailedStudents INT OUTPUT
AS
BEGIN
    SELECT @ClassSize = COUNT(e.StudentID) FROM Class c JOIN Enrollment e ON e.ClassCode = c.ClassCode 
    WHERE e.ClassCode = @ClassCode GROUP BY e.ClassCode
    SELECT @PassedStudents = COUNT(e.StudentID) FROM Class c JOIN Enrollment e ON e.ClassCode = c.ClassCode 
    WHERE e.Grade >= 5 AND e.ClassCode = @ClassCode GROUP BY e.ClassCode
    SELECT @FailedStudents = COUNT(CASE WHEN e.Grade < 5 THEN e.StudentID END) FROM Class c JOIN Enrollment e ON e.ClassCode = c.ClassCode 
    WHERE e.ClassCode = @ClassCode GROUP BY e.ClassCode
END;
GO

DECLARE @ClassCode CHAR(12), @ClassSize INT, @PassedStudents INT, @FailedStudents INT
SET @ClassCode = N'IT101DV01_01'
EXEC Proc2 @ClassCode = @ClassCode, @ClassSize = @ClassSize OUTPUT, @PassedStudents = @PassedStudents OUTPUT, @FailedStudents = @FailedStudents OUTPUT
PRINT 'Class Code:' + ' ' + CONVERT(VARCHAR, @ClassCode)
PRINT 'Class Size:' + ' ' + CONVERT(VARCHAR, @ClassSize)
PRINT 'Passed Students:' + ' ' + CONVERT(VARCHAR, @PassedStudents)
PRINT 'Failed Students:' + ' ' + CONVERT(VARCHAR, @FailedStudents)
GO

DECLARE @ClassCode CHAR(12), @ClassSize INT, @PassedStudents INT, @FailedStudents INT
SET @ClassCode = N'IT101DV01_02'
EXEC Proc2 @ClassCode = @ClassCode, @ClassSize = @ClassSize OUTPUT, @PassedStudents = @PassedStudents OUTPUT, @FailedStudents = @FailedStudents OUTPUT
PRINT 'Class Code:' + ' ' + CONVERT(VARCHAR, @ClassCode)
PRINT 'Class Size:' + ' ' + CONVERT(VARCHAR, @ClassSize)
PRINT 'Passed Students:' + ' ' + CONVERT(VARCHAR, @PassedStudents)
PRINT 'Failed Students:' + ' ' + CONVERT(VARCHAR, @FailedStudents)
GO


DROP PROCEDURE Proc2
GO

-- Query for Testing
SELECT e.ClassCode, e.StudentID, e.Grade FROM Class c JOIN Enrollment e ON e.ClassCode = c.ClassCode
SELECT e.ClassCode, e.StudentID, e.Grade FROM Class c JOIN Enrollment e ON e.ClassCode = c.ClassCode WHERE e.Grade >= 5
SELECT e.ClassCode, COUNT(e.StudentID) AS NumberofStudents FROM Class c JOIN Enrollment e ON e.ClassCode = c.ClassCode GROUP BY e.ClassCode
SELECT e.ClassCode, COUNT(e.StudentID) AS NumberofStudents FROM Class c JOIN Enrollment e ON e.ClassCode = c.ClassCode 
WHERE e.Grade >= 5 GROUP BY e.ClassCode
-- CASE WHEN to handle 0 students
-- CASE WHEN THEN sth END (returns NULL, they are ignored and will return 0)
SELECT e.ClassCode, COUNT(CASE WHEN e.Grade < 5 THEN e.StudentID END) AS NumberofStudents  FROM Class c 
LEFT JOIN Enrollment e ON e.ClassCode = c.ClassCode 
GROUP BY e.ClassCode
GO

-- Proc3: Input parameters are subject code (msmh), semester (hocky), and lecturer (giangvien).
-- Outputs:
-- 1. Create a new class with the provided parameters
-- 2. Select students who failed the subject to enroll in the new class
-- Insert some new data

-- Insert new students into the Student table
INSERT INTO [dbo].[Student] ([StudentID], [FullName], [Major]) VALUES
(N'2300009', N'Phạm Văn Minh', N'CNTT'),
(N'2300010', N'Nguyễn Văn Hùng', N'KTPM');
GO

-- Insert enrollments with repeated courses and low grades
INSERT INTO [dbo].[Enrollment] ([StudentID], [ClassCode], [Grade]) VALUES
(N'2300009', N'IT201DV01_02', CAST(3.50 AS Decimal(5, 2))),
(N'2300009', N'IT201DV01_03', CAST(4.80 AS Decimal(5, 2))),
(N'2300010', N'IT101DV01_01', CAST(2.00 AS Decimal(5, 2))),
(N'2300010', N'IT101DV01_02', CAST(4.50 AS Decimal(5, 2)));
GO



CREATE PROCEDURE Proc3
@SubjectCode CHAR(9),
@Semester CHAR(5),
@Lecturer NVARCHAR(50)
AS
    BEGIN
    DECLARE @ClassCode CHAR(12)
    DECLARE @StudentID CHAR(7)
    DECLARE @MaxGrade DECIMAL(5, 2)
    DECLARE @Prefix VARCHAR(10)
    DECLARE @NewSuffix INT
    -- Get the Prefix 
    SET @Prefix = @SubjectCode
    -- Get the highest suffix of the ClassCode
    -- To ensure if it starts with 0, a new subject
    SET @NewSuffix = (SELECT ISNULL(MAX(CAST(RIGHT(ClassCode, 2) AS INT)), 0) + 1 FROM Class WHERE SubjectCode = @SubjectCode)
    SET @ClassCode = @Prefix + '_' + RIGHT('0' + CAST(@NewSuffix AS VARCHAR(2)), 2)
    INSERT INTO Class(ClassCode, SubjectCode, Semester, Lecturer) VALUES (@ClassCode, @SubjectCode, @Semester, @Lecturer)
    
    -- Enroll those students to the new created class
    -- Use Cursor
    DECLARE StudentCursor CURSOR FOR SELECT e.StudentID, MAX(e.Grade) AS MaxGrade FROM Enrollment e 
    JOIN Class c ON c.ClassCode = e.ClassCode JOIN Subject s ON s.SubjectCode = c.SubjectCode
    GROUP BY e.StudentID HAVING MAX(e.Grade) < 5
    OPEN StudentCursor
    FETCH NEXT FROM StudentCursor INTO @StudentID, @MaxGrade
    WHILE @@FETCH_STATUS = 0
    BEGIN
        INSERT INTO Enrollment (StudentID, ClassCode, Grade) VALUES (@StudentID, @ClassCode, @MaxGrade)
        -- Fetch next student
        FETCH NEXT FROM StudentCursor INTO @StudentID, @MaxGrade
    END

    -- Close and Deallocate Cursor
    CLOSE StudentCursor
    DEALLOCATE StudentCursor
    END;
GO

DECLARE @SubjectCode CHAR(9), @Semester CHAR(5), @Lecturer NVARCHAR(50)
SET @SubjectCode = N'IT101DV01'
SET @Semester = '25.2A'
SET @Lecturer = N'Nguyễn Bá Trung'
EXEC Proc3 @SubjectCode = @SubjectCode, @Semester = @Semester, @Lecturer = @Lecturer
PRINT @SubjectCode
PRINT @Semester
PRINT @Lecturer
GO

DROP PROCEDURE Proc3

-- Query for Testing
SELECT * FROM Enrollment

SELECT e.StudentID, e.ClassCode, e.Grade, c.SubjectCode, s.SubjectName, c.Semester, c.Lecturer 
FROM Enrollment e JOIN Class c ON c.ClassCode = e.ClassCode JOIN Subject s ON s.SubjectCode = c.SubjectCode

-- Some Students take part in the subject multiple times and they pass it on the non-first course.
-- They already passed the Subject
SELECT e.StudentID, s.SubjectName, MAX(e.Grade) AS MaxGrade FROM Enrollment e 
JOIN Class c ON c.ClassCode = e.ClassCode JOIN Subject s ON s.SubjectCode = c.SubjectCode
GROUP BY e.StudentID, s.SubjectName  

SELECT e.StudentID, s.SubjectName, MAX(e.Grade) AS MaxGrade FROM Enrollment e 
JOIN Class c ON c.ClassCode = e.ClassCode JOIN Subject s ON s.SubjectCode = c.SubjectCode
GROUP BY e.StudentID, s.SubjectName HAVING MAX(e.Grade) < 5

SELECT e.StudentID, MAX(e.Grade) AS MaxGrade FROM Enrollment e JOIN Class c ON e.ClassCode = c.ClassCode 
GROUP BY e.StudentID HAVING MAX(e.Grade) < 5
GO

-- Proc4: Input parameter is student ID (mssv).
-- Outputs:
-- 1. GPA of the student
CREATE PROCEDURE Proc4
@StudentID CHAR(7),
@GPA DECIMAL(5, 2) OUTPUT
AS
BEGIN
    SELECT e.StudentID, c.SubjectCode, MAX(Grade) AS MaxGrade INTO MaxGrade FROM Enrollment e
    JOIN Class c ON c.ClassCode = e.ClassCode 
    GROUP BY e.StudentID, c.SubjectCode 

    SELECT @GPA = AVG(MaxGrade) FROM MaxGrade 
    WHERE @StudentID = StudentID
    GROUP BY StudentID

    DROP TABLE MaxGrade

END;
GO

DECLARE @StudentID CHAR(7), @GPA DECIMAL(5, 2)
SET @StudentID = '2300004'
EXEC Proc4 @StudentID = @StudentID, @GPA = @GPA OUTPUT
PRINT 'Student ID:' + ' ' + CONVERT(VARCHAR, @StudentID)
PRINT 'GPA:' + ' ' + CONVERT(VARCHAR, @GPA)
GO

DECLARE @StudentID CHAR(7), @GPA DECIMAL(5, 2)
SET @StudentID = '2300009'
EXEC Proc4 @StudentID = @StudentID, @GPA = @GPA OUTPUT
PRINT 'Student ID:' + ' ' + CONVERT(VARCHAR, @StudentID)
PRINT 'GPA:' + ' ' + CONVERT(VARCHAR, @GPA)
GO

-- Query for Testing
SELECT e.StudentID, c.SubjectCode, MAX(Grade) AS MaxGrade INTO MaxGrade FROM Enrollment e
JOIN Class c ON c.ClassCode = e.ClassCode 
GROUP BY e.StudentID, c.SubjectCode


SELECT e.StudentID, c.SubjectCode, MAX(Grade) AS MaxGrade FROM Enrollment e
JOIN Class c ON c.ClassCode = e.ClassCode 
GROUP BY e.StudentID, c.SubjectCode

SELECT StudentID, AVG(MaxGrade) FROM MaxGrade GROUP BY StudentID


DROP PROCEDURE Proc4
GO

-- Proc5: Input parameter is lecturer's full name (ho_ten_giangvien).
-- Outputs:
-- 1. Number of classes the lecturer teaches each semester
-- 2. Number of subjects the lecturer teaches each semester
CREATE PROCEDURE Proc5
@Lecturer NVARCHAR(50)
AS
BEGIN
    PRINT 'Lecturer:' + ' ' + @Lecturer
    DECLARE @Semester CHAR(5), @Numberofclasses INT, @Numberofsubjects INT
    -- A Cursor to select all distinct semester
    DECLARE SemesterCursor CURSOR FOR SELECT DISTINCT Semester FROM Class
    -- Open and Fetch the Cursor
    OPEN SemesterCursor
    FETCH NEXT FROM SemesterCursor INTO @Semester

    WHILE @@FETCH_STATUS = 0
    BEGIN
        SELECT @Numberofclasses = COUNT(ClassCode)
        FROM Class WHERE Lecturer = @Lecturer AND Semester = @Semester

        SELECT @Numberofsubjects = COUNT(DISTINCT SubjectCode)
        FROM Class WHERE Lecturer = @Lecturer AND Semester = @Semester

        PRINT 'Semester:' + ' ' + @Semester
        PRINT 'Number of Classes:' + ' ' + CONVERT(VARCHAR, @Numberofclasses)
        PRINT 'Number of Subjects:' + ' ' + CONVERT(VARCHAR, @Numberofsubjects)
        
        -- Fetch Next Student
        FETCH NEXT FROM SemesterCursor INTO @Semester

    END
    -- Close and Deallocate Cursor
    CLOSE SemesterCursor
    DEALLOCATE SemesterCursor

END;
GO

EXEC Proc5 @Lecturer = N'Võ Thị Thu Hà'
GO

EXEC Proc5 @Lecturer = N'Nguyễn Bá Trung'
GO

DROP PROCEDURE Proc5

-- Query for Testing, Use Cross Join
SELECT * FROM Class
SELECT Lecturer, Semester, COUNT(ClassCode) AS NumofClasses FROM Class GROUP BY Lecturer, Semester

SELECT c.Lecturer, s.SubjectName, c.Semester, COUNT(s.SubjectName) AS NumofSubjects FROM Class c JOIN Subject s ON s.SubjectCode = c.SubjectCode
GROUP BY c.Lecturer, s.SubjectName, c.Semester

SELECT c.Lecturer, s.SubjectName, c.Semester, COUNT(s.SubjectName) AS NumofSubjects FROM Class c JOIN Subject s ON s.SubjectCode = c.SubjectCode
WHERE c.Lecturer = N'Võ Thị Thu Hà' GROUP BY c.Lecturer, s.SubjectName, c.Semester

SELECT c.Lecturer, c.Semester, s.SubjectName, COUNT(c.SubjectCode) AS NumofSubjects FROM Subject s
LEFT JOIN Class c ON s.SubjectCode = c.SubjectCode
GROUP BY c.Lecturer, c.Semester, s.SubjectName
GO

-- Cross Join example, return the Lecturer and Semester
-- Return NULL if the lecturer does not teach any subject in the semester
SELECT DISTINCT Semester FROM Class
SELECT DISTINCT Lecturer FROM Class
SELECT c1.Lecturer, c2.Semester, c.SubjectCode
FROM (SELECT DISTINCT Lecturer FROM Class) c1 CROSS JOIN (SELECT DISTINCT Semester FROM Class) c2
LEFT JOIN Class c ON c.Lecturer = c1.Lecturer AND c.Semester = c2.Semester
GO



-- Cartesian Product with CROSS JOIN, LEFT JOIN 
SELECT c1.Lecturer, s.SubjectName, c2.Semester, COUNT(DISTINCT c.SubjectCode) AS NumofSubjects 
FROM (SELECT DISTINCT Lecturer FROM Class) c1
CROSS JOIN (SELECT DISTINCT SubjectName, SubjectCode FROM Subject) s
CROSS JOIN (SELECT DISTINCT Semester FROM Class) c2
LEFT JOIN Class c ON c.Lecturer = c1.Lecturer AND c.SubjectCode = s.SubjectCode 
AND c.Semester = c2.Semester
GROUP BY c1.Lecturer, s.SubjectName, c2.Semester


SELECT c1.Lecturer, c2.Semester, COUNT(c.ClassCode) AS NumofClasses 
FROM (SELECT DISTINCT Lecturer FROM Class) c1
CROSS JOIN (SELECT DISTINCT Semester FROM Class) c2
LEFT JOIN Class c ON c.Lecturer = c1.Lecturer 
AND c.Semester = c2.Semester
GROUP BY c1.Lecturer, c2.Semester
GO

-- Proc6: Input parameter is semester (hocky).
-- Outputs:
-- 1. List of students eligible for a scholarship based on the criteria:
--    - GPA > 8
--    - No failed subjects
--    - At least 3 subjects taken in the semester
--    - If there is no data, change it to 1 or 2
CREATE PROCEDURE Proc6
@Semester CHAR(5)
AS
BEGIN 
    CREATE TABLE #MaxGrade (
        StudentID CHAR(7),
        SubjectCode CHAR(9),
        MaxGrade DECIMAL(5, 2)
    );
    INSERT INTO #MaxGrade SELECT e.StudentID, c.SubjectCode, MAX(Grade) FROM Enrollment e
    JOIN Class c ON c.ClassCode = e.ClassCode GROUP BY e.StudentID, c.SubjectCode

    SELECT DISTINCT StudentID FROM Enrollment WHERE StudentID 
    IN (SELECT StudentID FROM #MaxGrade GROUP BY StudentID HAVING AVG(MaxGrade) > 8)
    AND 
    StudentID NOT IN (SELECT e.StudentID AS MaxGrade FROM Enrollment e 
    JOIN Class c ON c.ClassCode = e.ClassCode
    GROUP BY e.StudentID, c.SubjectCode HAVING MAX(e.Grade) < 5)
    AND
    StudentID IN (SELECT e.StudentID
    FROM Enrollment e JOIN Class c ON c.ClassCode = e.ClassCode
    WHERE c.Semester = @Semester
    GROUP BY e.StudentID, c.Semester HAVING COUNT(DISTINCT c.SubjectCode) >= 1) -- or >= 3

    DROP TABLE #MaxGrade
END;
GO

EXEC Proc6 @Semester = '24.1A'
EXEC Proc6 @Semester = '25.1A'

SELECT e.StudentID, c.SubjectCode, MAX(Grade) AS MaxGrade INTO Table_MaxGrade FROM Enrollment e
JOIN Class c ON c.ClassCode = e.ClassCode 
GROUP BY e.StudentID, c.SubjectCode

SELECT StudentID, AVG(MaxGrade) AS GPA FROM Table_MaxGrade GROUP BY StudentID HAVING AVG(MaxGrade) > 8
DROP TABLE Table_MaxGrade 

SELECT e.StudentID, c.SubjectCode, MAX(e.Grade) AS MaxGrade FROM Enrollment e 
JOIN Class c ON c.ClassCode = e.ClassCode
GROUP BY e.StudentID, c.SubjectCode

SELECT e.StudentID, c.Semester, COUNT(DISTINCT c.SubjectCode) AS NumberofSubjects 
FROM Enrollment e JOIN Class c ON c.ClassCode = e.ClassCode
WHERE c.Semester = '24.1A'
GROUP BY e.StudentID, c.Semester

SELECT * FROM Enrollment e JOIN Class c ON c.ClassCode = e.ClassCode

DROP PROCEDURE Proc6
GO

-- Proc7: Input parameter is semester (hocky).
-- Outputs:
-- 1. Add new classes for a subject if the current class sizes are greater or equal to 4 students
-- 2. Randomly transfer students from overpopulated classes to the new ones, ensuring:
--    - Class size does not have more than 3 students
--    - Old classes are reduced to exactly 3 students
CREATE PROCEDURE Proc7
@Semester CHAR(5)
AS
BEGIN
    DECLARE @SubjectCode CHAR(9)
    DECLARE @Lecturer NVARCHAR(50)
    DECLARE @OverClassCode CHAR(12)
    DECLARE @NewClassCode VARCHAR(12)
    DECLARE @StudentID CHAR(7)
    DECLARE @Grade DECIMAL(5, 2)
    DECLARE @Prefix VARCHAR(10)
    DECLARE @MaxStudents INT
    DECLARE @CountStudents INT
    DECLARE @NewSuffix INT
    -- Get the highest suffix of the ClassCode
    -- To ensure if it starts with 0, a new subject
    SET @MaxStudents = 3
    
    -- Cursor to get all overpopulated classes
    DECLARE AddClassCursor CURSOR FOR SELECT c.ClassCode, c.SubjectCode, c.Lecturer, COUNT(e.StudentID)
    FROM Enrollment e JOIN Class c ON c.ClassCode = e.ClassCode 
    WHERE c.Semester = @Semester
    GROUP BY c.ClassCode, c.SubjectCode, c.Lecturer 
    HAVING COUNT(e.StudentID) > @MaxStudents

    OPEN AddClassCursor
    FETCH NEXT FROM AddClassCursor INTO @OverClassCode, @SubjectCode, @Lecturer, @CountStudents
    WHILE @@FETCH_STATUS = 0
    BEGIN  -- If the class currently has more than 3 students
        WHILE (@CountStudents > @MaxStudents)
        BEGIN
            -- Get the Prefix 
            SET @Prefix = @SubjectCode
            -- Add a new class
            SET @NewSuffix = (SELECT ISNULL(MAX(CAST(RIGHT(ClassCode, 2) AS INT)), 0) + 1 FROM Class WHERE SubjectCode = @SubjectCode)
            SET @NewClassCode = @Prefix + '_' + RIGHT('0' + CAST(@NewSuffix AS VARCHAR(2)), 2)
            INSERT INTO Class(ClassCode, SubjectCode, Semester, Lecturer) 
            VALUES (@NewClassCode, @SubjectCode, @Semester, @Lecturer)
            -- Select one student in these classes to the class, select at random 
            SELECT TOP 1 @StudentID = StudentID, @Grade = Grade FROM Enrollment WHERE ClassCode = @OverClassCode
            ORDER BY NEWID()
            -- Remove the student from the class
            DELETE FROM Enrollment WHERE StudentID = @StudentID AND ClassCode = @OverClassCode
            INSERT INTO Enrollment (StudentID, ClassCode, Grade) VALUES (@StudentID, @NewClassCode, @Grade)
            SET @CountStudents = @CountStudents - 1
            PRINT 'Insert Successful!!'
            PRINT 'Class Code' + ' ' + CONVERT(VARCHAR, @NewClassCode)
            PRINT 'Subject Code' + ' ' + CONVERT(VARCHAR, @SubjectCode)
            PRINT 'Semester' + ' ' + CONVERT(VARCHAR, @Semester)
            PRINT 'Lecturer' + ' ' + CONVERT(NVARCHAR, @Lecturer)
            PRINT 'Moved Student' + ' ' + CONVERT(VARCHAR, @StudentID) + 'to the class'
            PRINT 'Remaining Num of Students in the original class' + ' ' + CONVERT(VARCHAR, @CountStudents)
        END
        FETCH NEXT FROM AddClassCursor INTO @OverClassCode, @SubjectCode, @Lecturer, @CountStudents
    END
    -- Close and Deallocate Cursor
    CLOSE AddClassCursor
    DEALLOCATE AddClassCursor
END;
GO

EXEC Proc7 @Semester = '25.1A'

DROP PROCEDURE Proc7

SELECT * FROM Class
SELECT * FROM Enrollment ORDER BY ClassCode DESC
SELECT ClassCode, COUNT(StudentID) AS NumberofStudents FROM Enrollment GROUP BY ClassCode
SELECT TOP 1 StudentID, Grade FROM Enrollment

SELECT c.ClassCode, c.SubjectCode, c.Semester, c.Lecturer, COUNT(e.StudentID) AS NumberofStudents FROM Enrollment e 
JOIN Class c ON c.ClassCode = e.ClassCode 
GROUP BY c.ClassCode, c.SubjectCode, c.Semester, c.Lecturer

SELECT c.ClassCode, c.SubjectCode, c.Semester, c.Lecturer, COUNT(e.StudentID) AS NumberofStudents 
FROM Enrollment e JOIN Class c ON c.ClassCode = e.ClassCode 
GROUP BY c.ClassCode, c.SubjectCode, c.Semester, c.Lecturer HAVING COUNT(e.StudentID) >= 4

SELECT c.ClassCode, c.SubjectCode, c.Lecturer, COUNT(e.StudentID) AS NumberofStudents FROM Enrollment e 
JOIN Class c ON c.ClassCode = e.ClassCode WHERE c.Semester = '24.1A'
GROUP BY c.ClassCode, c.SubjectCode, c.Lecturer
