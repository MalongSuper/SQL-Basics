-- Queries
USE AkademiHighSchool;
GO


SELECT GETDATE() AS CurrentDate;
GO

SELECT 
DATENAME(YEAR, GETDATE()) AS Year, 
DATENAME(MONTH, GETDATE()) AS Month, 
DATENAME(DAYOFYEAR, GETDATE()) AS DayofYear,
DATENAME(DAY, GETDATE()) AS Day,       
DATENAME(WEEK, GETDATE()) AS Week,      
DATENAME(WEEKDAY, GETDATE()) AS DayOfTheWeek,    
DATENAME(HOUR, GETDATE()) AS Hour,  
DATENAME(MINUTE, GETDATE()) AS Minute,   
DATENAME(SECOND, GETDATE()) AS Second;
GO


SELECT 
DATEPART(YEAR, GETDATE()) AS Year, 
DATEPART(MONTH, GETDATE()) AS Month, 
DATEPART(DAYOFYEAR, GETDATE()) AS DayofYear,
DATEPART(DAY, GETDATE()) AS Day,       
DATEPART(WEEK, GETDATE()) AS Week,      
DATEPART(WEEKDAY, GETDATE()) AS DayOfTheWeek,    
DATEPART(HOUR, GETDATE()) AS Hour,  
DATEPART(MINUTE, GETDATE()) AS Minute,   
DATEPART(SECOND, GETDATE()) AS Second;
GO


SELECT 
DAY(GETDATE()) AS Day, 
MONTH(GETDATE()) AS Month,                      
YEAR(GETDATE()) AS Year;
GO


SELECT *, DATEFROMPARTS(2026, 01, 01) AS DueDate FROM Student;
GO

-- Return the Age of every student based on the current date and their birthdays.
SELECT FName + ' ' + LName AS StudentName, Birthday, DATEDIFF(YEAR, Birthday, GETDATE()) AS Age
FROM Student;
GO

-- Return the year that every student will have finished the middle school year
-- assuming they graduated at 18.
SELECT FName + ' ' + LName AS StudentName, Birthday, 
DATEPART(YEAR, DATEADD(YEAR, 18, Birthday)) AS GraduationYear
FROM Student;
GO

-- Return the FName and LName of the student in ASCII code
SELECT ASCII(FName) AS ASCIIFName, ASCII(LName) AS ASCIILName FROM Student;
GO

-- Return the FName and LName of the student in UNICODE.
SELECT UNICODE(FName) AS UNICODEFName, UNICODE(LName) AS UNICODELName FROM Student;
GO

-- Return every student whose character starts from 50 to 70 in ASCII Code
SELECT FName, LName, CHAR(ASCII(LEFT(FName, 1))) AS FirstFName 
FROM Student WHERE ASCII(LEFT(FName, 1)) BETWEEN 50 AND 70;
GO

-- Return every student and the first letter, last letter, using NCHAR
SELECT FName, LName, 
NCHAR(UNICODE(LEFT(FName, 1))) AS FirstFName, 
NCHAR(UNICODE(LEFT(LName, 1))) AS FirstLName, 
NCHAR(UNICODE(UPPER(RIGHT(FName, 1)))) AS LastFName, 
NCHAR(UNICODE(UPPER(RIGHT(LName, 1)))) AS LastLName
FROM Student;
GO

-- Get the position of 'na', 'ta', 'sa', 'ma', 'ya' in the first name and in the last name
SELECT 
CHARINDEX('na', FName, 1) AS FNamewithNa, CHARINDEX('na', LName, 1) AS LNamewithNa,
CHARINDEX('ta', FName, 1) AS FNamewithTa, CHARINDEX('ta', LName, 1) AS LNamewithTa,
CHARINDEX('sa', FName, 1) AS FNamewithSa, CHARINDEX('sa', LName, 1) AS LNamewithSa,
CHARINDEX('ma', FName, 1) AS FNamewithMa, CHARINDEX('ma', LName, 1) AS LNamewithMa,
CHARINDEX('ya', FName, 1) AS FNamewithYa, CHARINDEX('ya', LName, 1) AS LNamewithYa
FROM Student;
GO

