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


