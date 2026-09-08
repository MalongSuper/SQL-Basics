-- Create Department table
CREATE TABLE Department(
    DName VARCHAR(50) UNIQUE NOT NULL,
    DNumber INT PRIMARY KEY
);
GO

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

-- Department Locations table
CREATE TABLE Dept_Location (
  DNumber INT,
  DLocation VARCHAR(50),
  CONSTRAINT PK_Dept_Location PRIMARY KEY(DNumber, DLocation),
  FOREIGN KEY (DNumber) REFERENCES Department(DNumber)
);
GO

-- Project Table
CREATE TABLE Project (
  PName VARCHAR(50) UNIQUE NOT NULL,
  PNumber INT PRIMARY KEY,
  PLocation VARCHAR(50) NOT NULL
);
GO

-- Works_On Table
CREATE TABLE Works_On (
  ESSN VARCHAR(9),
  PNo INT,
  Hours NUMERIC(3, 1),
  CONSTRAINT chk_Hours CHECK(Hours <= 40.0 and Hours  > 0),
  CONSTRAINT PK_Works_On PRIMARY KEY(ESSN, PNo),
  FOREIGN KEY (ESSN) REFERENCES Employee(SSN),
  FOREIGN KEY (PNo) REFERENCES Project(PNumber)
);
GO

-- Dependent Table
CREATE TABLE Dependent (
  ESSN VARCHAR(9),
  Dependent_Name VARCHAR(25),
  Sex CHAR(1) NOT NULL,
  BDate DATE NOT NULL,
  Relationship VARCHAR(25) NOT NULL,
  CONSTRAINT PK_Dependent PRIMARY KEY(ESSN, Dependent_Name),
  CONSTRAINT chk_Sex_Dependent CHECK(Sex in ('F', 'M')), -- Since there is already chk_Sex in Employee
  FOREIGN KEY (ESSN) REFERENCES Employee(SSN)
);
GO


-- Insert into Department table
INSERT INTO Department(DName, DNumber) VALUES ('Headquarters', 1);
INSERT INTO Department(DName, DNumber) VALUES ('Administration', 4);
INSERT INTO Department(DName, DNumber) VALUES ('Research', 5);

-- Insert into Employee table
INSERT INTO Employee(FName, Minit, LName, SSN, BDate, Address, Sex, Salary) VALUES ('John', 'B', 'Smith', '123456789', '1955-01-09', 'Houston, TX', 'M', 30000);
INSERT INTO Employee(FName, Minit, LName, SSN, BDate, Address, Sex, Salary) VALUES ('Franklin', 'T', 'Wong', '333445555', '1945-08-12', 'Houston, TX', 'M', 40000);
INSERT INTO Employee(FName, Minit, LName, SSN, BDate, Address, Sex, Salary) VALUES ('Joyce', 'A', 'English', '453453453', '1962-07-31', 'Houston, TX', 'F', 25000);
INSERT INTO Employee(FName, Minit, LName, SSN, BDate, Address, Sex, Salary) VALUES ('Ramesh', 'K', 'Narayan', '666884444', '1952-09-15', 'Houston, TX', 'M', 38000);
INSERT INTO Employee(FName, Minit, LName, SSN, BDate, Address, Sex, Salary) VALUES ('James', 'E', 'Borg', '888665555', '1927-11-10', 'Houston, TX', 'M', 55000);
INSERT INTO Employee(FName, Minit, LName, SSN, BDate, Address, Sex, Salary) VALUES ('Jennifer', 'S', 'Wallace', '987654321', '1931-06-20', 'Bellaire, TX', 'F', 43000);
INSERT INTO Employee(FName, Minit, LName, SSN, BDate, Address, Sex, Salary) VALUES ('Ahmad', 'V', 'Jabbar', '987987987', '1959-03-29', 'Houston, TX', 'M', 25000);
INSERT INTO Employee(FName, Minit, LName, SSN, BDate, Address, Sex, Salary) VALUES ('Alicia', 'J', 'Zelaya', '999887777', '1958-07-19', 'Spring, TX', 'F', 25000);

-- Add columns for Super_ssn and Dno and foreign keys
ALTER TABLE Employee
ADD Super_SSN VARCHAR(9) NULL,
    DNo INT NULL,
    FOREIGN KEY (Super_SSN) REFERENCES Employee(SSN),
  	FOREIGN KEY (DNo) REFERENCES Department(DNumber);
GO

-- Update Super_ssn and Dno for each employee
UPDATE Employee SET Super_SSN = '333445555', DNo = 5 WHERE SSN = '123456789';
UPDATE Employee SET Super_SSN = '888665555', DNo = 5 WHERE SSN = '333445555';
UPDATE Employee SET Super_SSN = '333445555', DNo = 5 WHERE SSN = '453453453';
UPDATE Employee SET Super_SSN = '333445555', DNo = 5 WHERE SSN = '666884444';
UPDATE Employee SET Super_SSN = NULL, DNo = 1 WHERE SSN = '888665555';
UPDATE Employee SET Super_SSN = '888665555', DNo = 4 WHERE SSN = '987654321';
UPDATE Employee SET Super_SSN = '987654321', DNo = 4 WHERE SSN = '987987987';
UPDATE Employee SET Super_SSN = '987654321', DNo = 4 WHERE SSN = '999887777';

-- Add columns for Mgrssn, MgrStartDate
ALTER TABLE Department
ADD Mgrssn VARCHAR(9) NULL,
	MgrStartDate DATE NULL,
    FOREIGN KEY (Mgrssn) REFERENCES Employee(SSN);
GO

