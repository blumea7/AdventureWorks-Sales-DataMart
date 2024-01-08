USE MAU_AdventureWorks2022_DW
GO

DROP TABLE IF EXISTS dbo.DimSalesPerson

-- Create SalesPereson dimension table

CREATE TABLE dbo.DimSalesPerson(
	SalesPersonID int IDENTITY (1,1) NOT NULL -- Autoincrementing Surrogate Key
	, FirstName dbo.NameType -- person 
	, MiddleName dbo.NameType -- person
	, LastName dbo.NameType -- person
	, FullName nvarchar(150) NOT NULL
	, NameSuffix nvarchar(10) -- person
	, JobTitle dbo.NameType -- emp
	, BirthDate date NOT NULL -- emp
	, GenderCode nchar(1) NOT NULL -- emp
	, Gender nvarchar(10) NOT NULL -- emp
	, PhoneNumber nvarchar(25) NOT NULL -- phone
	, EmailAddress dbo.NameType
	, SalesQuota float NOT NULL
	, Bonus float NOT NULL
	, CommissionPct float NOT NULL
	, DateCreated date NOT NULL
	, DateModified date NOT NULL
	, CONSTRAINT PK_DimSalesPerson_SalesPersonID PRIMARY KEY CLUSTERED (SalesPersonID ASC)
	, CONSTRAINT CK_DimSalesPerson_GenderCode CHECK (GenderCode IN ('F', 'M'))
	, CONSTRAINT CK_DimSalesPerson_Gender CHECK (Gender IN ('Female', 'Male'))
--	, CONSTRAINT DF_DimSalesPerson_SalesQuota DEFAULT ((0.00)) FOR [SalesQuota]
--	, CONSTRAINT DF_DimSalesPerson_Bonus DEFAULT ((0.00)) FOR [Bonus]
--	, CONSTRAINT DF_DimSalesPerson_CommissionPct DEFAULT ((0.00)) FOR [CommissionPct]
	, CONSTRAINT CK_DimSalesPerson_SalesQuota CHECK(SalesQuota >= 0.00)
	, CONSTRAINT CK_DimSalesPerson_Bonus CHECK(Bonus >= 0.00)
	, CONSTRAINT CK_DimSalesPerson_CommissionPct CHECK(CommissionPct >= 0.00)
)

INSERT INTO dbo.DimSalesPerson
SELECT 
	-- SalesPersonID int IDENTITY (1,1)
	FirstName = pp.FirstName
	, MiddleName = pp.MiddleName
	, LastName = pp.LastName
	, FullName = CONCAT(pp.FirstName, ' ', pp.MiddleName, ' ', pp.LastName)
	, NameSuffix = pp.Suffix
	, JobTitle = hre.JobTitle
	, BirthDate = hre.BirthDate
	, GenderCode = hre.Gender
	, Gender = CASE WHEN hre.Gender = 'F' THEN 'Female'
				    WHEN hre.Gender = 'M' THEN 'Male'
			   END
	, PhoneNumber = ppp.PhoneNumber
	, EmailAddress pea.[EmailAddress]
	, SalesQuota = ssp.SalesQuota
	, Bonus = ssp.Bonus
	, CommissionPct = ssp.CommissionPct
FROM [AdventureWorks2022].[Sales].[SalesPerson] ssp
INNER JOIN [AdventureWorks2022].[Person].[Person] pp ON pp.BusinessEntityID = ssp.BusinessEntityID
INNER JOIN [AdventureWorks2022].[HumanResources].[Employee] hre ON hre.BusinessEntityID = ssp.BusinessEntityID
INNER JOIN [AdventureWorks2022].[Person].[PersonPhone] ppp ON ppp.BusinessEntityID = ssp.BusinessEntityID
INNER JOIN [AdventureWorks2022].[Person].[EmailAddress] pea ON pea.BusinessEntityID = ssp.BusinessEntityID


-- Check data
SELECT TOP(10) * FROM dbo.DimSalesPerson