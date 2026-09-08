SELECT PName, DNum FROM Project
SELECT Dname, DNumber FROM Department
SELECT PName, DName FROM Project, Department
SELECT * FROM Project p JOIN Department d ON p.DNum = d.DNumber
-- Matching Rows
SELECT PName AS Project_Name, DName AS Department FROM Project p 
JOIN Department d ON p.DNum = d.DNumber