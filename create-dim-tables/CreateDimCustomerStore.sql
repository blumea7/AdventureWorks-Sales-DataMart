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

