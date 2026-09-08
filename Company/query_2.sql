-- Create Employee table
CREATE TABLE Employee (
  FName VARCHAR(50) NOT NULL,
  Minit VARCHAR(50) NOT NULL,
  LName VARCHAR(50) NOT NULL,
  SSN VARCHAR(9) PRIMARY KEY,
  BDate DATE NOT NULL,
  Address VARCHAR(100) NOT NULL,
  Sex CHAR(1) NOT NULL,
  Salary NUMERIC(10) NULL,
  CONSTRAINT chk_SSN CHECK(SSN LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
  CONSTRAINT chk_Sex CHECK(Sex in ('F', 'M')),
  CONSTRAINT chk_Salary CHECK(Salary < 100000 and Salary >= 10000)
);
GO


