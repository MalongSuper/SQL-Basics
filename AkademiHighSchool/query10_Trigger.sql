USE AkademiHighSchool;
GO

-- Trigger: A teacher must teach for exactly two classes
CREATE TRIGGER trg_TeacherClass ON Class
FOR INSERT, UPDATE
AS
BEGIN
    IF EXISTS (SELECT * FROM Class 
    WHERE TeacherID IN (SELECT TeacherID FROM INSERTED) 
    GROUP BY TeacherID HAVING COUNT(*) > 1)

    BEGIN
        RAISERROR('A teacher must teach for exactly one class', 16, 1)
        ROLLBACK TRANSACTION
    END
END;
GO


-- Test Trigger with a INSERT INTO
INSERT INTO Class (ClassID, ClassName, TeacherID) VALUES
('C034', '3-4', 'T101');
GO


-- Trigger: Non-Teacher Staff cannot be assigned to any class
CREATE TRIGGER trg_NonTeacherStaff ON Class
FOR INSERT, UPDATE
AS
BEGIN 
    IF EXISTS (SELECT * FROM INSERTED i JOIN TeachingStaff t ON i.TeacherID = t.StaffID 
    WHERE t.MainRole <> 'Teacher')
    BEGIN
        RAISERROR('Non-Teacher Staff cannot be assigned to any class', 16, 1)
        ROLLBACK TRANSACTION
    END
END;
GO


INSERT INTO Class (ClassID, ClassName, TeacherID) VALUES
('C034', '3-4', 'T202');
GO

-- Create a trigger that automatically assigns any new student to the clubless club.
CREATE TRIGGER trg_StudenttoClublessClub ON Student
AFTER INSERT, UPDATE
AS
BEGIN
    DECLARE @ClubID VARCHAR(4)
    SET @ClubID = (SELECT ClubID FROM Club WHERE ClubName = 'Clubless Club')
    UPDATE s SET s.ClubNo = @ClubID FROM Student s JOIN INSERTED i ON s.StudentId = i.StudentId
END;
GO


-- Create a trigger that ensures no student receive more than 3 scholarships
CREATE TRIGGER trg_StudentScholarship ON StudentScholarship
FOR INSERT, UPDATE
AS
BEGIN
    IF EXISTS(SELECT * FROM StudentScholarship 
            WHERE StudentID IN (SELECT StudentID FROM INSERTED)
            GROUP BY StudentID HAVING COUNT(ScholarshipID) > 3) 
    BEGIN
        RAISERROR('Student cannot receive more than 3 scholarships', 16, 1)
        ROLLBACK TRANSACTION
    END
END;
GO

-- Create a trigger that ensures no student receive 2 scholarships of the same type
SELECT COUNT(*), ScholarshipType, StudentID FROM Scholarship s1 
JOIN StudentScholarship s2 ON s1.ScholarshipID = s2.ScholarshipID
GROUP BY StudentID, ScholarshipType;
GO

CREATE TRIGGER trg_ScholarshipType ON StudentScholarship
FOR INSERT, UPDATE
AS
BEGIN
    IF EXISTS (SELECT * FROM Scholarship sp 
            JOIN StudentScholarship stp ON stp.ScholarshipID = sp.ScholarshipID
            WHERE stp.StudentID IN (SELECT StudentID FROM INSERTED)
            GROUP BY stp.StudentID, sp.ScholarshipType
            HAVING COUNT(sp.ScholarshipType) > 1)
    BEGIN
        RAISERROR('Student cannot receive 2 scholarships of the same type', 16, 1)
        ROLLBACK TRANSACTION
    END
END;

-- Test with some data
INSERT INTO StudentScholarship (ScholarshipID, StudentID) VALUES ('P002', 'S111')

INSERT INTO StudentScholarship (ScholarshipID, StudentID) VALUES ('P010', 'S111')
INSERT INTO StudentScholarship (ScholarshipID, StudentID) VALUES ('P020', 'S111')
INSERT INTO StudentScholarship (ScholarshipID, StudentID) VALUES ('P030', 'S111')

DELETE FROM StudentScholarship WHERE ScholarshipID = 'P010' AND StudentID = 'S111'

