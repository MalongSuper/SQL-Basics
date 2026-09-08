-- Retrieve SSN and Address of employee whose BDate, or SuperSSN is NULL
SELECT FName, Minit, LName, SSN, Address FROM Employee WHERE (BDate is NULL OR Super_SSN is NULL);
GO
