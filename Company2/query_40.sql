INSERT INTO Employee(FName, Minit, LName, SSN, BDate, Address, Sex, Salary) VALUES ('Alicia', 'F', 'Daphdia', '999887557', '1957-08-19', 'Spring, TX', 'F', 45000);
SELECT FName, Minit, LName, FORMAT([Salary],'#,##0.0') FROM Employee WHERE Sex = 'F' AND (Salary BETWEEN 30000 AND 50000) ORDER BY Salary ASC;
GO
