USE MAU_AdventureWorks2022_DW
GO

DROP TABLE IF EXISTS dbo.DimCustomerStore 

-- Create DimCustomerStore Table
CREATE TABLE dbo.DimCustomerStore(
	StoreUniqueID int IDENTITY(1,1) -- Autoincrementing surrogate key
	, SalesTerritoryUniqueID int NOT NULL -- Foreign key to DimSalesTerritory table
	, SalesPersonUniqueID int NOT NULL  -- Foreign key to DimSalesPerson table
	, StoreName dbo.NameType
	, AnnualSales int 
	, AnnualRevenue int 
	, BankName nvarchar(50)
	, BusinessType nvarchar(5)
	, YearOpened int
	, Specialty nvarchar(50)
	, SquareFeet int
	, Brands nvarchar(30)
	, Internet nvarchar(30)
	, NumberEmployees int
	, DateCreated date
	, DateModified date
	, CONSTRAINT PK_DimCustomerStore_StoreID PRIMARY KEY CLUSTERED (StoreUniqueID ASC)
)


-- Populate DimCustomerStore Table with data from OLTP database
INSERT INTO dbo.DimCustomerStore
SELECT DISTINCT dst.SalesTerritoryUniqueID
	, dsp.SalesPersonUniqueID
	, StoreName = ss.[Name]
	, AnnualSales = vsd.AnnualSales
	, AnnualRevenue = vsd.AnnualRevenue 
	, BankName = vsd.BankName
	, BusinessType = vsd.BusinessType
	, YearOpened = vsd.YearOpened
	, Specialty = vsd.Specialty
	, SquareFeet = vsd.SquareFeet
	, Brands = vsd.Brands
	, Internet = vsd.Internet
	, NumberEmployees = vsd.NumberEmployees
	, DateCreated = GETDATE()
	, DateModified = GETDATE()
FROM AdventureWorks2022.Sales.Customer sc
INNER JOIN AdventureWorks2022.Sales.Store ss ON ss.BusinessEntityID = sc.StoreID
INNER JOIN AdventureWorks2022.Sales.SalesPerson ssp ON ssp.BusinessEntityID = ss.SalesPersonID
INNER JOIN AdventureWorks2022.Person.Person pp ON pp.BusinessEntityID = ssp.BusinessEntityID
LEFT JOIN MAU_AdventureWorks2022_DW.dbo.DimSalesPerson dsp ON
	dsp.FirstName = pp.FirstName
	AND dsp.LastName = pp.LastName
INNER JOIN AdventureWorks2022.Sales.SalesTerritory sst ON sst.TerritoryID = sc.TerritoryID
LEFT JOIN MAU_AdventureWorks2022_DW.dbo.DimSalesTerritory dst ON dst.SalesTerritory = sst.[Name]
LEFT JOIN AdventureWorks2022.Sales.vStoreDemographics vsd ON vsd.BusinessEntityID = ss.BusinessEntityID
WHERE sc.StoreID IS NOT NULL


-- Show sample data

SELECT TOP(10) * FROM dbo.DimCustomerStore

-- Add SquareFeetGrouping
ALTER TABLE dbo.DimCustomerStore
ADD SquareFeetGroup VARCHAR(15)

UPDATE dbo.DimCustomerStore
SET SquareFeetGroup = 
	(CASE WHEN SquareFeet BETWEEN 0 AND 10000 THEN '0 - 10000'
		 WHEN SquareFeet BETWEEN 10001 AND 20000 THEN '10000 - 20000'
		 WHEN SquareFeet BETWEEN 20001 AND 30000 THEN '20000 - 30000'
		 WHEN SquareFeet BETWEEN 30001 AND 40000 THEN '30000 - 40000'
	     WHEN SquareFeet BETWEEN 40001 AND 50000 THEN '40001 - 50000'
	     WHEN SquareFeet BETWEEN 50001 AND 60000 THEN '50001 - 60000'
	     WHEN SquareFeet BETWEEN 60001 AND 70000 THEN '60001 - 70000'
	     WHEN SquareFeet BETWEEN 70001 AND 80000 THEN '70001 - 80000'
		 ELSE NULL
	END)