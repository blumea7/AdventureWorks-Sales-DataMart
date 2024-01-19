USE MAU_AdventureWorks2022_DW
GO

DROP TABLE IF EXISTS dbo.DimGeography	

-- Create Geography Dimension Table
CREATE TABLE dbo.DimGeography (
	GeographyID int IDENTITY (1,1) NOT NULL -- Autoincrementing Surrogate Key
	, City nvarchar(30) NOT NULL
	, StateCode nvarchar(3) NOT NULL
	, [State] dbo.NameType
	, [City-State] nvarchar(80) NOT NULL
	, CountryCode nvarchar(3) NOT NULL
	, Country dbo.NameType
	, SalesTerritory dbo.NameType
	, SalesTerritoryGroup nvarchar(50) NOT NULL
	, PostalCode nvarchar(15) NOT NULL 
	, DateCreated date NOT NULL
	, DateModified date NOT NULL
	CONSTRAINT PK_DimGeography_AddressID PRIMARY KEY CLUSTERED (GeographyID ASC)
)

-- Populate Geography dimension table
INSERT INTO dbo.DimGeography
SELECT DISTINCT
	-- GeographyID  // no need to populate since automatically generated by sql server
	 City = pa.City
	, StateCode = psp.StateProvinceCode
	, [State] = psp.[Name]
	, [City-State] = CONCAT(pa.City,' ', psp.[Name])
	, CountryCode = pcr.CountryRegionCode
	, Country = pcr.[Name]
	, SalesTerritory = sst.[Name]
	, SalesTerritoryGroup = sst.[Group]
	, PostalCode = pa.PostalCode
	, DateCreated = GETDATE()
	, DateModified = GETDATE()
FROM [AdventureWorks2022].[Person].[Address] pa
INNER JOIN [AdventureWorks2022].[Person].[StateProvince] psp ON psp.StateProvinceID = pa.StateProvinceID
INNER JOIN [AdventureWorks2022].[Person].[CountryRegion] pcr ON pcr.CountryRegionCode = psp.CountryRegionCode
INNER JOIN [AdventureWorks2022].[Sales].[SalesTerritory] sst ON sst.TerritoryID = psp.TerritoryID


-- Check data
SELECT TOP(10) * FROM dbo.DimGeography