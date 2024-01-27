USE AdventureWorks2022
GO

CREATE VIEW Sales.vStoreDemographics AS
-- Use XMNLNAMESPACES to extract data from XML column - Demographics
WITH XMLNAMESPACES ('http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/StoreSurvey' AS ns)
SELECT 
	ss.BusinessEntityID
	, StoreName = ss.[Name]
	, AnnualSales = t.value('(./ns:AnnualSales)[1]', 'int')
	, AnnualRevenue = t.value('(./ns:AnnualRevenue)[1]', 'int')
	, BankName = t.value('(./ns:BankName)[1]', 'nvarchar(50)')
	, BusinessType = t.value('(./ns:BusinessType)[1]', 'nvarchar(5)')
	, YearOpened = t.value('(./ns:YearOpened)[1]', 'int')
	, Specialty = t.value('(./ns:Specialty)[1]', 'nvarchar(50)')
	, SquareFeet = t.value('(./ns:SquareFeet)[1]', 'int')
	, Brands = t.value('(./ns:Brands)[1]', 'nvarchar(30)')
	, Internet = t.value('(./ns:Internet)[1]', 'nvarchar(30)')
	, NumberEmployees = t.value('(./ns:NumberEmployees)[1]', 'int')
FROM AdventureWorks2022.Sales.Store ss 
-- Drilling down on StoreSurvey element using node() method
-- Using CROSS APPLY to join contents of StoreSurvey element in Sales.Store Table
CROSS APPLY Demographics.nodes('/ns:StoreSurvey') AS T(t)
