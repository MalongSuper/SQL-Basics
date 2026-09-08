USE AkademiHighSchool;
GO



-- Create temp table that stores student ID, Fname, and LName of students with a club
SELECT StudentID, FName, LName INTO temp_studentname FROM Student WHERE ClubNo IS NOT NULL;
GO

SELECT * FROM temp_studentname



-- Update the Club table to introduce the club leaders.
UPDATE Club SET ClubLeaderID = 'S113' WHERE ClubID = 'B001';
UPDATE Club SET ClubLeaderID = 'S114' WHERE ClubID = 'B002';
UPDATE Club SET ClubLeaderID = 'S115' WHERE ClubID = 'B003';
UPDATE Club SET ClubLeaderID = 'S139' WHERE ClubID = 'B004';
UPDATE Club SET ClubLeaderID = 'S144' WHERE ClubID = 'B005';
UPDATE Club SET ClubLeaderID = 'S149' WHERE ClubID = 'B006';
UPDATE Club SET ClubLeaderID = 'S154' WHERE ClubID = 'B007';
UPDATE Club SET ClubLeaderID = 'S159' WHERE ClubID = 'B008';
UPDATE Club SET ClubLeaderID = 'S116' WHERE ClubID = 'B009';
UPDATE Club SET ClubLeaderID = 'S169' WHERE ClubID = 'B010';
UPDATE Club SET ClubLeaderID = 'S134' WHERE ClubID = 'B011';
UPDATE Club SET ClubLeaderID = 'S117' WHERE ClubID = 'B101';
UPDATE Club SET ClubLeaderID = 'S119' WHERE ClubID = 'B102';
UPDATE Club SET ClubLeaderID = 'S179' WHERE ClubID = 'B103';
GO


-- Delete Student "Info-Chan"
-- Since there is a table referencing the studentid from the student, 
-- we must drop those tables
-- Look for the StudentID of the student Info Chan, then we take this 
-- value to delete the student record based on the ID
SELECT StudentID FROM Student WHERE (FName = 'Info' AND LName = 'Chan');
-- Delete the student grade of Info Chan
DELETE FROM StudentGrade WHERE StudentID = 'S190';
-- Simplified version is:
-- DELETE FROM StudentGrade WHERE StudentID IN (SELECT StudentID FROM Student WHERE (FName = 'Info' AND LName = 'Chan'));
DELETE FROM Student WHERE StudentID = 'S190';
GO


-- We want to discard the NULL in ClubNo
-- Create a new club name 'Clubless Club' and assign every clubless member to this club
-- Pick the one with the highest average score to be club leader
DECLARE @BestStudentnoClub VARCHAR(4)
SET @BestStudentnoClub = (SELECT TOP 1 sg.StudentID FROM Student s JOIN StudentGrade sg ON sg.StudentID = s.StudentID
WHERE ClubNo IS NULL GROUP BY sg.StudentID ORDER BY AVG(sg.Grade) DESC);


INSERT INTO Club (ClubID, ClubName, ClubLeaderID) VALUES
('B999', 'Clubless Club', @BestStudentnoClub);
GO

UPDATE Student SET ClubNo = (SELECT ClubID FROM Club WHERE ClubName = 'Clubless Club')
WHERE StudentID IN (SELECT StudentID FROM Student WHERE ClubNO IS NULL);
GO

-- Check with queries
SELECT * FROM Club
SELECT * FROM Student

-- Return the Average Score of every class.
SELECT c.ClassName, AVG(sg.Grade) AS AVGGrade
FROM Class c 
JOIN Student s ON s.ClassNo = c.ClassID
JOIN StudentGrade sg ON sg.StudentID = s.StudentID
GROUP BY c.ClassName;
GO

-- Create two new tables named Scholarship with ScholarshipID, ScholarshipName. 
-- The primary key is the ScholarshipID, 
-- and StudentScholarship with ScholarshipID and StudentID, 
-- the primary key is (ScholarshipID, StudentID).
CREATE TABLE Scholarship (
    ScholarshipID VARCHAR(4) NOT NULL,
    ScholarshipName VARCHAR(50) NOT NULL,
    ScholarshipType VARCHAR(25) NOT NULL
);
GO

ALTER TABLE Scholarship
ADD CONSTRAINT pk_ScholarshipID PRIMARY KEY (ScholarshipID),
    CONSTRAINT chk_ScholarshipID CHECK (ScholarshipID LIKE 'P[0123][0-9][0-9]'),
    CONSTRAINT df_ScholarshipType DEFAULT 'Language' FOR ScholarshipType,
    CONSTRAINT uq_ScholarshipName UNIQUE (ScholarshipName);
GO

