-- Queries
USE AkademiHighSchool;
GO

-- Retrieve all records from the student table
SELECT * FROM Student;
GO

-- Retrieve all records from the club table
SELECT * FROM Club;
GO

-- Retrieve the classid, classname from the Class table
SELECT ClassID, ClassName FROM Class;
GO

-- Retrieve every female student in the school
SELECT StudentID, FName, LName FROM Student WHERE Gender = 'F';
GO

-- Retrieve all records of the cooking club
SELECT * FROM Club WHERE ClubName = 'Cooking Club';
GO

-- Retrieve all records of the staffs who are not teachers.
SELECT * FROM TeachingStaff WHERE NOT MainRole = 'Teacher';
GO

-- Retrieve information of every student who is a female and has no club.
SELECT * FROM Student WHERE (Gender = 'F' AND ClubNo IS NULL);
GO

-- Retrieve information of every student who is from Class 2-2 or Class 3-2.
SELECT * FROM Student WHERE (ClassNo = 'C022' OR ClassNo = 'C032');
GO

-- Retrieve information of every student who has a subject grade between 9.0 and 10.0
SELECT * FROM StudentGrade WHERE (Grade BETWEEN 9.0 AND 10.0);
GO

-- Get all the unique MainPersona in the Student Table
SELECT DISTINCT MainPersona FROM Student;
GO

-- Get all the unique Strength in the Student Table
SELECT DISTINCT Strength FROM Student;
GO

-- Create a temp table that stores the StudentID, FName, and LName 
-- of every student who has a club in the school.
SELECT StudentID, FName, LName INTO temp_StudentName FROM Student WHERE ClubNo IS NOT NULL;
GO



-- Retrieve every student from class 1-1, 2-2, and 3-3.
SELECT * FROM Student WHERE ClassNo IN ('C011', 'C022', 'C033');
GO

-- Retrieve the student who are female and club leaders.
SELECT * FROM Student WHERE Gender = 'F' AND StudentID IN (SELECT ClubLeaderID FROM Club);
GO

-- Retrieve the name of the teacher who teaches class 2-2.
SELECT StaffID, FName, LName FROM TeachingStaff WHERE StaffID 
IN (SELECT TeacherID FROM Class WHERE ClassID = 'C022');
GO

-- Retrieve the Student from Class 2-2 who is not a Club Leader
SELECT * FROM Student WHERE (ClassNo = 'C022' AND StudentID 
NOT IN (SELECT ClubLeaderID FROM Club));
GO

-- Retrieve the student with FName starts with the letter 'A'
SELECT * FROM Student WHERE FName LIKE 'a%';
GO

-- Retrieve the student with FName starts with the letter 'A'
SELECT * FROM Student WHERE LName LIKE '%u%';
GO

-- Retrieve the student whose LName contains the phrase ‘UN’.
SELECT * FROM Student WHERE LName LIKE '%un%';
GO

-- Retrieve the student whose FName ends with the phrase ‘DO’.
SELECT * FROM Student WHERE FName LIKE '%do';
GO


-- Return every student whose FName starts with C and are at least four characters long (three underscores).
SELECT * FROM Student WHERE FName LIKE 'c___%';
GO

-- Retrieve every student whose FName starts with B and a random word after, 
-- ends with a random word and O after, and there can be any words between.
SELECT * FROM Student WHERE FName LIKE 'b_%_o';
GO

-- Retrieve every student whose LName has the second letter is ‘A’
SELECT * FROM Student WHERE LName LIKE '_a%';
GO

-- Retrieve every student whose FName is ‘Hanako’
SELECT * FROM Student WHERE FName LIKE 'hanako';
GO

-- Return the leader of the Gardening Club using WHERE EXISTS
SELECT StudentID, FName, LName FROM Student 
WHERE EXISTS (SELECT * FROM Club WHERE Club.ClubLeaderID = Student.StudentID 
AND ClubName = 'Gardening Club');
GO

-- Return the leader of the Drama Club using WHERE EXISTS
SELECT StudentID, FName, LName FROM Student 
WHERE EXISTS (SELECT * FROM Club WHERE Club.ClubLeaderID = Student.StudentID
AND ClubName = 'Drama Club');
GO

-- Retrieve the FName and LName of all the club leaders
SELECT s.FName, s.LName FROM Student s 
JOIN Club c ON c.ClubLeaderID = s.StudentID;
GO

-- Retrieve the teacher's name of every classroom
SELECT t.FName, t.LName, c.ClassName FROM Class c 
JOIN TeachingStaff t ON t.StaffID = c.TeacherID;
GO