-- Concatenate FName, LName and the ClassName of the student
SELECT CONCAT(s.FName, s.LName, c.ClassName) AS StudentwithClass FROM Student s 
JOIN Class c ON c.ClassID = s.ClassNo;
GO

-- Concatenate FName, LName and the ClassName of the teacher.
SELECT CONCAT(t.FName, t.LName, c.ClassName) AS TeacherwithClass FROM TeachingStaff t 
JOIN Class c ON c.TeacherID = t.StaffID;
GO



-- Get the total sum of bytes used in the combination of FName and LName
SELECT SUM(DATALENGTH(FName + LName)) AS TotalDataLength FROM Student;
GO

-- Return the length of the name of FName and LName
SELECT FName, LName, LEN(FName + LName) AS TotalStringLength FROM Student;
GO

-- Return the first and last three characters of the combination of first name and last name
-- of every student
SELECT 
LEFT(Fname + LName, 3) AS FirstThreeChars, 
RIGHT(FName + LName, 3) AS LastThreeChars 
FROM Student;
GO

-- Return the name in uppercase and lowercase
SELECT 
UPPER(Fname + ' ' + LName) AS UpperChars, 
LOWER(Fname + ' ' + LName) AS LowerChars 
FROM Student;
GO

-- Remove spaces from the name
-- TRIM does not work with two strings with space between them
SELECT 
TRIM(' ' + FName + LName + ' ') AS TrimChars, 
LTRIM(' ' + FName + LName + ' ') AS LTrimChars, 
RTRIM(' ' + FName + LName + ' ') AS RTrimChars,
TRIM(FName + ' ' + LName) AS TrimMiddleChars
FROM Student;
GO

-- Replace every 'o' to 'a'
SELECT REPLACE(FName + ' ' + LName, 'o', 'a') AS ReplaceChars FROM Student;
GO


-- Replicate the teacher name three times with spaces
SELECT REPLICATE(FName + ' ' + LName + ' ', 3) AS ReplicateChars FROM Student;
GO

-- Reverse the student name
SELECT REVERSE(FName + ' ' + LName) AS ReverseChars FROM Student;
GO

-- Get the three middle characters in the character name
SELECT SUBSTRING(FName + LName, 3, 3) FROM Student;
GO

-- Convert the last three values of the ClassID to integer, for instance, 'C011' returns 11
SELECT ClassID, CAST(RIGHT(ClassID, 3) AS INT) AS ClassNumber FROM Class;
GO

SELECT ClassID, CONVERT(INT, RIGHT(ClassID, 3)) AS ClassNumber FROM Class;
GO

-- Return NULL if all these columns are NULL, else, the first column is returned
SELECT COALESCE(FName, LName, MainRole) FROM TeachingStaff;
GO

-- Return None if a teaching staff has no class
SELECT t.FName, t.LName, ISNULL(ClassID, 'None') AS Class FROM TeachingStaff t 
LEFT JOIN Class c ON t.StaffID = c.TeacherID;
GO

-- Return 1 if any of the following columns in the StudentGrade table is numeric
SELECT 
ISNUMERIC(StudentID) AS StudentID, ISNUMERIC(Grade) AS Grade
FROM StudentGrade;
GO

-- Return 'Above Class Average' if the student average score is higher than their class average score
-- Return 'Below Class Average' otherwise
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


-- Compare 'Ayano Aishi' Score with every student score
-- If not equal, return '1'; equal, return '0', using NULLIF
-- Then compare if the score is higher or lower, return 1 or 0 for both cases
SELECT 
s1.Fname + ' ' + s1.LName AS StudentName1, 
AVG(sg1.Grade) AS StudentScore,
s2.Fname + ' ' + s2.LName AS StudentName2,
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
GROUP BY s1.Fname, s1.Lname, s2.Fname, s2.Lname
GO

-- Return the absolute value of -1.
SELECT ABS(-1)
GO

