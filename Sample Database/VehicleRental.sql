-- Question 1: (0.5 points) Create database
CREATE DATABASE VehicleRentalDB
GO

USE VehicleRentalDB
GO

-- Question 2: (1.5 points) Create tables
CREATE TABLE Vehicle (
    vehicle_id VARCHAR(3) NOT NULL, 
    vehicle_name VARCHAR(50) NOT NULL
)
GO

CREATE TABLE Customer (
    customer_id VARCHAR(4) NOT NULL,
    full_name NVARCHAR(50) NOT NULL
)
GO

CREATE TABLE RentalContract (
    contract_id VARCHAR(6) NOT NULL, 
    rental_date DATE NOT NULL, 
    customer_id VARCHAR(4) NOT NULL
)
GO

CREATE TABLE ContractDetails (
    contract_id VARCHAR(6) NOT NULL, 
    vehicle_id VARCHAR(3) NOT NULL, 
    receive_date DATE NOT NULL, 
    return_date DATE NOT NULL, 
    rental_price INT NOT NULL
)
GO


-- Question 3: (1.5 points) Add primary key and foreign key constraints
ALTER TABLE Vehicle
ADD CONSTRAINT pk_vehicle_id PRIMARY KEY (vehicle_id)
GO

ALTER TABLE Customer
ADD CONSTRAINT pk_customer_id PRIMARY KEY (customer_id)
GO

ALTER TABLE RentalContract
ADD CONSTRAINT pk_contract_id PRIMARY KEY (contract_id)
GO

ALTER TABLE RentalContract
ADD CONSTRAINT fk_customer_id FOREIGN KEY (customer_id) REFERENCES Customer(customer_id)
GO

ALTER TABLE ContractDetails
ADD CONSTRAINT pk_contract_vehicle PRIMARY KEY (contract_id, vehicle_id)
GO

ALTER TABLE ContractDetails
ADD CONSTRAINT fk_contract_id FOREIGN KEY (contract_id) REFERENCES RentalContract(contract_id)
GO

ALTER TABLE ContractDetails
ADD CONSTRAINT fk_vehicle_id FOREIGN KEY (vehicle_id) REFERENCES Vehicle(vehicle_id)
GO

-- Question 4: (0.5 points) Add default constraint: rental_date in RentalContract has default as current date
ALTER TABLE RentalContract
ADD CONSTRAINT df_rental_date DEFAULT GETDATE() FOR rental_date
GO

-- Question 5: (0.5 points) Add check constraint: vehicle_id in Vehicle must start with 'X' followed by two digits
ALTER TABLE Vehicle
ADD CONSTRAINT chk_vehicle_id CHECK(vehicle_id LIKE 'X[0-9][0-9]')
GO

ALTER TABLE Customer
ADD CONSTRAINT chk_customer_id CHECK(customer_id LIKE 'KH[0-9][0-9]')
GO

ALTER TABLE RentalContract
ADD CONSTRAINT chk_contract_id CHECK (contract_id LIKE 'HD[0-9][0-9][0-9][0-9]')
GO


-- Question 6: (0.5 points) Insert Data
INSERT INTO Vehicle (vehicle_id, vehicle_name) VALUES 
('X01', 'Toyota Vios'),
('X02', 'Toyota Camry'),
('X03', 'Hyundai i10 2024'),
('X04', 'Hyundai Venue 2023'),
('X05', 'Ford Everest');
GO

INSERT INTO Customer (customer_id, full_name) VALUES 
('KH01', N'Bùi Thu Hà'),
('KH02', N'Nguyễn Hải Hà');
GO

INSERT INTO RentalContract (contract_id, rental_date, customer_id) VALUES 
('HD0001', '2025-02-01', 'KH01'),
('HD0002', '2025-03-07', 'KH02');
GO

INSERT INTO ContractDetails (contract_id, vehicle_id, receive_date, return_date, rental_price) VALUES 
('HD0001', 'X01', '2025-02-03', '2025-02-06', 3000000),
('HD0001', 'X02', '2025-02-03', '2025-02-06', 3000000),
('HD0001', 'X03', '2025-02-04', '2025-02-06', 2000000),
('HD0002', 'X04', '2025-03-10', '2025-03-31', 15000000),
('HD0002', 'X01', '2025-03-08', '2025-03-09', 1000000);
GO


-- Question 7: Query data
-- English translation of the original exercise comment.
SELECT v.vehicle_name 
FROM Customer c 
JOIN RentalContract r ON c.customer_id = r.customer_id
JOIN ContractDetails d ON d.contract_id = r.contract_id
JOIN Vehicle v ON v.vehicle_id = d.vehicle_id 
WHERE c.full_name = N'Nguyễn Hải Hà'
GO

-- b. Find customers and the names of the vehicles they rented
SELECT c.full_name, v.vehicle_name 
FROM Customer c 
JOIN RentalContract r ON c.customer_id = r.customer_id
JOIN ContractDetails d ON d.contract_id = r.contract_id
JOIN Vehicle v ON v.vehicle_id = d.vehicle_id
GO

-- c. Find vehicle_id and vehicle_name of vehicles with "Toyota" in their name
SELECT vehicle_id, vehicle_name 
FROM Vehicle 
WHERE vehicle_name LIKE '%Toyota%'
GO

-- d. Find the total rental price for each contract
SELECT contract_id, SUM(rental_price) AS total_price 
FROM ContractDetails 
GROUP BY contract_id
GO

-- e. Find the name of the vehicle with the highest total rental revenue
SELECT TOP 1 WITH TIES v.vehicle_name 
FROM ContractDetails d
JOIN Vehicle v ON v.vehicle_id = d.vehicle_id
GROUP BY v.vehicle_name
ORDER BY SUM(d.rental_price) DESC
GO


-- English translation of the original exercise comment.
SELECT v.vehicle_name 
FROM Customer c 
JOIN RentalContract r ON c.customer_id = r.customer_id
JOIN ContractDetails d ON d.contract_id = r.contract_id
JOIN Vehicle v ON v.vehicle_id = d.vehicle_id 
WHERE c.full_name = N'Bùi Thu Hà'
GO


-- c. Find vehicle_id and vehicle_name of vehicles with "Hyundai" in their name
SELECT vehicle_id, vehicle_name 
FROM Vehicle 
WHERE vehicle_name LIKE '%Hyundai%'
GO

-- d. Find the name and the total rent days of the most-days rented vehicles
-- The vehicles whose total days it has been rented is the greatest
SELECT TOP 1 WITH TIES v.vehicle_name, SUM(DATEDIFF(DAY, receive_date, return_date)) AS TotalRentedDays 
FROM ContractDetails d
JOIN Vehicle v ON v.vehicle_id = d.vehicle_id
GROUP BY v.vehicle_name
ORDER BY SUM(d.rental_price) DESC
GO