-- Retrieve the FName and LName of every female student who is taught by Ms. Kaho Kanokogi.
SELECT s.FName, s.LName FROM Student s 
JOIN Class c ON c.ClassID = s.ClassNo 
JOIN TeachingStaff t ON c.TeacherID = t.StaffID 
WHERE s.Gender = 'F' AND (t.FName  = 'Kaho' AND t.LName = 'Kanokogi');
GO

-- Retrieve the FName, LName, and their club name, include student without a club
SELECT s.FName, s.LName, c.ClubName FROM Student s
LEFT JOIN Club c ON c.ClubID = s.ClubNo

-- Retrieve the Teaching Staff name and their class
SELECT t.FName, t.LName, c.ClassName FROM Class c 
RIGHT JOIN TeachingStaff t ON t.StaffID = c.TeacherID;
GO

-- Return the FName, LName of every female student, the ClubName and the ClubLeaderID. 
-- For a student with no club, the ClubName is NULL, and if the student is in a club, 
-- return NULL if she is not the club leader. Else, return the ClubLeaderID
-- This problem is solved with FULL JOINs.
SELECT s.FName, s.LName, c1.ClubName, c2.ClubLeaderID FROM Student s 
FULL JOIN Club c1 ON c1.ClubID = s.ClubNo
FULL JOIN Club c2 ON c2.ClubLeaderID = s.StudentID
WHERE s.Gender = 'F';
GO

-- Return the FName, LName of the non-club leader student and their club leader FName, LName.
-- AS is used to assign an alias to the column name
SELECT s1.FName AS StudentFName, s1.LName AS StudentLName, c.ClubName, 
s2.FName AS LeaderFName, s2.LName AS LeaderLName FROM Student s1
JOIN Club c ON c.ClubID = s1.ClubNo
JOIN Student s2 ON c.ClubLeaderID = s2.StudentID
WHERE NOT s1.StudentID = c.ClubLeaderID;
GO

-- Retrieve all students who are club leaders and 
-- taught by Ms. Kaho Kanokogi
SELECT s.StudentID, s.FName, s.LName, s.Strength FROM Student s 
JOIN Club c ON c.ClubLeaderID = s.StudentID
JOIN Class cs ON s.ClassNo = cs.ClassID 
JOIN TeachingStaff t ON t.StaffID = cs.TeacherID
WHERE (t.FName = 'Kaho' AND t.LName = 'Kanokogi');
GO


-- Filter out every pair of male-female students who are in the same club
SELECT * FROM Student s1 JOIN Student s2 ON s1.ClubNo = s2.ClubNo
WHERE s1.Gender = 'F' AND s2.Gender = 'M';
GO

-- Cartesian Product of TeachingStaff and Class table
SELECT * FROM TeachingStaff CROSS JOIN Class;
GO

-- Get the full name of every student with MainPersona “Lovestruck”
-- The column name is StudentRivalName
-- The single-quote mark create a space between the string
SELECT FName + ' ' + LName AS StudentRivalName FROM Student
WHERE MainPersona = 'Lovestruck';
GO

-- Retrieve every male student’s grade with 1.0 increase if it is less than 6.0.
SELECT s.FName, s.LName, sg.Grade + 1.0 AS GradeIncrease FROM StudentGrade sg
JOIN Student s ON sg.StudentID = s.StudentID 
WHERE (s.Gender = 'M' AND sg.Grade < 6.0);
GO

-- Retrieve the gaming club student grade but deduct 0.5 for every subject.
SELECT s.FName, s.LName, sg.Grade - 0.5 AS GradeDecrease FROM StudentGrade sg
JOIN Student s ON sg.StudentID = s.StudentID 
JOIN Club c ON c.ClubID = s.ClubNo
WHERE c.ClubName = 'Gaming Club';
GO

-- 15% increase for all club leaders for the subject grade lower than 8.0
SELECT s.FName, s.LName, sg.Grade + (sg.Grade * 0.15) AS GradeFifteenPercIncrease 
FROM StudentGrade sg 
JOIN Student s ON sg.StudentID = s.StudentID 
JOIN Club c ON c.ClubLeaderID = sg.StudentID
WHERE sg.Grade < 8.0;
GO

-- Return every student name, the subject name, and the grade that they score above or equal to 9.5.
SELECT s.FName + ' ' + s.LName AS StudentName, st.SubjectName, sg.Grade FROM Student s
JOIN StudentGrade sg ON sg.StudentID = s.StudentID
JOIN Subject st ON st.SubjectID = sg.SubjectID
WHERE sg.Grade >= 9.5;
GO

-- Return every student who precedes the student FName ‘Hanako’.
SELECT FName + ' ' + LName AS StudentName FROM Student WHERE FName < 'Hanako';
GO

-- Return every student who succeeds the student FName ‘Taro’.
SELECT FName + ' ' + LName AS StudentName FROM Student WHERE FName > 'Taro';
GO

