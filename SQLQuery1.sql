-- Q: How do I display a classic 'Hello World' message in T-SQL?

-- A: I can use a simple SELECT statement to output the literal text string.

SELECT 'Hello World' AS My_Message;
GO

-- =============================================
-- Author:      Anika Saidi
-- Create date: 2026-06-02
-- Description: View to yield the Hello World message.
-- =============================================
USE EC_IT143_AS;
GO

CREATE OR ALTER VIEW dbo.v_hello_world AS
SELECT 'Hello World' AS My_Message;
GO

USE EC_IT143_AS;
GO

-- Drop the target table if it already exists to allow clean re-runs
IF OBJECT_ID('dbo.t_hello_world', 'U') IS NOT NULL
    DROP TABLE dbo.t_hello_world;

-- Create table structure directly from the view
SELECT v.My_Message 
INTO dbo.t_hello_world
FROM dbo.v_hello_world v;

USE EC_IT143_AS;
GO

-- Alter the table structure to enforce NOT NULL before applying a Primary Key
ALTER TABLE dbo.t_hello_world
ALTER COLUMN My_Message VARCHAR(50) NOT NULL;

-- Add a Primary Key constraint
ALTER TABLE dbo.t_hello_world
ADD CONSTRAINT PK_t_hello_world PRIMARY KEY (My_Message);

USE EC_IT143_AS;
GO

-- Empty the target table completely
TRUNCATE TABLE dbo.t_hello_world;

-- Reload live data straight from your established view
INSERT INTO dbo.t_hello_world (My_Message)
SELECT My_Message 
FROM dbo.v_hello_world;

-- =============================================
-- Author:      Your Name (xx)
-- Create date: 2026-06-02
-- Description: Stored Procedure to perform automated ETL reload for t_hello_world.
-- =============================================
USE EC_IT143_AS;
GO

CREATE OR ALTER PROCEDURE dbo.usp_reload_hello_world
AS
BEGIN
    SET NOCOUNT ON;

    -- Execute reload sequence
    TRUNCATE TABLE dbo.t_hello_world;

    INSERT INTO dbo.t_hello_world (My_Message)
    SELECT My_Message 
    FROM dbo.v_hello_world;
END;
GO

USE EC_IT143_AS;
GO

-- Execute the procedure to refresh data processing
EXEC dbo.usp_reload_hello_world;

-- Verify data landed correctly in the table
SELECT * FROM dbo.t_hello_world;