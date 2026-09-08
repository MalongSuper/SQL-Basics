-- Department Locations table
CREATE TABLE Dept_Location (
  DNumber INT,
  DLocation VARCHAR(50),
  CONSTRAINT PK_Dept_Location PRIMARY KEY(DNumber, DLocation),
  FOREIGN KEY (DNumber) REFERENCES Department(DNumber)
);
GO

-- Dept Location Table
INSERT INTO Dept_Location(DNumber, DLocation) VALUES (1, 'Houston');
INSERT INTO Dept_Location(DNumber, DLocation) VALUES (4, 'Stafford');
INSERT INTO Dept_Location(DNumber, DLocation) VALUES (5, 'Bellaire');
INSERT INTO Dept_Location(DNumber, DLocation) VALUES (5, 'Houston');
INSERT INTO Dept_Location(DNumber, DLocation) VALUES (5, 'Sugarland');

