USE AdventureWorks2022
GO

CREATE VIEW Person.vCustomerDemographics AS
-- get data from XML column using WITH XMLNAMESPACES clause
WITH XMLNAMESPACES ('http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey' AS ns) 
SELECT	
BusinessEntityID
, FirstName
, MiddleName
, LastName
, FullName = CONCAT(FirstName, ' ', LastName)
, NameSuffix = Suffix
, FirstPurchaseDate = t.value('(ns:DateFirstPurchase)[1]', 'date')
, BirthDate = t.value('(ns:BirthDate)[1]', 'date')
, MaritalStatus = t.value('(ns:MaritalStatus)[1]', 'nchar(1)')
, YearlyIncome = t.value('(ns:YearlyIncome)[1]', 'nvarchar(50)')
, GenderCode = t.value('(ns:Gender)[1]', 'nchar(1)')
, Gender = CASE WHEN t.value('(ns:Gender)[1]', 'nchar(1)') = 'M' THEN 'MALE'
				WHEN t.value('(ns:Gender)[1]', 'nchar(1)') = 'F' THEN 'FEMALE'
		   END
, TotalChildren = t.value('(ns:TotalChildren)[1]', 'int')
, NumberChildrenAtHome = t.value('(ns:NumberChildrenAtHome)[1]', 'int')
, Education = t.value('(ns:Education)[1]', 'nvarchar(25)')
, Occupation = t.value('(ns:Occupation)[1]', 'nvarchar(25)')
, HomeOwnerIndicator = CASE WHEN t.value('(ns:HomeOwnerFlag)[1]','int') = 0 THEN 'Not Home Owner' --nvarchar(15)
							WHEN t.value('(ns:HomeOwnerFlag)[1]','int') = 1 THEN 'Home Owner'
					   END
, NumberCarsOwned = t.value('(ns:NumberCarsOwned)[1]', 'int')
, CommuteDistance = t.value('(ns:CommuteDistance)[1]', 'nvarchar(25)')
FROM
AdventureWorks2022.Person.Person
-- Drill down one level to the IndividualSurvey node using nodes() method
-- Joining IndividualSurvey node to the Person table using CROSS APPLY
CROSS APPLY Demographics.nodes('/ns:IndividualSurvey') as T(t)
