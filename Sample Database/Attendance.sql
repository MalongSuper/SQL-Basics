CREATE DATABASE AttendanceSystem
GO

USE AttendanceSystem
GO

CREATE TABLE Department (
    DepartmentId VARCHAR(3) NOT NULL,
    DepartmentName NVARCHAR(50) NOT NULL
)
GO

CREATE TABLE Employee (
    EmployeeId VARCHAR(4) NOT NULL,
    EmployeeName NVARCHAR(50) NOT NULL,
    Salary INT NOT NULL,
    DepartmentId VARCHAR(3) NOT NULL
)
GO

CREATE TABLE AttendanceSheet (
    AttendanceId VARCHAR(3) NOT NULL,
    AttendanceMonth VARCHAR(7) NOT NULL,
    DepartmentId VARCHAR(3) NOT NULL
)
GO

CREATE TABLE Attendance (
    EmployeeId VARCHAR(4) NOT NULL,
    AttendanceId VARCHAR(3) NOT NULL,
    AttendanceDay SMALLINT NOT NULL
)
GO


ALTER TABLE Department 
ADD CONSTRAINT pk_DepartmentId PRIMARY KEY (DepartmentId),
    CONSTRAINT uq_DepartmentName UNIQUE (DepartmentName)
GO

ALTER TABLE Employee
ADD CONSTRAINT pk_EmployeeId PRIMARY KEY (EmployeeId),
    CONSTRAINT fk_DepartmentId FOREIGN KEY (DepartmentId) REFERENCES Department(DepartmentId)
GO


ALTER TABLE AttendanceSheet
ADD CONSTRAINT pk_AttendanceId PRIMARY KEY (AttendanceId),
    CONSTRAINT fk_AttendanceDepartmentId FOREIGN KEY (DepartmentId) REFERENCES Department(DepartmentId)
GO

ALTER TABLE Attendance
ADD CONSTRAINT pk_Employee_Attendance PRIMARY KEY (EmployeeId, AttendanceId),
    CONSTRAINT fk_EmployeeId FOREIGN KEY (EmployeeId) REFERENCES Employee(EmployeeId),
    CONSTRAINT fk_Attendance FOREIGN KEY (AttendanceId) REFERENCES AttendanceSheet(AttendanceId) 
GO

ALTER TABLE Attendance
ADD CONSTRAINT df_AttendanceDay DEFAULT 26 FOR AttendanceDay
GO

ALTER TABLE Department
ADD CONSTRAINT chk_DepartmentId CHECK(DepartmentId LIKE 'P[0-9][0-9]')
GO

ALTER TABLE Employee
ADD CONSTRAINT chk_EmployeeId CHECK(EmployeeId LIKE 'NV[0-9][0-9]')
GO

ALTER TABLE AttendanceSheet
ADD CONSTRAINT chk_AttendanceId CHECK(AttendanceId LIKE '[B][0-9][0-9]')
GO

ALTER TABLE AttendanceSheet
ADD CONSTRAINT chk_AttendanceMonth CHECK(AttendanceMonth LIKE '[0][1-9]/20[0-9][0-9]' 
OR AttendanceMonth LIKE '[1][0-2]/20[0-9][0-9]')
GO


INSERT INTO Department (DepartmentId, DepartmentName)
VALUES 
('P01', N'Phòng thu mua'),
('P02', N'Phòng sản xuất');

INSERT INTO Employee (EmployeeId, EmployeeName, Salary, DepartmentId)
VALUES 
('NV01', N'Huỳnh Thị Thúy Anh', 7000000, 'P01'),
('NV02', N'Lương Thị Thanh Bình', 7500000, 'P01'),
('NV03', N'Trần Thị Kim Duyên', 8000000, 'P02'),
('NV04', N'Trần Thụy Phương Đài', 7000000, 'P02'),
('NV05', N'Bùi Thu Hà', 7500000, 'P02'),
('NV06', N'Nguyễn Hải Hà', 8200000, 'P02');

INSERT INTO AttendanceSheet (AttendanceId, AttendanceMonth, DepartmentId)
VALUES 
('B01', '01/2025', 'P01'),
('B02', '01/2025', 'P02'),
('B03', '02/2025', 'P01'),
('B04', '02/2025', 'P02');

INSERT INTO Attendance (EmployeeId, AttendanceId, AttendanceDay)
VALUES 
('NV01', 'B01', 20),
('NV02', 'B01', 21),
('NV03', 'B02', 23),
('NV04', 'B02', 24),
('NV05', 'B02', 26),
('NV06', 'B02', 25),
('NV01', 'B03', 24),
('NV02', 'B03', 26),
('NV03', 'B04', 23),
('NV04', 'B04', 22),
('NV05', 'B04', 23),
('NV06', 'B04', 24);



-- Queries
-- a) Find all the employees with Salary greater or equal to 8000000
SELECT EmployeeName FROM Employee WHERE Salary >= 8000000
GO

-- English translation of the original exercise comment.
SELECT e.EmployeeName FROM Employee e 
JOIN Department d ON e.DepartmentId = d.DepartmentId
WHERE d.DepartmentName = N'Phòng sản xuất'
GO

-- c) Find all the employees name and their department
SELECT e.EmployeeName, d.DepartmentName FROM Employee e 
JOIN Department d ON e.DepartmentId = d.DepartmentId
GO

-- d) Find the department name and the number of employees of each department
SELECT d.DepartmentName, COUNT(e.EmployeeId) AS NumberofEmployees FROM Employee e 
JOIN Department d ON e.DepartmentId = d.DepartmentId 
GROUP BY d.DepartmentName
GO

-- e) Find the monthly salary for each employee by the formula:
-- Monthly Salary = (Salary * AttendanceDays) / 26
SELECT e.EmployeeId, e.EmployeeName, s.AttendanceMonth, 
(e.Salary * a.AttendanceDay) / 26 AS MonthySalary 
FROM Employee e 
JOIN Attendance a ON e.EmployeeId = a.EmployeeId
JOIN AttendanceSheet s ON s.AttendanceId = a.AttendanceId
GROUP BY e.EmployeeId, e.EmployeeName, s.AttendanceMonth, e.Salary, a.AttendanceDay
GO

-- a) Find all the employees with Salary less than 7500000
SELECT EmployeeName FROM Employee WHERE Salary < 7500000
GO

-- English translation of the original exercise comment.
SELECT e.EmployeeName FROM Employee e 
JOIN Department d ON e.DepartmentId = d.DepartmentId
WHERE d.DepartmentName = N'Phòng thu mua'
GO
