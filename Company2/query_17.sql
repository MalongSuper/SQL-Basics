SELECT * FROM Employee WHERE (FName LIKE 'A%' OR FName LIKE 'E%' 
OR FName LIKE 'I%' OR FName LIKE 'O%' OR FName LIKE 'U%') AND (Sex = 'F') AND (Salary <= 30000);
GO
