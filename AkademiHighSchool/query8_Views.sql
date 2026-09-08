USE AkademiHighSchool;
GO

-- View: Store every student
CREATE VIEW view_student AS 
SELECT StudentID, FName + ' ' + LName AS FullName, Gender, MainPersona FROM Student;
GO


-- View: Store every female student
CREATE VIEW view_femalestudent AS
SELECT StudentID, FName + ' ' + LName AS FullName, MainPersona FROM Student
WHERE Gender = 'F';
GO

-- View: Store every male student
CREATE VIEW view_malestudent AS
SELECT StudentID, FName + ' ' + LName AS FullName, MainPersona FROM Student
WHERE Gender = 'M';
GO

-- View: ClassID and ClassName
CREATE VIEW view_class AS
SELECT ClassID, ClassName FROM Class;
GO

-- View: Every Club Leader and the club that the club leader lead
CREATE VIEW view_clubleaders AS
SELECT s.StudentID, s.FName + ' ' + s.LName AS ClubLeaderName, c.ClubName FROM Student s
JOIN Club c ON c.ClubID = s.ClubNo WHERE StudentID IN (SELECT ClubLeaderID FROM Club);
GO

-- View: Student Name and the AVGGrade
CREATE VIEW view_AVGGrade AS
SELECT s.StudentID, s.FName + ' ' + s.LName AS StudentName, AVG(sg.Grade) AS AVGGrade 
FROM Student s
JOIN StudentGrade sg ON sg.StudentID = s.StudentID
GROUP BY s.StudentID, s.FName, s.LName;
GO

-- Retrieve the records in the view ordered by grade
SELECT * FROM view_AVGGrade ORDER BY AVGGrade DESC;
GO


-- Modification on View
CREATE VIEW view_subject AS
SELECT * FROM Subject;
GO

SELECT * FROM view_subject
-- UPDATE view_subject SET SubjectName = 'Biological' WHERE SubjectID = 'ST01'
-- Also affect the original table
SELECT * FROM Subject;
GO

-- DELETE FROM view_subject WHERE SubjectID = 'ST01';
-- GO

-- Return every club leader whose name starts with a
CREATE VIEW view_studentwitha AS 
SELECT * FROM Student JOIN Club ON Student.StudentID = Club.ClubLeaderID
WHERE FName LIKE 'a%'
GO

-- UPDATE view_studentwitha SET FName = 'Amai'

-- Insert a vlue to View Subject
-- INSERT INTO view_subject (SubjectID, SubjectName) VALUES ('ST06', 'Math')
-- DELETE FROM view_subject WHERE SubjectID = 'ST06'

-- Update on the temp table, does not change the original table
-- UPDATE temp_StudentName SET FName = 'Amai'
-- SELECT * FROM Student
-- SELECT * FROM temp_StudentName

-- You can create a view that retrieves values from another view.
CREATE VIEW view_studentname AS
SELECT FullName FROM view_student;
GO

SELECT * FROM view_studentname

-- Add a new class and assign Mida Rana (TeacherID 107)
INSERT INTO Class (ClassID, ClassName, TeacherID) VALUES
('C034', '3-4', 'T107');
GO

SELECT * FROM view_class;
GO

-- WITH ENCRYPTION in Views, retrieve every teacher
CREATE VIEW view_teacher 
WITH ENCRYPTION AS
SELECT StaffID AS TeacherID, FName + ' ' + LName AS FullName FROM TeachingStaff
WHERE MainRole = 'Teacher';
GO

-- WITH CHECK OPTION: View that stores ID, FullName of Clubless students
CREATE VIEW view_clublessstudents AS
SELECT StudentID, FName, LName, Gender FROM Student
WHERE ClubNo IN (SELECT ClubID FROM Club WHERE ClubName = 'Clubless Club')
WITH CHECK OPTION;
GO


-- You cannot insert a student who does not belong to the clubless club in this view
-- INSERT INTO view_clublessstudents (StudentID, FName, LName, Gender) VALUES
-- ('S115', 'Oka', 'Ruto', 'F');
-- GO


-- WITH CHECK OPTION: View that stores the grade of student Ayano Aishi
CREATE VIEW view_mygrade AS
SELECT StudentID, SubjectID, Grade FROM StudentGrade 
WHERE StudentID IN (SELECT StudentID FROM Student WHERE (FName = 'Ayano' AND LName = 'Aishi'))
WITH CHECK OPTION;
GO



-- WITH CHECK OPTION: View that stores the class taught by Ms. Mida Rana
CREATE VIEW view_MidaRanaClass AS
SELECT ClassID, ClassName, TeacherID FROM Class 
WHERE TeacherID IN (SELECT StaffID FROM TeachingStaff WHERE (FName = 'Mida' AND LName = 'Rana'))
WITH CHECK OPTION;
GO

SELECT * FROM view_MidaRanaClass

-- Valid Insert by WITH CHECK OPTION, but violate trigger
INSERT INTO view_MidaRanaClass (ClassID, ClassName, TeacherID) VALUES
('C035', '3-5', 'T107');
GO

