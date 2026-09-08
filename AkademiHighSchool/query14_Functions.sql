USE AkademiHighSchool;
GO

-- Create a function that takes StudentID as an input, return the name and the average grade of that student as a temp table.
CREATE FUNCTION StudentNameAVGGrade
(@StudentID VARCHAR(4))
RETURNS @Result TABLE (StudentName VARCHAR(100), AverageGrade NUMERIC(2, 1))
AS
BEGIN
    INSERT INTO @Result SELECT s.FName + ' ' + s.LName, AVG(sg.Grade) FROM Student s 
        JOIN StudentGrade sg ON s.StudentID = sg.StudentID 
        WHERE s.StudentID = @StudentID
        GROUP BY s.FName, s.LName;
    RETURN;
END; 
GO

-- Use the query
SELECT * FROM dbo.StudentNameAVGGrade('S101');
GO

-- Create a function that takes StudentID as an input, return the name of the club this student belongs to
CREATE FUNCTION StudentClubName
(@StudentID VARCHAR(4))
RETURNS VARCHAR(50)
AS
BEGIN 
    DECLARE @ClubName VARCHAR(50)
    SELECT @ClubName = c.ClubName FROM Student s 
        JOIN Club c ON c.ClubID = s.ClubNo
        WHERE StudentID = @StudentID;

    RETURN @ClubName;
END;
GO


SELECT FName + ' ' + LName AS StudentName, dbo.StudentClubName('S134') AS ClubName 
        FROM Student WHERE StudentID = 'S134';
GO


-- Create a function that takes StudentID as an input, return the student's score for every subject
CREATE FUNCTION StudentSubjectScore
(@StudentID VARCHAR(4))
RETURNS TABLE
AS
RETURN 
    (SELECT s.FName + ' ' + s.LName AS StudentName, sg.Grade 
    FROM Student s JOIN StudentGrade sg ON s.StudentID = sg.StudentID
    WHERE s.StudentID = @StudentID);
GO

SELECT * FROM dbo.StudentSubjectScore('S119');
GO

DROP FUNCTION StudentNameAVGGrade
DROP FUNCTION StudentClubName
DROP FUNCTION StudentSubjectScore