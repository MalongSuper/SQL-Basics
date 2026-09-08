-- SELECT PName, PNumber FROM Project
-- SELECT PNo, SUM(Hours) FROM Works_On GROUP BY PNo
-- Display The project Name
SELECT p.PName as Project_Name, SUM(Hours) as Total_Hours FROM Works_On JOIN Project p ON p.PNumber = PNo GROUP BY p.PName;
GO