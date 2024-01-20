USE AdventureWorks2022
GO

CREATE VIEW Person.vPersonDemographics AS
-- get data from XML column using WITH XMLNAMESPACES clause
WITH XMLNAMESPACES ('http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey' AS ns) 
SELECT	
BusinessEntityID
, FirstName
, MiddleName
, LastName
, FullName = CONCAT(FirstName, ' ', LastName)
, NameSuffix = Suffix
, FirstPurchaseDate = Demographics.value('(/ns:IndividualSurvey/ns:DateFirstPurchase)[1]', 'date')
, BirthDate = Demographics.value('(/ns:IndividualSurvey/ns:BirthDate)[1]', 'date')
, MaritalStatus = Demographics.value('(/ns:IndividualSurvey/ns:MaritalStatus)[1]', 'nchar(1)')
, YearlyIncome = Demographics.value('(/ns:IndividualSurvey/ns:YearlyIncome)[1]', 'nvarchar(50)')
, GenderCode = Demographics.value('(/ns:IndividualSurvey/ns:YearlyIncome)[1]', 'nchar(1)')
, Gender = CASE WHEN Demographics.value('(/ns:IndividualSurvey/ns:YearlyIncome)[1]', 'nchar(1)') = 'M' THEN 'MALE'
				WHEN Demographics.value('(/ns:IndividualSurvey/ns:YearlyIncome)[1]', 'nchar(1)') = 'F' THEN 'FEMALE'
		   END
, TotalChildren = Demographics.value('(/ns:IndividualSurvey/ns:TotalChildren)[1]', 'int')
, NumberChildrenAtHome = Demographics.value('(/ns:IndividualSurvey/ns:NumberChildrenAtHome)[1]', 'int')
, Education = Demographics.value('(/ns:IndividualSurvey/ns:Education)[1]', 'nvarchar(25)')
, Occupation = Demographics.value('(/ns:IndividualSurvey/ns:Occupation)[1]', 'nvarchar(25)')
, HomeOwnerIndicator = CASE WHEN Demographics.value('(/ns:IndividualSurvey/ns:HomeOwnerFlag)[1]','int') = 0 THEN 'Not Home Owner' --nvarchar(15)
							WHEN Demographics.value('(/ns:IndividualSurvey/ns:HomeOwnerFlag)[1]','int') = 1 THEN 'Home Owner'
					   END
, NumberCarsOwned = Demographics.value('(/ns:IndividualSurvey/ns:NumberCarsOwned)[1]', 'int')
, CommuteDistance = Demographics.value('(/ns:IndividualSurvey/ns:CommuteDistance)[1]', 'nvarchar(25)')
FROM
AdventureWorks2022.Person.Person