-- Retrieve the sum of grades of every female student
SELECT SUM(Grade) AS TotalGrade FROM StudentGrade sg
JOIN Student s ON s.StudentID = sg.StudentID
WHERE s.Gender = 'F';
GO

-- Retrieve the average of grades of every female student
SELECT AVG(Grade) AS FemaleAVGGrade FROM StudentGrade sg
JOIN Student s ON s.StudentID = sg.StudentID
WHERE s.Gender = 'F';
GO

-- Retrieve the average of grades of every male student
SELECT AVG(Grade) AS MaleAVGGrade FROM StudentGrade sg
JOIN Student s ON s.StudentID = sg.StudentID
WHERE s.Gender = 'M';
GO

-- Retrieve the maximum and the minimum student grades.
SELECT MAX(Grade) AS MaxGrade, MIN(Grade) AS MinGrade FROM StudentGrade;
GO

-- Return the total number of students.
SELECT COUNT(*) AS TotalNumberofStudents FROM Student;
GO

-- Return the total number of female students.
SELECT COUNT(*) AS TotalNumberofStudents FROM Student WHERE Gender = 'F';
GO

-- Return the total number of male students.
SELECT COUNT(*) AS TotalNumberofStudents FROM Student WHERE Gender = 'M';
GO

-- Return the total number of students in every classroom
SELECT c.ClassName, COUNT(s.StudentID) AS NumberofStudents FROM Class c
JOIN Student s ON s.ClassNo = c.ClassID GROUP BY c.ClassName;
GO

-- Return the number of students in every club without the club leader
SELECT c.ClubName, COUNT(s.StudentID) AS NumofMembers FROM Student s
JOIN Club c ON c.ClubID = s.ClubNo WHERE s.StudentID <> c.ClubLeaderID
GROUP BY c.ClubName;
GO

-- Return every student whose average grade is greater or equal to 8.0
SELECT s.StudentID, s.FName + ' ' + s.LName AS StudentName, AVG(sg.Grade) AS AVGGrade 
FROM Student s JOIN StudentGrade sg
ON s.StudentID = sg.StudentID 
GROUP BY s.StudentID, s.FName, s.LName HAVING AVG(sg.Grade) >= 8.0;
GO

-- Return every club with at least two male members, not including the club leader.
SELECT c.ClubName, COUNT(StudentID) AS NumofMales FROM Club c
JOIN Student s ON s.ClubNo = c.ClubID
WHERE c.ClubLeaderID <> s.StudentID AND Gender = 'M'
GROUP BY c.ClubName, c.ClubID 
HAVING COUNT(StudentID) >= 2;
GO

-- Return the number of members in the club whose club leader is a female.
SELECT c.ClubName, COUNT(s.StudentID) AS NumofMembers FROM Student s
JOIN Club c ON c.ClubID = s.ClubNo
WHERE c.ClubLeaderID IN (SELECT StudentID FROM Student WHERE Gender = 'F')
GROUP BY c.ClubName;
GO

-- Return the total number of students in the school if it exceeds 100. 
-- Else, it is an empty table.
SELECT COUNT(*) AS NumofStudents FROM Student HAVING COUNT(*) > 100;
GO

-- Return the first five ‘Lovestruck’ student in the school.
SELECT TOP 5 * FROM Student WHERE MainPersona = 'Lovestruck';
GO

-- Return the name of the students in alphabetical order.
SELECT * FROM Student ORDER BY FName;
GO

-- Return the student name sorted by Average Grade, from highest to lowest
SELECT s.FName + ' ' + s.LName AS StudentName, AVG(sg.Grade) FROM Student s
JOIN StudentGrade sg ON sg.StudentID = s.StudentID
GROUP BY s.FName, s.LName ORDER BY AVG(sg.Grade) DESC;
GO

-- Return the mean of every club by computing the average of 
-- the average of every member of the club
-- Grouped by club
-- and sort in non-descending order.
SELECT s.StudentID, s.FName, s.LName, c.ClubName, AVG(sg.Grade) AS AVGGrade
INTO temp_ClubMemberGrade FROM StudentGrade sg
JOIN Student s ON s.StudentID = sg.StudentID
JOIN Club c ON c.ClubID = s.ClubNo
GROUP BY s.StudentID, s.LName, s.FName, c.ClubName;
GO

SELECT ClubName, AVG(AVGGrade) AS AVGClubGrade FROM temp_ClubMemberGrade
GROUP BY ClubName ORDER BY AVG(AVGGrade) ASC;
GO

-- Retrieve the top female student in the school based on the average grade
SELECT TOP 3 s.FName + ' ' + s.LName AS StudentName, AVG(sg.Grade) AS AVGGrade 
FROM Student s JOIN StudentGrade sg ON sg.StudentID = s.StudentID 
WHERE s.Gender = 'F'
GROUP BY s.FName, s.LName
ORDER BY AVG(sg.Grade) DESC;
GO


