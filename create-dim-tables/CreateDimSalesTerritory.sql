USE MAU_AdventureWorks2022_DW
GO

DROP TABLE IF EXISTS dbo.DimSalesTerritory

-- Create SalesTerritory Dimension Table
CREATE TABLE dbo.DimSalesTerritory (
	SalesTerritoryID int IDENTITY (1,1) NOT NULL -- Autoincrementing Surrogate Key
	, SalesTerritory dbo.NameType
	, CountryCode nvarchar(3) NOT NULL
	, Country nvarchar(50) NOT NULL
	, TerritoryGroup nvarchar(50) NOT NULL
	, DateCreated date NOT NULL
	, DateModified date NOT NULL
	, CONSTRAINT PK_DimSalesTerritory_SalesTerritoryID PRIMARY KEY CLUSTERED (SalesTerritoryID ASC)
)

-- Populate  SalesTerritory Dimension Table 
INSERT INTO dbo.DimSalesTerritory
SELECT 
	-- SalesTerritoryID int IDENTITY (1,1) 
	SalesTerritory = sst.[Name]
	, CountryCode = sst.CountryRegionCode
	, Country = pcr.[Name]
	, TerritoryGroup = sst.[Group]
	, DateCreated = GETDATE()
	, DateModified = GETDATE()
FROM [AdventureWorks2022].[Sales].[SalesTerritory] sst
INNER JOIN [AdventureWorks2022].[Person].[CountryRegion] pcr ON pcr.CountryRegionCode = sst.CountryRegionCode

-- Check Data
SELECT TOP(10) * FROM dbo.DimSalesTerritory