-- Return the student’s grade raised two the power of 3.
SELECT s.FName + ' ' + s.LName AS StudentName, POWER(AVG(sg.Grade), 3) AS AVGGradePoweredby3 
FROM StudentGrade sg 
JOIN Student s ON s.StudentID = sg.StudentID
GROUP BY s.FName, s.LName;
GO

-- Return the square of the student’s grade.
SELECT s.FName + ' ' + s.LName AS StudentName, SQUARE(AVG(sg.Grade)) AS SquaredAVGGrade
FROM StudentGrade sg 
JOIN Student s ON s.StudentID = sg.StudentID
GROUP BY s.FName, s.LName;
GO

-- Return the student’s grade of every student, rounded to 1 decimal piece.
SELECT s.FName + ' ' + s.LName AS StudentName, ROUND(AVG(sg.Grade), 1) AS AVGGrade 
FROM StudentGrade sg 
JOIN Student s ON s.StudentID = sg.StudentID
GROUP BY s.FName, s.LName;
GO

-- Returns the smallest integer value that is larger than or equal to the student's avg grade
SELECT s.FName + ' ' + s.LName AS StudentName, CEILING(AVG(sg.Grade)) AS AVGGradeRoundUp
FROM StudentGrade sg 
JOIN Student s ON s.StudentID = sg.StudentID
GROUP BY s.FName, s.LName;
GO

-- Returns the largest integer value that is less than or equal to the student's avg grade
SELECT s.FName + ' ' + s.LName AS StudentName, FLOOR(AVG(sg.Grade)) AS AVGGradeRoundDown 
FROM StudentGrade sg 
JOIN Student s ON s.StudentID = sg.StudentID
GROUP BY s.FName, s.LName;
GO

-- Generate a decimal number within range [5, 10)
SELECT RAND() * (10 - 5) + 5;
GO

-- Generate a decimal number within range (5, 10)
SELECT RAND() * (10 - 5 - (1e - 9)) + (5 + (1e + 9));
GO

-- Generate a decimal number within range (5, 10]
SELECT 10 - RAND() * (10 - 5 - (1e - 9));
GO

-- Generate a decimal number within range [5, 10]
SELECT RAND() * (10 - 5 + (1e - 9)) + 5;
GO

-- Generate a nondecimal number within range [5, 10)
SELECT FLOOR(RAND() * (10 - 5) + 5);
GO

-- Return the logarithm of the average grade to base 2 and base 10
SELECT s.FName + ' ' + s.LName AS StudentName, 
LOG(AVG(sg.Grade), 2) AS AVGGradeLog2, LOG10(AVG(sg.Grade)) AS AVGGradeLog10
FROM StudentGrade sg 
JOIN Student s ON s.StudentID = sg.StudentID
GROUP BY s.FName, s.LName;
GO

-- Return sine, cosine, tangent, and cotangent of the number, respectively.
SELECT s.FName + ' ' + s.LName AS StudentName, 
SIN(AVG(sg.Grade)) AS AVGGradeSin, COS(AVG(sg.Grade)) AS AVGGradeCos,
TAN(AVG(sg.Grade)) AS AVGGradeTan, COT(AVG(sg.Grade)) AS AVGGradeCot
FROM StudentGrade sg 
JOIN Student s ON s.StudentID = sg.StudentID
GROUP BY s.FName, s.LName;
GO

-- Return Degrees and Radians of the average grade, respectively.
SELECT s.FName + ' ' + s.LName AS StudentName, 
DEGREES(AVG(sg.Grade)) AS AVGGradeDegrees, 
RADIANS(AVG(sg.Grade)) AS AVGGradeRadians
FROM StudentGrade sg 
JOIN Student s ON s.StudentID = sg.StudentID
GROUP BY s.FName, s.LName;
GO

-- Return the Square Root of the average grade
SELECT s.FName + ' ' + s.LName AS StudentName, 
SQRT(AVG(sg.Grade)) AS AVGGradeSquareRoot
FROM StudentGrade sg 
JOIN Student s ON s.StudentID = sg.StudentID
GROUP BY s.FName, s.LName;
GO