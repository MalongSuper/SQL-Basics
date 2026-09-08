SELECT d.DName AS Dept_Name, COUNT(SSN) AS Num_of_Employees, AVG(Salary) AS Avg_Salary FROM Employee e 
JOIN Department d ON d.DNumber = e.DNo GROUP BY d.DName;
GO
-- Instead of e.DNo since we want to get the Dept_Name