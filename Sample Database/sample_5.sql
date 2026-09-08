-- INIT database
CREATE TABLE Employees (
  EmployeeID INT IDENTITY(100, 1) PRIMARY KEY,
  EmployeeName VARCHAR(50) NOT NULL,
  Account VARCHAR(50) NOT NULL,
  Password VARBINARY(64) NOT NULL
);

CREATE TABLE Dishes (
  DishesID INT IDENTITY(200, 1) PRIMARY KEY,
  DishName VARCHAR(50) NOT NULL,
  Price DECIMAL(10, 2) NOT NULL
);

CREATE TABLE OrderTicket (
  OrderID INT IDENTITY(300, 1) PRIMARY KEY,
  DateofOrder DATE NOT NULL DEFAULT GETDATE(),
  SeatNumber INT NOT NULL,
  Server INT NOT NULL,
  DishOrdered INT NOT NULL,
  Quantity INT NOT NULL,
  FOREIGN KEY (Server) REFERENCES Employees(EmployeeID),
  FOREIGN KEY (DishOrdered) REFERENCES Dishes(DishesID)
);

-- Employee Table
INSERT INTO Employees(EmployeeName, Account, Password) VALUES ('Adam Keith', 'AdamA1', HASHBYTES('SHA2_256', '123456'));
INSERT INTO Employees(EmployeeName, Account, Password) VALUES ('Ben Shappino', 'BenB3', HASHBYTES('SHA2_256', '123321'));
INSERT INTO Employees(EmployeeName, Account, Password) VALUES ('Cindy Orella', 'CindyCY8', HASHBYTES('SHA2_256', '123241'));
INSERT INTO Employees(EmployeeName, Account, Password) VALUES ('Dean Henderson', 'DeanDU9', HASHBYTES('SHA2_256', '123921'));
INSERT INTO Employees(EmployeeName, Account, Password) VALUES ('Elly Molly', 'EllyU01', HASHBYTES('SHA2_256', '128881'));

-- Dishes Table
INSERT INTO Dishes(DishName, Price) VALUES ('Fish and Chip', '12.99');
INSERT INTO Dishes(DishName, Price) VALUES ('Soup', '8.99');
INSERT INTO Dishes(DishName, Price) VALUES ('Hamburger', '15.99');
INSERT INTO Dishes(DishName, Price) VALUES ('Beef', '24.99');

-- Order Ticket Table
INSERT INTO OrderTicket(SeatNumber, Server, DishOrdered, Quantity) VALUES (1, 101, 202, 2);
INSERT INTO OrderTicket(SeatNumber, Server, DishOrdered, Quantity) VALUES (2, 103, 203, 2);
INSERT INTO OrderTicket(SeatNumber, Server, DishOrdered, Quantity) VALUES (4, 104, 200, 2);

-- QUERY database: Employees Table, Dishes Table
SELECT * FROM Employees 
SELECT * FROM Dishes
-- QUERY: Order Ticket
-- Convert the number to employee name and dish name from Order Tickets
-- Using "JOIN"
SELECT SeatNumber, DateofOrder, e.EmployeeName AS Server, d.DishName AS DishOrdered, Quantity, (d.Price * ot.Quantity) AS TotalPrice FROM OrderTicket ot
JOIN Employees e ON ot.Server = e.EmployeeID
JOIN Dishes d ON ot.DishOrdered = d.DishesID