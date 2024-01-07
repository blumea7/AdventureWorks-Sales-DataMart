USE MAU_AdventureWorks2022_DW
GO

-- Create a set of Numbers from 0 to 1,000,000 to be used as the base set for creating DimDate

DROP TABLE IF EXISTS dbo.Numbers

;WITH NumbersCTE AS (
	SELECT ROW_NUMBER() OVER(ORDER BY (SELECT NULL)) - 1 AS N
	FROM sys.columns sc1 CROSS JOIN sys.columns sc2
)

SELECT
Number = N
INTO dbo.Numbers  -- This will automatically create the table from the SELECT statement
FROM NumbersCTE
WHERE N <= 1000000


-- Check Data

SELECT TOP (10) * FROM dbo.Numbers
