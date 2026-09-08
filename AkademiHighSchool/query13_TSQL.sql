USE AkademiHighSchool;
GO

PRINT 'Hello World';
GO

BEGIN 
    PRINT 'Hello World'
    PRINT 'This is Transact-SQL';
END;
GO

-- Get 'Osana Najimi' name and her average score.
DECLARE @FullName VARCHAR(100), @AVGGrade NUMERIC(2, 1)
SELECT @FullName = s.FName + ' ' + s.LName, @AVGGrade = AVG(sg.Grade)
    FROM Student s JOIN StudentGrade sg ON sg.StudentID = s.StudentID 
    WHERE (FName = 'Osana' AND LName = 'Najimi')
    GROUP BY s.FName, s.LName

PRINT 'Student Name:' + ' ' + CONVERT(VARCHAR, @FullName)
PRINT 'Average Grade:' + ' ' + CONVERT(VARCHAR, @AVGGrade);
GO




-- Get the Student Council Leader name and average score.
DECLARE @StudentCouncilLeader VARCHAR(100), @AVGGrade NUMERIC(2, 1)
SET @StudentCouncilLeader = (SELECT s.FName + ' ' + s.LName 
    FROM Student s JOIN Club c ON c.ClubLeaderID = s.StudentID 
    WHERE c.ClubName = 'Student Council')
    
SET @AVGGrade = (SELECT AVG(sg.Grade) FROM StudentGrade sg 
                JOIN Student s ON s.StudentID = sg.StudentID
                JOIN Club c ON c.ClubLeaderID = s.StudentID 
                WHERE c.ClubName = 'Student Council'
                GROUP BY sg.StudentID)

PRINT 'Student Council Leader:' + ' ' + CONVERT(VARCHAR, @StudentCouncilLeader)
PRINT 'Average Grade:' + ' ' + CONVERT(VARCHAR, @AVGGrade);
GO


-- Use the StudentID to get any student and return their average score, also grade their level.
DECLARE @StudentID VARCHAR(4), @StudentName VARCHAR(100), @AVGGrade NUMERIC(2, 1), @GradeLevel VARCHAR(1)
SET @StudentID = 'S112'
SET @StudentName = (SELECT s.FName + ' ' + s.LName FROM Student s WHERE StudentID = @StudentID)

PRINT 'Student Name:' + ' ' + CONVERT(VARCHAR, @StudentName)

SELECT @AVGGrade = AVG(sg.Grade)
    FROM Student s JOIN StudentGrade sg ON sg.StudentID = s.StudentID 
    WHERE s.StudentID = @StudentID

PRINT 'Average Grade:' + ' ' + CONVERT(VARCHAR, @AVGGrade);

IF @AVGGrade >= 8.0
    SET @GradeLevel = 'A'
ELSE IF @AVGGrade >= 6.5
    SET @GradeLevel = 'B'
ELSE IF @AVGGrade >= 4.0
    SET @GradeLevel = 'C'
ELSE IF @AVGGrade < 4.0
    SET @GradeLevel = 'D'
ELSE SET @GradeLevel = 'F'

PRINT 'Grade Level:' + ' ' + CONVERT(VARCHAR, @GradeLevel);
GO

-- Select a class, increase every student average from that class until the average grade of the class reaches 8.0 
-- And the student average cannot exceed 10
-- Do not update the original table
DECLARE @StudentID VARCHAR(4), @FullName VARCHAR(100), @ClassID VARCHAR(4), @StudentAVGGrade NUMERIC(2, 1), 
@ClassAVGGrade NUMERIC(2, 1), @TotalStudentsinClass INT, @Counter INT
-- Create a #temp table to store the Identity 
SET @ClassID = 'C022'

SELECT IDENTITY(INT, 1, 1) AS RowNum, s.StudentID, AVG(sg.Grade) AS AVGGrade INTO #TempStudents FROM Student s 
    JOIN StudentGrade sg ON sg.StudentID = s.StudentID JOIN Class c ON c.ClassID = s.ClassNo
    WHERE ClassID = @ClassID GROUP BY s.StudentID