-- Update Mgrssn, MgrStartDate for each Department
UPDATE Department SET Mgrssn = '888665555', MgrStartDate='1971-06-19' WHERE Dnumber = 1;
UPDATE Department SET Mgrssn = '987654321', MgrStartDate='1985-01-01' WHERE Dnumber = 4;
UPDATE Department SET Mgrssn = '333445555', MgrStartDate='1978-05-22' WHERE Dnumber = 5;

-- Dept Location Table
INSERT INTO Dept_Location(DNumber, DLocation) VALUES (1, 'Houston');
INSERT INTO Dept_Location(DNumber, DLocation) VALUES (4, 'Stafford');
INSERT INTO Dept_Location(DNumber, DLocation) VALUES (5, 'Bellaire');
INSERT INTO Dept_Location(DNumber, DLocation) VALUES (5, 'Houston');
INSERT INTO Dept_Location(DNumber, DLocation) VALUES (5, 'Sugarland');

-- Project Table
INSERT INTO Project(PName, PNumber, PLocation) VALUES ('ProductX', 1, 'Bellaire');
INSERT INTO Project(PName, PNumber, PLocation) VALUES ('ProductY', 2, 'Sugarland');
INSERT INTO Project(PName, PNumber, PLocation) VALUES ('ProductZ', 3, 'Houston');
INSERT INTO Project(PName, PNumber, PLocation) VALUES ('Computerization', 10, 'Stafford'); 
INSERT INTO Project(PName, PNumber, PLocation) VALUES ('Reorganization', 20, 'Houston'); 
INSERT INTO Project(PName, PNumber, PLocation) VALUES ('Newbenefits', 30, 'Stafford');                                                    

-- Add columns for DNum
ALTER TABLE Project
ADD DNum INT NULL,
	FOREIGN KEY (DNum) REFERENCES Department(DNumber);
GO

-- Update DNum each Project
UPDATE Project SET DNum = 5 WHERE PNumber = 1;
UPDATE Project SET DNum = 5 WHERE PNumber = 2;
UPDATE Project SET DNum = 5 WHERE PNumber = 3;
UPDATE Project SET DNum = 4 WHERE PNumber = 10;
UPDATE Project SET DNum = 1 WHERE PNumber = 20;
UPDATE Project SET DNum = 4 WHERE PNumber = 30;

-- Works_on Table
INSERT INTO Works_On(ESSN, PNo, Hours) VALUES ('123456789', 1, 32.5);
INSERT INTO Works_On(ESSN, PNo, Hours) VALUES ('123456789', 2, 7.5);
INSERT INTO Works_On(ESSN, PNo, Hours) VALUES ('333445555', 2, 10.0);
INSERT INTO Works_On(ESSN, PNo, Hours) VALUES ('333445555', 3, 10.0);
INSERT INTO Works_On(ESSN, PNo, Hours) VALUES ('333445555', 10, 10.0);
INSERT INTO Works_On(ESSN, PNo, Hours) VALUES ('333445555', 20, 10.0);
INSERT INTO Works_On(ESSN, PNo, Hours) VALUES ('453453453', 1, 20.0);
INSERT INTO Works_On(ESSN, PNo, Hours) VALUES ('453453453', 2, 20.0);
INSERT INTO Works_On(ESSN, PNo, Hours) VALUES ('666884444', 3, 40.0); 
INSERT INTO Works_On(ESSN, PNo, Hours) VALUES ('888665555', 20, NULL); 
INSERT INTO Works_On(ESSN, PNo, Hours) VALUES ('987654321', 20, 15.0);
INSERT INTO Works_On(ESSN, PNo, Hours) VALUES ('987654321', 30, 20.0);
INSERT INTO Works_On(ESSN, PNo, Hours) VALUES ('987987987', 10, 35.0);
INSERT INTO Works_On(ESSN, PNo, Hours) VALUES ('987987987', 30, 5.0);
INSERT INTO Works_On(ESSN, PNo, Hours) VALUES ('999887777', 10, 10.0);
INSERT INTO Works_On(ESSN, PNo, Hours) VALUES ('999887777', 30, 30.0);

-- DEPENDENT table
INSERT INTO Dependent(ESSN, Dependent_Name, Sex, BDate, Relationship) VALUES ('123456789', 'Alice',	'F', '1978-12-31', 'Daughter');
INSERT INTO Dependent(ESSN, Dependent_Name, Sex, BDate, Relationship) VALUES ('123456789', 'Elizabeth',	'F', '1957-05-05', 'Spouse');
INSERT INTO Dependent(ESSN, Dependent_Name, Sex, BDate, Relationship) VALUES ('123456789', 'Michael',	'M', '1978-01-01', 'Son');
INSERT INTO Dependent(ESSN, Dependent_Name, Sex, BDate, Relationship) VALUES ('333445555', 'Alice',	'F', '1976-05-04', 'Daughter');
INSERT INTO Dependent(ESSN, Dependent_Name, Sex, BDate, Relationship) VALUES ('333445555', 'Joy',	'F', '1948-03-05', 'Spouse');
INSERT INTO Dependent(ESSN, Dependent_Name, Sex, BDate, Relationship) VALUES ('333445555', 'Theodore',	'M', '1973-10-25', 'Son');
INSERT INTO Dependent(ESSN, Dependent_Name, Sex, BDate, Relationship) VALUES ('987654321', 'Abner',	'M', '1932-02-29', 'Spouse');

-- Display all tables
SELECT * FROM Department;
SELECT * FROM Employee;
SELECT * FROM Dept_Location;
SELECT * FROM Project;
SELECT * FROM Works_On;
SELECT * FROM Dependent;