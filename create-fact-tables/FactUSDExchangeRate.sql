USE MAU_AdventureWorks2022_DW
GO

DROP TABLE IF EXISTS dbo.FactUSDExchangeRate

-- Populate and Create FactUSDExchangeRate
SELECT
	RateDateKey = ddd.DateKey
	, RateDate = sc.CurrencyRateDate
	, CurrencyUniqueID = dc.CurrencyUniqueID
	, AverageRate = sc. AverageRate
	, EndOfDayRate = sc.EndOfDayRate
INTO dbo.FactUSDExchangeRate -- Automatically creates FactUSDExchangeRate table
FROM AdventureWorks2022.Sales.CurrencyRate sc 
INNER JOIN MAU_AdventureWorks2022_DW.dbo.DimCurrency dc ON dc.CurrencyCode = sc.ToCurrencyCode
INNER JOIN MAU_AdventureWorks2022_DW.dbo.DimDate ddd ON ddd.Date = sc.CurrencyRateDate

-- View Data
SELECT TOP(10) * FROM dbo.FactUSDExchangeRate 
