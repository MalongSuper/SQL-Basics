USE GradeManagement;
GO

-- Find the student who studies at both 'IT201DV01_01' OR 'IT101DV01_01'
SELECT * FROM Enrollment WHERE ClassCode = 'IT201DV01_01'
UNION
SELECT * FROM Enrollment WHERE ClassCode = 'IT101DV01_01'

SELECT StudentID FROM Enrollment WHERE ClassCode = 'IT201DV01_01'
UNION
SELECT StudentID FROM Enrollment WHERE ClassCode = 'IT101DV01_01'

-- Find the student who studies at both 'IT201DV01_01' AND 'IT101DV01_01'
SELECT * FROM Enrollment WHERE ClassCode = 'IT201DV01_01'
INTERSECT 
SELECT * FROM Enrollment WHERE ClassCode = 'IT101DV01_01'

SELECT StudentID FROM Enrollment WHERE ClassCode = 'IT201DV01_01'
INTERSECT 
SELECT StudentID FROM Enrollment WHERE ClassCode = 'IT101DV01_01'

-- Find the student who studies at 'IT201DV01_01' BUT NOT 'IT101DV01_01'
SELECT StudentID FROM Enrollment WHERE ClassCode = 'IT201DV01_01'
EXCEPT
SELECT StudentID FROM Enrollment WHERE ClassCode = 'IT101DV01_01'

SELECT * FROM Enrollment WHERE ClassCode = 'IT201DV01_01'
EXCEPT
SELECT * FROM Enrollment WHERE ClassCode = 'IT101DV01_01'


-- Find the student and the subject that student has not studied
-- Use Cross Join, EXCEPT
SELECT e.StudentID, sb.SubjectName FROM (SELECT DISTINCT StudentID FROM Enrollment) e 
CROSS JOIN (SELECT DISTINCT SubjectName FROM Subject) sb
EXCEPT
SELECT DISTINCT e.StudentID, sb.SubjectName FROM Enrollment e 
JOIN Class c ON c.ClassCode = e.ClassCode JOIN Subject sb ON sb.SubjectCode = c.SubjectCode


-- Find the student who participates in a class with
SELECT COUNT(ClassCode) FROM Enrollment GROUP BY ClassCode
SELECT ClassCode, COUNT(StudentID) FROM Enrollment GROUP BY ClassCode HAVING COUNT(StudentID) <= 2
SELECT * FROM Enrollment

SELECT StudentID, ClassCode FROM Enrollment 
WHERE ClassCode IN (SELECT ClassCode FROM Enrollment GROUP BY ClassCode HAVING COUNT(StudentID) <= 2)

-- English translation of the original exercise comment.
SELECT e.StudentID, c.ClassCode, s.SubjectName, e.Grade FROM Enrollment e JOIN Class c ON c.ClassCode = e.ClassCode
JOIN Subject s ON s.SubjectCode = c.SubjectCode

SELECT e.StudentID, c.ClassCode, s.SubjectName, e.Grade FROM Enrollment e JOIN Class c ON c.ClassCode = e.ClassCode
JOIN Subject s ON s.SubjectCode = c.SubjectCode WHERE s.SubjectName = N'Cơ sở dữ liệu' 

SELECT e.StudentID, c.ClassCode, s.SubjectName, e.Grade FROM Enrollment e JOIN Class c ON c.ClassCode = e.ClassCode
JOIN Subject s ON s.SubjectCode = c.SubjectCode WHERE s.SubjectName = N'Nhập môn lập trình' AND e.Grade < 5


SELECT * FROM Enrollment e1 JOIN Enrollment e2 ON e1.StudentID = e2.StudentID 
WHERE e1.ClassCode <> e2.ClassCode AND e1.ClassCode LIKE 'IT101DV01%'
AND e2.ClassCode LIKE 'IT201DV01%'

SELECT e.StudentID, c.ClassCode, s.SubjectName, e.Grade FROM Enrollment e JOIN Class c ON c.ClassCode = e.ClassCode
JOIN Subject s ON s.SubjectCode = c.SubjectCode WHERE s.SubjectName = N'Cơ sở dữ liệu' AND e.StudentID IN 
(SELECT e.StudentID FROM Enrollment e JOIN Class c ON c.ClassCode = e.ClassCode
JOIN Subject s ON s.SubjectCode = c.SubjectCode WHERE s.SubjectName = N'Nhập môn lập trình' AND e.Grade < 5)
