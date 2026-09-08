-- A. Constraints
-- 1. Add a HireDate column to Employee. Create a default constraint named def_EmpHireDate so new employees automatically receive the current date.
USE Company;
GO

ALTER TABLE EMPLOYEE
ADD EmpHireDate DATE;

ALTER TABLE Employee
ADD CONSTRAINT def_EmpHireDate DEFAULT GETDATE() FOR EmpHireDate;

	

ALTER TABLE  EMPLOYEE
ADD CONSTRAINT chk_EmpSex CHECK (Sex = 'M' OR Sex = 'F');
GO

ALTER TABLE EMPLOYEE
ADD CONSTRAINT chk_EmpSal CHECK (Salary >= 25000);
GO

ALTER TABLE EMPLOYEE
ADD CONSTRAINT chk_EmpAge18 CHECK ((DATEPART(year, EmpHireDate) - DATEPART(year, BDate)) >= 18);
GO

ALTER TABLE EMPLOYEE
ADD Password VARCHAR(20),
    CONSTRAINT chk_EmpPwd CHECK (Password IS NULL OR LEN(Password) >= 8);
GO
ALTER TABLE EMPLOYEE
ADD CONSTRAINT df_sex DEFAULT 'F' FOR Sex;
GO
ALTER TABLE EMPLOYEE
ADD CONSTRAINT rule_Salary CHECK (Salary >= 0 OR Salary < 10000) 

SELECT TABLE_NAME, CONSTRAINT_NAME, CONSTRAINT_TYPE FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS;


SELECT TABLE_NAME, CONSTRAINT_NAME, CONSTRAINT_TYPE FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS 
WHERE CONSTRAINT_TYPE = 'PRIMARY KEY' AND TABLE_NAME = 'Employee';


ALTER TABLE EMPLOYEE
DROP CONSTRAINT def_EmpHireDate;

ALTER TABLE EMPLOYEE
DROP CONSTRAINT chk_EmpSex;

ALTER TABLE EMPLOYEE
DROP CONSTRAINT chk_EmpSal;

ALTER TABLE EMPLOYEE
DROP CONSTRAINT chk_EmpPwd;

ALTER TABLE EMPLOYEE
DROP CONSTRAINT df_sex;

ALTER TABLE EMPLOYEE
DROP CONSTRAINT rule_Salary;

-- Command
-- Execution - verification result
-- (Paste a screenshot of the result here)
-- 2. Create a check constraint named chk_EmpSex so employee Sex accepts only 'M' or 'F' when inserted or updated.
-- 3. Create a check constraint named chk_EmpSal so an employee's Salary is at least 25000 when inserted or updated.
-- 4. Create a check constraint named chk_EmpAge18 so the employee is at least 18 years old on the HireDate when inserted or updated.
-- 5. Add a Password column of type varchar(20) to Employee. Create chk_EmpPwd so the value may be empty or must contain at least 8 characters.
-- 6. Create a default named df_sex with female as its default value when no value is entered. Apply df_sex to Employee.Sex.
-- 7. Create an input rule named rule_Salary that allows salaries from zero through 100000. Apply it to Employee.Salary.
-- 8. List the constraints currently present in a database, such as Company.
-- 9. List the primary-key constraint name in the Employee table of a database, such as Company.
-- 10. Drop the constraints created in questions 1, 2, 3, and 5: def_EmpHireDate, chk_EmpSex, chk_EmpSal, and chk_EmpPwd.
-- 11. Remove any default created on Employee.Sex and drop that default constraint.
-- 12. Remove any input rule created on Employee.Salary and drop that rule.
-- 13. List at least three SQL constraints that you know.
-- Answer: PRIMARY KEY, UNIQUE KEY, FOREIGN KEY, DEFAULT, CHECK