-- INSERT or UPDATE raises error if the TeacherID is not Mida Rana
-- This violate WITH CHECK OPTION
INSERT INTO view_MidaRanaClass (ClassID, ClassName, TeacherID) VALUES
('C035', '3-5', 'T101');
GO


-- WITH CHECK OPTION: View that stores the rivals, their main persona is lovestruck
CREATE VIEW view_rivals AS
SELECT FName + ' ' + LName AS Rival FROM Student WHERE MainPersona = 'Lovestruck'
UNION
SELECT FName + ' ' + LName AS Rival FROM TeachingStaff WHERE MainPersona = 'Lovestruck'
WITH CHECK OPTION;
GO

-- View that stores the student name, the average grade, and their GradeLevel
CREATE VIEW view_studentgradelevel AS
SELECT s.FName + ' ' + s.LName AS StudentName, AVG(sg.Grade) AS AVGGrade,
CASE 
    WHEN AVG(sg.Grade) >= 8.0 THEN 'A'
    WHEN AVG(sg.Grade) >= 6.5 THEN 'B'
    WHEN AVG(sg.Grade) >= 4.0 THEN 'C'
    WHEN AVG(sg.Grade) < 4.0 THEN 'D'
    ELSE 'F'
END AS GradeLevel
FROM StudentGrade sg  
JOIN Student s ON s.StudentID = sg.StudentID GROUP BY s.FName, s.LName;
GO

-- View that returns the student and their birthday, separate to parts
CREATE VIEW view_studentbirthday AS
SELECT FName + ' ' + LName AS FullName, 
DATEPART(YEAR, Birthday) AS Year, 
DATEPART(MONTH, Birthday) AS Month, 
DATEPART(DAY, Birthday) AS Day
FROM Student;
GO

-- View that returns the student and their age
CREATE VIEW view_studentage AS
SELECT FName + ' ' + LName AS FullName, 
DATEDIFF(YEAR, Birthday, GETDATE()) AS Age
FROM Student;
GO

-- View that returns 'Above Class Average' if the student average score is higher than their class average score
-- Return 'Below Class Average' otherwise
CREATE VIEW view_studentwithClassAverage AS
SELECT s1.Fname + ' ' + s1.LName AS StudentName, s1.ClassNo, c1.ClassName, AVG(sg1.Grade) AS AVGGrade,
IIF(AVG(sg1.Grade) >= (
    SELECT(AVG(sg2.Grade)) FROM StudentGrade sg2
    JOIN Student s2 ON s2.StudentID = sg2.StudentID
    JOIN Class c2 ON c2.ClassID = s2.ClassNo
    WHERE s2.ClassNo = s1.ClassNo
    ), 'Above Class Average', 'Below Class Average')
    AS StudentPerformance
FROM StudentGrade sg1
JOIN Student s1 ON s1.StudentID = sg1.StudentID
JOIN Class c1 ON c1.ClassID = s1.ClassNo
GROUP BY s1.Fname, s1.Lname, s1.ClassNo, c1.ClassName;
GO

-- View: Compare 'Ayano Aishi' Score with every student score
-- If not equal, return '1'; equal, return '0', using NULLIF
-- Then compare if the score is higher or lower, return 1 or 0 for both cases
CREATE VIEW view_mygradewithstudent AS
SELECT 
s1.Fname + ' ' + s1.LName AS MyName, 
AVG(sg1.Grade) AS MyScore,
s2.Fname + ' ' + s2.LName AS StudentName,
AVG(sg2.Grade) AS StudentScore,
IIF(AVG(sg1.Grade) > AVG(sg2.Grade), '1', '0') AS HigherScore,
IIF(AVG(sg1.Grade) < AVG(sg2.Grade), '1', '0') AS LowerScore,
CASE 
   WHEN NULLIF(AVG(sg1.Grade), AVG(sg2.Grade)) IS NULL THEN '1'
   ELSE '0'
   END AS EqualScore
FROM Student s1
JOIN Student s2 ON s1.StudentID <> s2.StudentID
JOIN StudentGrade sg1 ON sg1.StudentID = s1.StudentID
JOIN StudentGrade sg2 ON sg2.StudentID = s2.StudentID
WHERE sg1.SubjectID = sg2.SubjectID 
AND s1.StudentID IN (SELECT s1.StudentID FROM Student s1 WHERE (s1.FName = 'Ayano' AND s1.LName = 'Aishi'))
GROUP BY s1.Fname, s1.Lname, s2.Fname, s2.Lname;
GO

-- VIew: Class and AVGGrade
CREATE VIEW view_classAVGGrade AS
SELECT c.ClassName, AVG(sg.Grade) AS AVGGrade
FROM Class c 
JOIN Student s ON s.ClassNo = c.ClassID
JOIN StudentGrade sg ON sg.StudentID = s.StudentID
GROUP BY c.ClassName;
GO
