-- Project Table
CREATE TABLE Project (
  PName VARCHAR(50) UNIQUE NOT NULL,
  PNumber INT PRIMARY KEY,
  PLocation VARCHAR(50) NOT NULL,
);
GO

-- Project Table
INSERT INTO Project(PName, PNumber, PLocation) VALUES ('ProductX', 1, 'Bellaire');
INSERT INTO Project(PName, PNumber, PLocation) VALUES ('ProductY', 2, 'Sugarland');
INSERT INTO Project(PName, PNumber, PLocation) VALUES ('ProductZ', 3, 'Houston');
INSERT INTO Project(PName, PNumber, PLocation) VALUES ('Computerization', 10, 'Stafford'); 
INSERT INTO Project(PName, PNumber, PLocation) VALUES ('Reorganization', 20, 'Houston'); 
INSERT INTO Project(PName, PNumber, PLocation) VALUES ('Newbenefits', 30, 'Stafford');   

