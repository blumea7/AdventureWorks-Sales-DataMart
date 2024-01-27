USE MAU_AdventureWorks2022_DW
GO

DROP TABLE IF EXISTS dbo.DimCustomer

-- Create table for Customer Dimension
CREATE TABLE dbo.DimCustomer(
	CustomerID int IDENTITY(1,1) NOT NULL -- Autoincrementing Surrogate Key
	, AccountNumber nvarchar(10) UNIQUE NOT NULL -- Alternate Primary Key
	, GeographyID int NOT NULL -- Foreign Key
	, FirstName dbo.NameType 
	, MiddleName dbo.NameType
	, LastName dbo.NameType
	, FullName nvarchar(150) NOT NULL
	, NameSuffix nvarchar(10)
	, EmailAddress nvarchar(50) NOT NULL
	, PhoneNumber nvarchar(25) NOT NULL
	, BirthDate date NOT NULL
	, MaritalStatus nchar(1) NOT NULL
	, YearlyIncome nvarchar(50)
	, GenderCode nchar(1) NOT NULL
	, TotalChildren int
	, NumberChildrenAtHome int
	, Education nvarchar(25)
	, Occupation nvarchar(25)
	, HomeOwnerIndicatior nvarchar(15)
	, NumberCarsOwned int
	, CommuteDistance nvarchar(25)
	, DateCreated date
	, DateModified date
	, CONSTRAINT PK_DimCustomer_CustomerID PRIMARY KEY CLUSTERED (CustomerID ASC)
	, CONSTRAINT FK_DimCustomer_GeographyID FOREIGN KEY (GeographyID) REFERENCES MAU_AdventureWorks2022_DW.dbo.DimGeography (GeographyID)
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
	, NameSuffix = pp.Suffix 
	, EmailAddress = pea.EmailAddress
	, PhoneNumber = ppp.PhoneNumber
	, BirthDate = vcd.BirthDate
	, MaritalStatus = vcd.MaritalStatus
	, YearlyIncome = vcd.YearlyIncome
	, GenderCode = vcd.GenderCode
	, TotalChildren = vcd.TotalChildren
	, NumberChildrenAtHome = vcd.NumberChildrenAtHome
	, Education = vcd.Education
	, Occupation = vcd.Occupation
	, HomeOwnerIndicator = vcd.HomeOwnerIndicator
	, NumberCarsOwned = vcd.NumberCarsOwned
	, CommuteDistance = vcd.CommuteDistance
	, DateCreated = GETDATE()
	, DateModified	= GETDATE()
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
INNER JOIN AdventureWorks2022.Person.vCustomerDemographics vcd ON vcd.BusinessEntityID = sc.PersonID
WHERE PersonID IS NOT NULL