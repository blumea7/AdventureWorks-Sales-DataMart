USE AdventureWorks2022
GO

SELECT 
	--DISTINCT sc.StoreID
	 dst.SalesTerritoryID
	, dsp.SalesPersonID
	, StoreName = ss.[Name]
	, ss.*
FROM AdventureWorks2022.Sales.Customer sc
INNER JOIN AdventureWorks2022.Sales.Store ss ON ss.BusinessEntityID = sc.StoreID
INNER JOIN AdventureWorks2022.Sales.SalesPerson ssp ON ssp.BusinessEntityID = ss.SalesPersonID
INNER JOIN AdventureWorks2022.Person.Person pp ON pp.BusinessEntityID = ssp.BusinessEntityID
INNER JOIN MAU_AdventureWorks2022_DW.dbo.DimSalesPerson dsp ON
	dsp.FirstName = pp.FirstName
	AND dsp.MiddleName = pp.MiddleName
	AND dsp.LastName = pp.LastName
INNER JOIN AdventureWorks2022.Sales.SalesTerritory sst ON sst.TerritoryID = sc.TerritoryID
INNER JOIN MAU_AdventureWorks2022_DW.dbo.DimSalesTerritory dst ON dst.SalesTerritory = sst.[Name]
WHERE StoreID IS NOT NULL
