-- Query
USE GradeManagement;
GO

-- 1) Find all classes of Semester 25.1A
SELECT ClassCode FROM Class WHERE Semester = N'25.1A'
GO

-- English translation of the original exercise comment.
SELECT DISTINCT st.StudentId, st.FullName FROM Enrollment e 
JOIN Class c ON c.ClassCode = e.ClassCode
JOIN Subject sb ON sb.SubjectCode = c.SubjectCode
JOIN Student st ON st.StudentId = e.StudentId
WHERE sb.SubjectName = N'Cơ sở dữ liệu'
GO

-- 3) COUNT the total number of classes each semester
SELECT Semester, COUNT(ClassCode) AS NumberofClasses FROM Class
GROUP BY Semester
GO

-- 4) Find all students who study courses whose score are below 5
SELECT st.StudentId, st.FullName, e.ClassCode, e.Grade FROM Enrollment e
JOIN Student st ON st.StudentId = e.StudentId
WHERE e.Grade < 5
GO

-- 5) Find all the classes of Number of student less than 2
SELECT ClassCode, COUNT(StudentID) AS NumberofStudents FROM Enrollment GROUP BY ClassCode
GO

-- 6) Find all pair of classes with the same subject, same lecturer, same semester
SELECT * FROM Class c1 JOIN Class c2 ON c1.SubjectCode = c2.SubjectCode
AND c1.Lecturer = c2.Lecturer AND c1.Semester = c2.Semester
AND c1.ClassCode <> c2.ClassCode
GO

-- Only retrieve non-duplicate
SELECT * FROM Class c1 JOIN Class c2 ON c1.SubjectCode = c2.SubjectCode
AND c1.Lecturer = c2.Lecturer AND c1.Semester = c2.Semester
AND c1.ClassCode < c2.ClassCode
GO
