USE AdventureWorksDW2022
GO

DROP TABLE IF EXISTS dbo.DimCustomer

-- Create table for Customer Dimension
CREATE TABLE dbo.DimCustomer(
	CustomerID int IDENTITY(1,1) NOT NULL -- Autoincrementing Surrogate Key
	, AccountNumber nvarchar(10) NOT NULL -- AlternatePK
	, GeographyID int NOT NULL -- FK 
	, FirstName dbo.NameType 
	, MiddleName dbo.NameType
	, LastName dbo.NameType
	, FullName nvarchar(150) NOT NULL
	, NameSuffix nvarchar(10)
	, EmailAddress nvarchar(50) NOT NULL
	, PhoneNumber nvarchar(25) NOT NULL
)

SELECT 
	DISTINCT
	-- CustomerID
	AccountNumber = sc.AccountNumber
	, GeographyID = ddg.GeographyID
	, FirstName = pp.FirstName
	, MiddleName = pp.MiddleName
	, LastName = pp.LastName
	, FullName = CONCAT(pp.FirstName, ' ', pp.LastName)
	, pp.Suffix
	, pea.EmailAddress
	, ppp.PhoneNumber
FROM AdventureWorks2022.Sales.Customer sc
INNER JOIN AdventureWorks2022.Person.Person pp ON pp.BusinessEntityID = sc.PersonID
INNER JOIN AdventureWorks2022.Person.EmailAddress pea ON pea.BusinessEntityID = sc.PersonID
INNER JOIN AdventureWorks2022.Person.PersonPhone ppp ON ppp.BusinessEntityID = sc.PersonID
INNER JOIN AdventureWorks2022.Person.BusinessEntityAddress bea ON bea.BusinessEntityID = PersonID
INNER JOIN AdventureWorks2022.Person.Address pa ON pa.AddressID = bea.AddressID
INNER JOIN AdventureWorks2022.Person.StateProvince	psp ON psp.StateProvinceID = pa.StateProvinceID
INNER JOIN MAU_AdventureWorks2022_DW.dbo.DimGeography ddg 
	ON (ddg.City = pa.City 
		AND ddg.PostalCode = pa.PostalCode 
		AND ddg.StateCode = psp.StateProvinceCode
		AND ddg.CountryCode	= psp.CountryRegionCode 
	)
WHERE PersonID IS NOT NULL