CREATE TABLE StudentScholarship (
    ScholarshipID VARCHAR(4) NOT NULL,
    StudentID VARCHAR(4) NOT NULL
);
GO

ALTER TABLE StudentScholarship
ADD CONSTRAINT pk_StudentScholarship PRIMARY KEY (ScholarshipID, StudentID),
    CONSTRAINT fk_ScholarshipID FOREIGN KEY (ScholarshipID) REFERENCES Scholarship(ScholarshipID),
    CONSTRAINT fk_StudentScholarship FOREIGN KEY (StudentID) REFERENCES Student(StudentID);
GO

-- PE (Physical Education)
INSERT INTO Scholarship (ScholarshipID, ScholarshipName, ScholarshipType) VALUES ('P001', 'Physical Education Scholars', 'PE');
INSERT INTO Scholarship (ScholarshipID, ScholarshipName, ScholarshipType) VALUES ('P002', 'Athletic Achievement Fund', 'PE');
-- Biology
INSERT INTO Scholarship (ScholarshipID, ScholarshipName, ScholarshipType) VALUES ('P010', 'Biology Excellence Award', 'Biology');
INSERT INTO Scholarship (ScholarshipID, ScholarshipName, ScholarshipType) VALUES ('P011', 'Life Sciences Merit Grant', 'Biology');
-- Chemistry
INSERT INTO Scholarship (ScholarshipID, ScholarshipName, ScholarshipType) VALUES ('P020', 'Chemistry Scholars Program', 'Chemistry');
INSERT INTO Scholarship (ScholarshipID, ScholarshipName, ScholarshipType) VALUES ('P021', 'Molecular Science Grant', 'Chemistry');
-- Psychology
INSERT INTO Scholarship (ScholarshipID, ScholarshipName, ScholarshipType) VALUES ('P030', 'Psychology Achievement Award', 'Psychology');
INSERT INTO Scholarship (ScholarshipID, ScholarshipName, ScholarshipType) VALUES ('P031', 'Behavioral Science Fellowship', 'Psychology');
-- Language
INSERT INTO Scholarship (ScholarshipID, ScholarshipName, ScholarshipType) VALUES ('P040', 'Language Studies Scholarship', 'Language');
INSERT INTO Scholarship (ScholarshipID, ScholarshipName, ScholarshipType) VALUES ('P041', 'Linguistics Research Grant', 'Language');
GO

UPDATE Scholarship SET ScholarshipType = 'Physical Education' WHERE ScholarshipType = 'PE';
GO


-- Apply the scholarship based on the following rule
-- There are two scholarship records for each type of scholarship
-- Choose every student with Grade greater than 9.0 to 
-- the higher scholarship, and greater than 7.5 but lower than 9.0
-- to the lower scholarship
-- depending on your choice
-- Make sure no student is assigned to two similar type of scholarship
CREATE PROCEDURE proc_ScholarshipAssignment
@HigherScholarshipID VARCHAR(4),
@LowerScholarshipID VARCHAR(4)
AS
BEGIN 
    -- Check if the two scholarships have the same type
    DECLARE @HigherType VARCHAR(25), @LowerType VARCHAR(25), @HigherStudentID VARCHAR(4), @LowerStudentID VARCHAR(4)
    SET @HigherType = (SELECT ScholarshipType FROM Scholarship WHERE ScholarshipID = @HigherScholarshipID) 
    SET @LowerType = (SELECT ScholarshipType FROM Scholarship WHERE ScholarshipID = @LowerScholarshipID)

    IF @HigherType <> @LowerType
    BEGIN
        PRINT 'The two scholarships are not the same type'
        RETURN
    END


    INSERT INTO StudentScholarship (ScholarshipID, StudentID) SELECT @HigherScholarshipID, StudentID FROM Student
        WHERE StudentID IN (SELECT s.StudentID FROM Student s JOIN StudentGrade sg ON sg.StudentID = s.StudentID
        JOIN Subject st ON st.SubjectID = sg.SubjectID
        WHERE st.SubjectName = @HigherType AND sg.Grade >= 9.0)

    INSERT INTO StudentScholarship (ScholarshipID, StudentID) SELECT @LowerScholarshipID, StudentID FROM Student
        WHERE StudentID IN (SELECT s.StudentID FROM Student s JOIN StudentGrade sg ON sg.StudentID = s.StudentID
        JOIN Subject st ON st.SubjectID = sg.SubjectID
        WHERE st.SubjectName = @LowerType AND sg.Grade >= 7.5 AND sg.Grade < 9.0)


END;
GO

-- Execute the procedure and test it with SELECT query
EXEC proc_ScholarshipAssignment 'P001', 'P002';
GO





