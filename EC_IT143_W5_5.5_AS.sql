/*****************************************************************************************************************
NAME:        EC_IT143_W5.5_InterviewDemo4_XX.sql
PURPOSE:     Identify the top three highest-earning employees within each individual department.
             Demonstrates advanced proficiency with CTEs and Window Functions.

MODIFICATION LOG:
Ver      Date        Author           Description
-----    ----------  ---------------  -------------------------------------------------------------------------
1.0      06/08/2026  [Your Name]      Initial production implementation for interview demonstration.
******************************************************************************************************************/

-- Step 1: Create a staging dataset mapping your existing Employee data to departments
WITH DepartmentalEmployees AS (    
    SELECT 
        emp_id,
        emp_name,
        salary,
        -- Dynamically assigning departments for demonstration purposes
        CASE 
            WHEN emp_id % 2 = 0 THEN 'HR'
            WHEN emp_id % 3 = 0 THEN 'Engineering'
            ELSE 'Sales'
        END AS department_name
    FROM dbo.Employee
),

-- Step 2: Apply the partition window function to rank salaries within each department
RankedSalaries AS (
    SELECT 
        department_name,
        emp_name,
        salary,
        DENSE_RANK() OVER (PARTITION BY department_name ORDER BY salary DESC) AS salary_rank
    FROM DepartmentalEmployees
)

-- Step 3: Extract the final top 3 compensation tiers per department
SELECT 
    department_name,
    emp_name,
    salary,
    salary_rank
FROM RankedSalaries
WHERE salary_rank <= 3
ORDER BY 
    department_name ASC, 
    salary_rank ASC;