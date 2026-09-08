INSERT INTO Employee(FName, Minit, LName, SSN, BDate, Address, Sex, Salary) VALUES ('Adam', 'C', 'Sorak', '999884377', '1958-04-29', 'Spring, TX', 'M', 29000);
SELECT e.FName, e.Minit, e.LName FROM Employee e 
LEFT JOIN Works_On w ON e.SSN = w.ESSN 
GROUP BY e.FName, e.Minit, e.LName HAVING COUNT(w.PNo) = 0;
GO
