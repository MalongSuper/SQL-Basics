INSERT INTO Employee(FName, Minit, LName, SSN, BDate, Address, Sex, Salary, Super_SSN, DNo) 
VALUES ('James', 'A', 'Charles', '999887788', '7-31-1972', 'Spring, TX', 'M', NULL, NULL, NULL);
SELECT FName, Minit, LName, SSN, Address FROM Employee WHERE BDate = '7-31-1972';
GO