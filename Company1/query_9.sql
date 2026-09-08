-- Retrieve some information
SELECT FName, LName, PNo, Hours FROM Works_On JOIN Employee e ON ESSN = e.SSN