-- Retrieve top five students in the school with the best average student grades
-- Including ties if exist.
SELECT TOP 5 WITH TIES s.FName + ' ' + s.LName AS StudentName, AVG(sg.Grade) AS AVGGrade
FROM Student s JOIN StudentGrade sg ON sg.StudentID = s.StudentID
GROUP BY s.FName, s.LName ORDER BY AVG(sg.Grade) DESC;
GO

-- Retrieve 50% Percent of the Student based on their average grade
SELECT TOP 50 PERCENT s.FName + ' ' + s.LName AS StudentName, AVG(sg.Grade) AS AVGGrade 
FROM Student s JOIN StudentGrade sg ON sg.StudentID = s.StudentID
GROUP BY s.FName, s.LName ORDER BY AVG(sg.Grade) DESC;
GO


-- Get both student and teacher rivals by union both student and teachingstaff table
-- If both queries have aliases, the first table alias is used.
SELECT FName + ' ' + LName AS Rival FROM Student WHERE MainPersona = 'Lovestruck'
UNION
SELECT FName + ' ' + LName AS Rival FROM TeachingStaff WHERE MainPersona = 'Lovestruck';
GO

-- Use INTERSECT to get every StudentID that is common in both
-- Student table and Club table
SELECT StudentID FROM Student
INTERSECT
SELECT ClubLeaderID FROM Club
GO

-- Get the club leader and the club that they do not belong to.
SELECT s.FName, s.LName, c.ClubName FROM Student s CROSS JOIN Club c
WHERE s.StudentID IN (SELECT ClubLeaderID FROM Club)
EXCEPT 
SELECT s.FName, s.LName, c.ClubName FROM Student s JOIN Club c
ON c.ClubID = s.ClubNo
WHERE s.StudentID IN (SELECT ClubLeaderID FROM Club);
GO

-- Get the student name, the average grade, and categorize them into four groups
-- If AVG >= 8.0 -> A; If AVG >= 6.5 -> B; If AVG >= 4.0 -> C; If AVG < 4.0 -> D
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


-- Return the number of students whose StudentID ends with an odd number, 
-- and the number of students whose StudentID ends with an even number.
SELECT 
COUNT(CASE WHEN RIGHT(StudentID, 1) IN ('1', '3', '5', '7', '9') THEN 1 ELSE NULL END) AS OddNumberStudents,
COUNT(CASE WHEN RIGHT(StudentID, 1) IN ('0', '2', '4', '6', '8') THEN 1 ELSE NULL END) AS EvenNumberStudents
FROM Student;
GO

-- This statement returns the total number of rows
SELECT 
COUNT(CASE WHEN RIGHT(StudentID, 1) IN ('1', '3', '5', '7', '9') THEN 1 ELSE 0 END) AS OddNumberStudents,
COUNT(CASE WHEN RIGHT(StudentID, 1) IN ('0', '2', '4', '6', '8') THEN 1 ELSE 0 END) AS EvenNumberStudents
FROM Student;
GO

-- Return the name of every student and the number of students who are in the same club as them
-- Exluding themselves
-- Return 0 if the student has no similar club members
-- Note that COUNT never returns NULL
SELECT s1.StudentID, s1.FName + ' ' + s1.LName AS StudentName, 
CASE 
    WHEN COUNT(s1.StudentID) IS NULL THEN 0
    ELSE COUNT(s1.StudentID)
END AS OtherClubMembers
FROM Student s1
LEFT JOIN Student s2 ON s1.ClubNo = s2.ClubNo AND s1.StudentID <> s2.StudentID
GROUP BY s1.StudentID, s1.FName, s1.LName;
GO


-- Return the FName, LName of every female student, the ClubName and the ClubLeaderID. 
-- For a student with no club, the ClubName is NULL, and if the student is in a club, 
-- return N/A if she is not the club leader. 
SELECT s.FName, s.LName, c1.ClubName, 
CASE WHEN c2.ClubLeaderID IS NULL THEN 'N/A' ELSE c2.ClubLeaderID 
END AS ClubLeaderID
FROM Student s 
FULL JOIN Club c1 ON c1.ClubID = s.ClubNo
FULL JOIN Club c2 ON c2.ClubLeaderID = s.StudentID
WHERE s.Gender = 'F';
GO

-- Return the student who was born in January 1st 2003 or 2004 or 2005.
SELECT * FROM Student WHERE Birthday IN ('01-01-2003', '01-01-2004', '01-01-2005');
GO

-- CROSS JOIN with no self-pairs
SELECT * FROM Student s1 JOIN Student s2 ON s1.StudentID <> s2.StudentID;
GO

