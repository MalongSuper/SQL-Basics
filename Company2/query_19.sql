INSERT INTO Employee(FName, Minit, LName, SSN, BDate, Address, Sex, Salary, Super_SSN, DNo)
VALUES ('Jimmy', 'C', 'Earl', '999888899', '6-4-1959', 'Spring, TX', 'F', 30000, '333445555', 4);
SELECT FName, LName, Address, BDate FROM Employee WHERE BDate BETWEEN '6-1-1959' AND '12-31-1959';
GO
