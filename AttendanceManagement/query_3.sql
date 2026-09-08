-- Scripts
-- Discard all AttendanceSheet at 6/2025
USE AttendanceManagement;
GO

-- Remove The AttendanceSheet of month 06/2025
DELETE Attendance WHERE sheet_id IN (SELECT sheet_id FROM AttendanceSheet WHERE month = '06/2025')
DELETE AttendanceSheet WHERE month = '06/2025'

-- Create AttendanceSheet 06/2025 for all departments that has no attendance sheet. Check all employees in month 06/2025 with working_days = 26
INSERT INTO AttendanceSheet (sheet_id, month, department_id)
VALUES ('B05', '06/2025', 'P01')

INSERT INTO AttendanceSheet (sheet_id, month, department_id)
VALUES ('B06', '06/2025', 'P02')
GO


DECLARE @MaxNumber
GO
-- Add a new attendance that retrieves the employee and sheet whose month is 06/2025
-- The SELECT query retrieves all employees who does not have the attendance sheet in month 06/2025
INSERT INTO Attendance (employee_id, sheet_id, working_days) 
SELECT e.employee_id, att.sheet_id, 26 FROM Employee e JOIN AttendanceSheet att 
ON e.department_id = att.department_id WHERE att.month = '06/2025' 
AND e.employee_id NOT IN (SELECT a.employee_id FROM Attendance a 
JOIN AttendanceSheet att ON att.sheet_id = a.sheet_id WHERE month = '06/2025')

SELECT * FROM Attendance
SELECT * FROM Department
SELECT * FROM AttendanceSheet

-- Testing Query
SELECT * FROM Attendance a 
JOIN AttendanceSheet att ON att.sheet_id = a.sheet_id WHERE month = '06/2025'



SELECT * FROM Employee e JOIN AttendanceSheet att ON e.department_id = att.department_id


SELECT * FROM Attendance a 
JOIN AttendanceSheet att ON att.sheet_id = a.sheet_id
SELECT * FROM Attendance a 
JOIN AttendanceSheet att ON att.sheet_id = a.sheet_id WHERE month = '06/2025'

SELECT employee_id, sheet_id FROM Attendance
INSERT INTO Attendance


SELECT * FROM Attendance

SELECT MAX(RIGHT(sheet_id, 2)+1)
               FROM AttendanceSheet

SELECT MAX(RIGHT(sheet_id, 2) + 1) FROM AttendanceSheet

SELECT * FROM AttendanceSheet
SELECT * FROM Attendance
SELECT * FROM Department
SELECT * FROM Employee
