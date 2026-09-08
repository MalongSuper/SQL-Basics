-- Create a database
CREATE DATABASE AttendanceManagement
GO
USE AttendanceManagement
GO

-- Create tables
CREATE TABLE Department
(
    department_id CHAR(3) NOT NULL, 
    department_name NVARCHAR(50) NOT NULL
)
GO

CREATE TABLE Employee
(
    employee_id CHAR(4) NOT NULL, 
    full_name NVARCHAR(50) NOT NULL, 
    base_salary INT NOT NULL, 
    department_id CHAR(3) NOT NULL
)
GO

CREATE TABLE AttendanceSheet
(
    sheet_id CHAR(3) NOT NULL, 
    month CHAR(7) NOT NULL, 
    department_id CHAR(3) NOT NULL
)
GO

CREATE TABLE Attendance
(
    employee_id CHAR(4) NOT NULL, 
    sheet_id CHAR(3) NOT NULL, 
    working_days INT NOT NULL
)
GO

-- Add primary and unique constraints
ALTER TABLE Department
ADD CONSTRAINT PK_department_id PRIMARY KEY (department_id)
GO

ALTER TABLE Department
ADD CONSTRAINT UQ_department_name UNIQUE (department_name)
GO

ALTER TABLE Employee
ADD CONSTRAINT PK_employee_id PRIMARY KEY (employee_id)
GO

ALTER TABLE AttendanceSheet
ADD CONSTRAINT PK_sheet_id PRIMARY KEY (sheet_id)
GO

ALTER TABLE Attendance
ADD CONSTRAINT PK_employee_sheet PRIMARY KEY (employee_id, sheet_id)
GO

-- Add foreign key constraints
ALTER TABLE Employee
ADD CONSTRAINT FK_department_employee FOREIGN KEY (department_id) REFERENCES Department(department_id) ON DELETE NO ACTION ON UPDATE NO ACTION
GO

ALTER TABLE AttendanceSheet
ADD CONSTRAINT FK_department_sheet FOREIGN KEY (department_id) REFERENCES Department(department_id) ON DELETE NO ACTION ON UPDATE NO ACTION
GO

ALTER TABLE Attendance
ADD CONSTRAINT FK_employee FOREIGN KEY (employee_id) REFERENCES Employee(employee_id) ON DELETE NO ACTION ON UPDATE NO ACTION
GO

ALTER TABLE Attendance
ADD CONSTRAINT FK_sheet_id FOREIGN KEY (sheet_id) REFERENCES AttendanceSheet(sheet_id) ON DELETE NO ACTION ON UPDATE NO ACTION
GO

-- Add checks and default values
ALTER TABLE Employee
ADD CONSTRAINT CK_base_salary CHECK (base_salary >= 5000000 AND base_salary <= 50000000)
GO

ALTER TABLE AttendanceSheet
ADD CONSTRAINT CK_month CHECK (month LIKE '[01][1-9]/2[0-9][0-9][0-9]')
GO

ALTER TABLE Attendance
ADD CONSTRAINT CK_working_days CHECK (working_days >= 0 AND working_days <= 26)
GO

ALTER TABLE Attendance
ADD CONSTRAINT DF_working_days DEFAULT 26 FOR working_days
