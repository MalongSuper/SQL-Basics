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


