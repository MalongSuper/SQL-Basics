-- INIT database                                                 
CREATE TABLE Motorbike (
  MotorID VARCHAR(4) PRIMARY KEY,
  MotorName VARCHAR(50) NOT NULL,
  MotorBrand VARCHAR(25) NOT NULL,
  MotorPhoneNumber VARCHAR(10) NOT NULL,
  CONSTRAINT chk_MotorID_format CHECK(MotorID LIKE 'M[0-9][0-9][0-9]'),
  CONSTRAINT chk_MotorPhoneNumber_format CHECK(MotorPhoneNumber
                                               LIKE '[0][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]')
);


CREATE TABLE Worker (
  WorkerID VARCHAR(4) PRIMARY KEY,
  WorkerName VARCHAR(25) NOT NULL,
  WorkerLevel VARCHAR(2) NOT NULL,
  WorkerPhoneNumber VARCHAR(10) NOT NULL,
  CONSTRAINT chk_WorkerID_format CHECK(WorkerID LIKE 'W[0-9][0-9][0-9]'),
  CONSTRAINT chk_WorkerPhoneNumber_format CHECK(WorkerPhoneNumber
                                               LIKE '[0][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
  CONSTRAINT chk_WorkerLevel_format CHECK(WorkerLevel LIKE '[A-C][1-2]')
);

CREATE TABLE MainWork(
  MainID VARCHAR(7) PRIMARY KEY,
  MainName VARCHAR(50) NOT NULL,
  MainTime INT NOT NULL,
  MainPrice FLOAT NOT NULL,
  MainWorker VARCHAR(4) NOT NULL,
  CONSTRAINT chk_MainID_format CHECK(MainID LIKE 'MAIN[0-9][0-9][0-9]'),
  CONSTRAINT chk_MainTime CHECK (MainTime > 0),
  CONSTRAINT chk_MainPrice CHECK (MainPrice > 0),
  FOREIGN KEY (MainWorker) REFERENCES Worker(WorkerID)
);

CREATE TABLE MainTicket(
  TicketID INT IDENTITY(1000, 1) PRIMARY KEY,
  TicketDate DATE NOT NULL DEFAULT GETDATE(),
  MainMotor VARCHAR(4) NOT NULL,
  FOREIGN KEY (MainMotor) REFERENCES Motorbike(MotorID)
);

CREATE TABLE TicketHasWork(
  Ticket INT,
  Works VARCHAR(7),
  CONSTRAINT PK_TicketHasWork PRIMARY KEY(Ticket, Works),
  FOREIGN KEY (Ticket) REFERENCES MainTicket(TicketID),
  FOREIGN KEY (Works) REFERENCES MainWork(MainID)
);
  
  
-- Motorbike database
INSERT INTO Motorbike(MotorID, MotorName, MotorBrand, MotorPhoneNumber) VALUES ('M001', 'Sport Bike', 'Yamaha', '0908443119')
INSERT INTO Motorbike(MotorID, MotorName, MotorBrand, MotorPhoneNumber) VALUES ('M002', 'ATV Bike', 'Lexus', '0908229332')
INSERT INTO Motorbike(MotorID, MotorName, MotorBrand, MotorPhoneNumber) VALUES ('M003', 'Touring Bike', 'Yamaha', '0903291217')
INSERT INTO Motorbike(MotorID, MotorName, MotorBrand, MotorPhoneNumber) VALUES ('M004', 'Enduro Bike', 'Volvo', '0982129102')
INSERT INTO Motorbike(MotorID, MotorName, MotorBrand, MotorPhoneNumber) VALUES ('M005', 'Adventure Bike', 'Mercedes', '0908334122')

-- Worker database
INSERT INTO Worker(WorkerID, WorkerName, WorkerLevel, WorkerPhoneNumber) VALUES ('W001', 'James Antonine', 'C1', '0932332112')
INSERT INTO Worker(WorkerID, WorkerName, WorkerLevel, WorkerPhoneNumber) VALUES ('W002', 'John Mccarthy', 'B2', '0932542214') 
INSERT INTO Worker(WorkerID, WorkerName, WorkerLevel, WorkerPhoneNumber) VALUES ('W003', 'Andrew Tate', 'B2', '0335443711') 
INSERT INTO Worker(WorkerID, WorkerName, WorkerLevel, WorkerPhoneNumber) VALUES ('W004', 'Jen Shanonce', 'C2', '0498344312')
INSERT INTO Worker(WorkerID, WorkerName, WorkerLevel, WorkerPhoneNumber) VALUES ('W005', 'Anna Stove', 'B1', '0277485571')

-- MainWork database
INSERT INTO MainWork(MainID, MainName, MainTime, MainPrice, MainWorker) VALUES ('MAIN001', 'Oil Change', '45', '5.99', 'W001')
INSERT INTO MainWork(MainID, MainName, MainTime, MainPrice, MainWorker) VALUES ('MAIN002', 'Brake Inspection', '45', '9.99', 'W005')
INSERT INTO MainWork(MainID, MainName, MainTime, MainPrice, MainWorker) VALUES ('MAIN003', 'Chain Lubrication', '60', '14.99', 'W002')
INSERT INTO MainWork(MainID, MainName, MainTime, MainPrice, MainWorker) VALUES ('MAIN004', 'Tire Replacement', '60', '14.99', 'W001')
INSERT INTO MainWork(MainID, MainName, MainTime, MainPrice, MainWorker) VALUES ('MAIN005', 'Air Filter Cleaning', '45', '9.99', 'W003')

-- MainTicket database
INSERT INTO MainTicket(MainMotor) VALUES ('M004')

-- TickethasWork database
INSERT INTO TicketHasWork (Ticket, Works) VALUES (1000, 'MAIN002')
INSERT INTO TicketHasWork (Ticket, Works) VALUES (1000, 'MAIN004')

-- QUERY database
SELECT * FROM Motorbike
SELECT * FROM Worker
SELECT * FROM MainWork
SELECT * FROM MainTicket 
SELECT * FROM TicketHasWork WHERE Ticket = 1000