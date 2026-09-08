-- INIT database
CREATE TABLE UserAccount (
  AccountID INT IDENTITY(100001, 1) PRIMARY KEY,
  FullName VARCHAR(100) NOT NULL,
  Password VARBINARY(64) NOT NULL,
);

CREATE TABLE Package (
  PackageID VARCHAR(7) PRIMARY KEY,
  PackageName VARCHAR(50) NOT NULL,
  Price DECIMAL(10, 2) NOT NULL,
  Sessions INT NOT NULL,
  Length INT NOT NULL,
  CONSTRAINT chk_PackageID_format CHECK(PackageID LIKE 'P[0-1][0-9][0-9][0-9][0-9][0-9]')
);
 
CREATE TABLE Ticket (
  TicketNumber INT PRIMARY KEY,
  Member INT NOT NULL,
  Package VARCHAR(50) NOT NULL,
  DateofPurchase DATE NOT NULL,
  CONSTRAINT chk_Package_format CHECK(Package LIKE 'P[0-1][0-9][0-9][0-9][0-9][0-9]'),
  CONSTRAINT chk_TicketNumber_format CHECK(TicketNumber LIKE '[1][0-9][0-9][0-9][0-9][0-9][0-9][0-9]')
);

CREATE TABLE Attendance (
  TicketNumber INT NOT NULL,
  AttendanceDate DATE NOT NULL DEFAULT GETDATE(),
  Attended BIT NOT NULL DEFAULT 0,
  AttendanceTime TIME NOT NULL DEFAULT CONVERT(TIME, GETDATE()),
);
  
 
-- User Account Table
INSERT INTO UserAccount(FullName, Password) VALUES ('Anna Frank', HASHBYTES('SHA2_256', 'Ann123'));
INSERT INTO UserAccount(FullName, Password) VALUES ('Brendan Johnson', HASHBYTES('SHA2_256', 'Brendan123'));
INSERT INTO UserAccount(FullName, Password) VALUES ('Dimmer Kiel', HASHBYTES('SHA2_256', 'DKiel23'));
  
-- Package Table
INSERT INTO Package(PackageID, PackageName, Price, Sessions, Length) VALUES ('P120345', 'Advanced Pack', '39.99', 3, 60);
INSERT INTO Package(PackageID, PackageName, Price, Sessions, Length) VALUES ('P120334', 'Deluxe Pack', '29.99', 3, 60);
INSERT INTO Package(PackageID, PackageName, Price, Sessions, Length) VALUES ('P120329', 'Standard Pack', '14.99', 3, 60);
INSERT INTO Package(PackageID, PackageName, Price, Sessions, Length) VALUES ('P120318', 'Beginner Pack', '9.99', 3, 60);

-- Ticket Table
INSERT INTO Ticket(TicketNumber, Member, Package, DateofPurchase) VALUES (14320923, 100001, 'P120329', '2025-03-20');

-- Attendance Record
INSERT INTO Attendance(TicketNumber, Attended) VALUES (14320923, 1);

-- QUERY
SELECT * FROM UserAccount WHERE FullName = 'Anna Frank'
SELECT * FROM Package
SELECT TicketNumber, e.FullName as Member, d.PackageName as Package, DateofPurchase FROM Ticket ot
JOIN UserAccount e ON ot.Member = e.AccountID
JOIN Package d ON ot.Package = d.PackageID
SELECT TicketNumber, AttendanceDate, 
CASE WHEN Attended = 0 then NULL ELSE AttendanceTime 
END AS AttendanceTime, Attended FROM Attendance