SET @Counter = 1
SET @ClassAVGGrade = (SELECT AVG(AVGGrade)FROM #TempStudents)
SET @TotalStudentsinClass = (SELECT COUNT(StudentID) FROM #TempStudents)

-- Define the While loop
WHILE @ClassAVGGrade < 8.0
BEGIN
    -- Get the cirrent student with the counter
    SELECT @StudentAVGGrade = AVGGrade, @StudentID = StudentID FROM #TempStudents WHERE RowNum = @Counter
    SELECT @FullName = s.FName + ' ' + s.LName FROM Student s WHERE StudentID = @StudentID 

    PRINT 'StudentID:' + ' ' + CONVERT(VARCHAR, @StudentID) + ', Name:' + ' ' + @FullName
    PRINT 'AVG Grade (before):' + ' ' + CONVERT(VARCHAR, @StudentAVGGrade)

    -- Make sure the student grade does not exceed 10
    IF @StudentAVGGrade < 10
    BEGIN
        -- Prevent the result from being exceed 10 with CASE WHEN
        UPDATE #TempStudents 
        SET AVGGrade = CASE WHEN AVGGrade + 0.1 > 10 THEN 10 ELSE AVGGrade + 0.1 END
        WHERE RowNum = @Counter
        PRINT 'AVG Grade (after):' + ' ' + CONVERT(VARCHAR, @StudentAVGGrade + 0.1)
    END

    -- Move to next student
    SET @Counter = @Counter + 1
    IF @Counter > @TotalStudentsinClass
        SET @Counter = 1  

    -- Recompute the current student average
    SELECT @ClassAVGGrade = AVG(AVGGrade) FROM #TempStudents
    PRINT 'Current Average:' + ' ' + CONVERT(VARCHAR, @ClassAVGGrade)

END;

-- Select from the #TempStudent table
SELECT * FROM #TempStudents

-- Drop the #TempStudent table
DROP TABLE #TempStudents;
GO


-- Create a table name named TempClass to store the ClassNumber, and the number of students, 
-- each record has an identity row number incremented by 1 every time a new record appears.
SELECT IDENTITY(INT, 1, 1) AS RowNum, ClassName, COUNT(StudentID) AS NumberofStudents 
INTO temp_class FROM Class c 
JOIN Student s ON s.ClassNo = c.ClassID 
GROUP BY ClassName

SELECT * FROM temp_class;
GO

-- Insert a duplicate value on the Club Table
BEGIN TRY
    INSERT INTO Club (ClubID, ClubName, ClubLeaderID) VALUES ('B001', 'Cooking Club', 'S112')
END TRY
BEGIN CATCH
   RAISERROR('Duplicate records for the Club table', 16, 1)
END CATCH;
GO

-- : Insert a duplicate Primary Key value on the Student Table.
BEGIN TRY 
    INSERT INTO Student (StudentID, FName, LName, Birthday, Gender, ClassNo, ClubNo, Strength, MainPersona) 
    VALUES ('S105', 'Taeko', 'Yamada', '2004-04-01', 'F', 'C021', 'B001', 'Invincible', 'Devoted');
END TRY
BEGIN CATCH
    SELECT 
    ERROR_NUMBER() AS ErrorNumber,
    ERROR_SEVERITY() AS ErrorSeverity,
    ERROR_STATE() AS ErrorState,
    ERROR_PROCEDURE() AS ErrorProcedure,
    ERROR_LINE() AS ErrorLine,
    ERROR_MESSAGE() AS ErrorMessage;
END CATCH;
GO

-- Insert a value that violates the Foreign Key constraint on the Student Table.
BEGIN TRY 
    INSERT INTO Student (StudentID, FName, LName, Birthday, Gender, ClassNo, ClubNo, Strength, MainPersona) 
    VALUES ('S299', 'Taeko', 'Yamada', '2004-04-01', 'F', 'C021', 'B148', 'Invincible', 'Devoted');
END TRY
BEGIN CATCH
    SELECT 
    ERROR_NUMBER() AS ErrorNumber,
    ERROR_SEVERITY() AS ErrorSeverity,
    ERROR_STATE() AS ErrorState,
    ERROR_PROCEDURE() AS ErrorProcedure,
    ERROR_LINE() AS ErrorLine,
    ERROR_MESSAGE() AS ErrorMessage;
END CATCH;
GO

