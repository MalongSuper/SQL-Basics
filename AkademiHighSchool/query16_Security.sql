USE AkademiHighSchool;
GO

CREATE LOGIN super_admin WITH PASSWORD = 'admin123@'
ALTER LOGIN super_admin WITH DEFAULT_DATABASE = AkademiHighSchool
GO

ALTER SERVER ROLE sysadmin ADD MEMBER super_admin
GO

-- Create two new logins for Teacher and Student
CREATE LOGIN loginTeacher WITH PASSWORD = 'Teacher@123';
GO

CREATE LOGIN loginStudent WITH PASSWORD = 'Student@123';
GO

-- Default database
ALTER LOGIN loginTeacher WITH DEFAULT_DATABASE = AkademiHighSchool;
GO

ALTER LOGIN loginStudent WITH DEFAULT_DATABASE = AkademiHighSchool;
GO

-- Create two users for the created logins
CREATE USER userTeacher FOR LOGIN loginTeacher;
GO

CREATE USER userStudent FOR LOGIN loginStudent;
GO

-- Create roles
CREATE ROLE roleTeacher;
GO

CREATE ROLE roleStudent;
GO

-- Finally, add Users to Their Respective Roles:
EXEC sp_addrolemember 'roleTeacher', userTeacher
EXEC sp_addrolemember 'roleStudent', userStudent

-- User Teacher: Can SELECT, INSERT, UPDATE on the Scholarship table and Subject Table
GRANT SELECT, INSERT, UPDATE ON dbo.Scholarship TO roleTeacher
WITH GRANT OPTION;
GO

GRANT SELECT, INSERT, UPDATE ON dbo.Subject TO roleTeacher;
GO

-- User Student, can SELECT on Subject and Club Table
GRANT SELECT ON dbo.Subject TO roleStudent
GO

GRANT SELECT ON dbo.Club TO roleStudent
GO

-- View with SESSION_CONTEXT
EXEC sp_set_session_context @Key = 'student_id', @Value = 'S121';
GO

-- Create many views that retrieve the student information, grade score, and any other relevant information for that student.
CREATE VIEW viewuq_StudentData AS 
SELECT * FROM Student WHERE StudentId = SESSION_CONTEXT(N'student_id');
GO

CREATE VIEW viewuq_StudentGrade AS
SELECT * FROM StudentGrade WHERE StudentId = SESSION_CONTEXT(N'student_id');
GO

CREATE VIEW viewuq_AVGStudentGrade AS
SELECT AVG(Grade) AS AVGGrade FROM StudentGrade WHERE StudentId = SESSION_CONTEXT(N'student_id');
GO


SELECT * FROM viewuq_StudentData;
GO

SELECT * FROM viewuq_StudentGrade;
GO

SELECT * FROM viewuq_AVGStudentGrade;
GO

GRANT SELECT ON viewuq_StudentData TO roleStudent
GRANT SELECT ON viewuq_StudentGrade TO roleStudent
GRANT SELECT ON viewuq_AVGStudentGrade TO roleStudent


DROP VIEW viewuq_StudentData
DROP VIEW viewuq_StudentGrade
DROP VIEW viewuq_AVGStudentGrade


-- User Teacher: Can retrieve student who belong to their class
EXEC sp_set_session_context @Key = 'teacher_id', @Value = 'T103';
GO

CREATE VIEW viewuq_TeacherInfo AS
SELECT * FROM TeachingStaff WHERE StaffId = SESSION_CONTEXT(N'teacher_id');
GO

CREATE VIEW viewuq_StudentinClass AS
SELECT s.FName, s.LName FROM TeachingStaff t 
JOIN Class c ON c.TeacherID = t.StaffID
JOIN Student s ON s.ClassNo = c.ClassID WHERE StaffID = SESSION_CONTEXT(N'teacher_id')
GO

GRANT SELECT ON viewuq_TeacherInfo TO roleTeacher
GRANT SELECT ON viewuq_StudentinClass TO roleTeacher
GO

-- Use Procedure
CREATE PROCEDURE ClearAllSessionContext
AS
BEGIN
    EXEC sp_set_session_context @Key = 'teacher_id', @Value = NULL;
    EXEC sp_set_session_context @Key = 'customer_id', @Value = NULL;
END;
GO


CREATE PROCEDURE StudentSessionContext
@StudentID VARCHAR(4)
AS
BEGIN
    EXEC ClearAllSessionContext;
    DECLARE @StudentName VARCHAR(100)

    IF EXISTS(SELECT * FROM Student WHERE StudentId = @StudentId)
        BEGIN
        EXEC sp_set_session_context @Key = 'student_id', @Value = @StudentId
        SET @StudentName = (SELECT FName + ' ' + LName FROM Student WHERE StudentId = @StudentId)
        PRINT 'Welcome Back' + ' ' + CONVERT(VARCHAR, @StudentName)
        END
    ELSE
        PRINT 'Student with ID' + ' ' + CONVERT(VARCHAR, @StudentId) + ' ' + 'does not exist'
END;
GO

EXEC StudentSessionContext 'S101'; 

-- Grant Access on the Procedure
GRANT EXECUTE ON StudentSessionContext TO userStudent;
GO


CREATE PROCEDURE TeacherSessionContext
@TeacherID VARCHAR(4)
AS
BEGIN
    EXEC ClearAllSessionContext;
    DECLARE @TeacherName VARCHAR(100)
    
    IF EXISTS(SELECT * FROM TeachingStaff WHERE StaffId = @TeacherID)
        BEGIN
        EXEC sp_set_session_context @Key = 'teacher_id', @Value = @TeacherID
        SET @TeacherName = (SELECT FName + ' ' + LName FROM TeachingStaff WHERE StaffId = @TeacherID)
        PRINT 'Welcome Back' + ' ' + CONVERT(VARCHAR, @TeacherName)
        END
    ELSE
        PRINT 'Teacher with ID' + ' ' + CONVERT(VARCHAR, @TeacherId) + ' ' + 'does not exist'
END;
GO

EXEC TeacherSessionContext 'T108';

DROP PROCEDURE TeacherSessionContext;
GO

-- Grant Access on the Procedure
GRANT EXECUTE ON TeacherSessionContext TO userTeacher;
GO