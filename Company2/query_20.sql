SELECT FName, Minit, LName, Address, BDate FROM Employee WHERE DATEPART(year, BDate) >= 1945;
GO