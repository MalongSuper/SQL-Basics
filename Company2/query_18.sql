INSERT INTO Employee(FName, Minit, LName, SSN, BDate, Address, Sex, Salary, Super_SSN, DNo) 
VALUES ('Masha', 'A', 'Jennifrez', '999887799', '7-4-1972', 'Spring, TX', 'F', 34000, '333445555', 4);
SELECT * FROM Employee WHERE (Minit LIKE 'U%' 
OR Minit LIKE 'E%' OR Minit LIKE 'O%' OR Minit LIKE 'A%' OR Minit LIKE 'I%') 
AND Sex = 'F' AND Salary >= 30000 AND (DNo = 4 OR DNo = 5);
GO