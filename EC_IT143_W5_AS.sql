IF OBJECT_ID('dbo.v_community_summary', 'V') IS NOT NULL
    DROP VIEW dbo.v_community_summary;
GO

CREATE VIEW dbo.v_community_summary AS 
SELECT 
    COUNT(emp_id) AS TotalEmployees,
    SUM(salary) AS TotalSalaryPayout,
    AVG(salary) AS AverageEmployeeSalary
FROM dbo.Employee;
GO

SELECT * FROM dbo.v_community_summary;