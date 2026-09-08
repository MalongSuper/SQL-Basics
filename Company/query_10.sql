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

-- DEPENDENT table
INSERT INTO Dependent(ESSN, Dependent_Name, Sex, BDate, Relationship) VALUES ('123456789', 'Alice',	'F', '1978-12-31', 'Daughter');
INSERT INTO Dependent(ESSN, Dependent_Name, Sex, BDate, Relationship) VALUES ('123456789', 'Elizabeth',	'F', '1957-05-05', 'Spouse');
INSERT INTO Dependent(ESSN, Dependent_Name, Sex, BDate, Relationship) VALUES ('123456789', 'Michael',	'M', '1978-01-01', 'Son');
INSERT INTO Dependent(ESSN, Dependent_Name, Sex, BDate, Relationship) VALUES ('333445555', 'Alice',	'F', '1976-05-04', 'Daughter');
INSERT INTO Dependent(ESSN, Dependent_Name, Sex, BDate, Relationship) VALUES ('333445555', 'Joy',	'F', '1948-03-05', 'Spouse');
INSERT INTO Dependent(ESSN, Dependent_Name, Sex, BDate, Relationship) VALUES ('333445555', 'Theodore',	'M', '1973-10-25', 'Son');
INSERT INTO Dependent(ESSN, Dependent_Name, Sex, BDate, Relationship) VALUES ('987654321', 'Abner',	'M', '1932-02-29', 'Spouse');

