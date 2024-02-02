USE MAU_AdventureWorks2022_DW
GO

DROP TABLE IF EXISTS dbo.DimCurrency

-- Create DimCurrency Table
CREATE TABLE dbo.DimCurrency (
	CurrencyUniqueID int IDENTITY(1,1) -- Autoincrementing Surrogate Key
	, CurrencyCode nchar(3) UNIQUE NOT NULL
	, Currency dbo.NameType
	, DateCreated date NOT NULL
	, DateModified date NOT NULL
	, CONSTRAINT PK_DimCurrency_CurrencyUniqueID PRIMARY KEY CLUSTERED (CurrencyUniqueID)
)

-- Populate DimCurrency Table
INSERT INTO dbo.DimCurrency
SELECT 
	-- CurrencyUniqueID 
	CurrencyCode = sc.CurrencyCode
	, Currency = sc.[Name]
	, DateCreated = GETDATE()
	, DateModified = GETDATE()
FROM AdventureWorks2022.Sales.Currency sc

-- View data
SELECT TOP(10) * FROM dbo.DimCurrency
