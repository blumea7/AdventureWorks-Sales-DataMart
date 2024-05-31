### Adventure Works Overview
-------------------
AdventureWorks is a sample database developed by Microsoft to showcase capabilities of SQL Server.
Its data is based on a fictittious bicycle manufacturer and seller. Microsoft presents two formats of Adventureworks database -
OLTP and Data Warehouse, which you may access [here](https://learn.microsoft.com/en-us/sql/samples/adventureworks-install-configure?view=sql-server-ver16&tabs=ssms): 

### Data Mart Setup
-------------------
---


### Tables
-------------------
The ff. tables, except dbo.Numbers, represent the components of the Sales Adventure Works Data Mart, which follow the star schema model.
The order of tables are ranked by their use of data space, ordered in descending manner.

#### 1. dbo.Numbers
##### Description
Contains Numbers from 0 to 1,000,000; Used to perform a set-based implementation of Calendar Table.

##### Properties
| Date   Created         | 01/06/2024         |
|------------------------|--------------------|
|  Number of Rows        |    1,000,001       |
|  Data Space Used (KB)  |            16,808  |
| Index Space Used (KB)  | 8                  |

##### Columns
| Primary Key | Column | Data Type | Length | Default Value | Allow Nulls | Source Table |
|-------------|--------|-----------|--------|---------------|-------------|--------------|
| NO          | Number | bigint    | 8      | NULL          | YES         | Numbers      |



#### 2. dbo.FactStoreSales
##### Description
Sales fact table for orders made by store resellers with a grain of one (1) row per line in a receipt. This contains both observed (e.g., quantity) and derived (e.g., net profit) measures.

##### Properties
| Date   Created         | 02/17/2024         |
|------------------------|--------------------|
|  Number of Rows        |            60,919  |
|  Data Space Used (KB)  |            14,776  |
| Index Space Used (KB)  | 8                  |

##### Columns
| Primary Key | Column             | Data Type | Length | Default Value | Allow Nulls |
|-------------|--------------------|-----------|--------|---------------|-------------|
| NO          | OrderID            | nvarchar  | 25     | NULL          | NO          |
| NO          | SalesOrderDetailID | int       | 4      | NULL          | NO          |
| NO          | PONumber           | nvarchar  | 25     | NULL          | YES         |
| NO          | ChannelKey         | int       | 4      | NULL          | NO          |
| NO          | OrderDateKey       | int       | 4      | NULL          | NO          |
| NO          | DueDateKey         | int       | 4      | NULL          | NO          |
| NO          | ShipDateKey        | int       | 4      | NULL          | NO          |
| NO          | CustomerKey        | int       | 4      | NULL          | NO          |
| NO          | SalesPersonKey     | int       | 4      | NULL          | YES         |
| NO          | ProductKey         | int       | 4      | NULL          | NO          |
| NO          | CurrencyKey        | int       | 4      | NULL          | NO          |
| NO          | PromoKey           | int       | 4      | NULL          | NO          |
| NO          | TerritoryKey       | int       | 4      | NULL          | NO          |
| NO          | UnitPrice          | money     | 8      | NULL          | YES         |
| NO          | Quantity           | smallint  | 2      | NULL          | NO          |
| NO          | LinePrice          | money     | 8      | NULL          | YES         |
| NO          | Discount           | money     | 8      | NULL          | NO          |
| NO          | UnitPriceDiscount  | money     | 8      | NULL          | YES         |
| NO          | LineDiscount       | money     | 8      | NULL          | YES         |
| NO          | SalesAmount        | numeric   | 17     | NULL          | YES         |
| NO          | TaxAmount          | numeric   | 17     | NULL          | YES         |
| NO          | Freight            | numeric   | 17     | NULL          | YES         |
| NO          | TotalDue           | numeric   | 17     | NULL          | YES         |
| NO          | UnitProductCost    | money     | 8      | NULL          | YES         |
| NO          | LineProductCost    | money     | 8      | NULL          | YES         |
| NO          | NetProfit          | numeric   | 17     | NULL          | YES         |

#### 3. dbo.FactInternetSales
##### Description
Sales fact table for orders made by individual persons with a grain of one (1) row per line in a receipt. This contains both observed (e.g., quantity) and derived (e.g., net profit) measures.

##### Properties
| Date   Created         | 02/17/2024         |
|------------------------|--------------------|
|  Number of Rows        |            60,398  |
|  Data Space Used (KB)  |            14,648  |
| Index Space Used (KB)  | 8                  |

##### Columns
| Primary Key | Column             | Data Type | Length | Default Value | Allow Nulls |
|-------------|--------------------|-----------|--------|---------------|-------------|
| NO          | OrderID            | nvarchar  | 25     | NULL          | NO          |
| NO          | SalesOrderDetailID | int       | 4      | NULL          | NO          |
| NO          | PONumber           | nvarchar  | 25     | NULL          | YES         |
| NO          | ChannelKey         | int       | 4      | NULL          | NO          |
| NO          | OrderDateKey       | int       | 4      | NULL          | NO          |
| NO          | DueDateKey         | int       | 4      | NULL          | NO          |
| NO          | ShipDateKey        | int       | 4      | NULL          | NO          |
| NO          | CustomerKey        | int       | 4      | NULL          | NO          |
| NO          | SalesPersonKey     | int       | 4      | NULL          | YES         |
| NO          | ProductKey         | int       | 4      | NULL          | NO          |
| NO          | CurrencyKey        | int       | 4      | NULL          | NO          |
| NO          | PromoKey           | int       | 4      | NULL          | NO          |
| NO          | TerritoryKey       | int       | 4      | NULL          | NO          |
| NO          | UnitPrice          | money     | 8      | NULL          | YES         |
| NO          | Quantity           | smallint  | 2      | NULL          | NO          |
| NO          | LinePrice          | money     | 8      | NULL          | YES         |
| NO          | Discount           | money     | 8      | NULL          | NO          |
| NO          | UnitPriceDiscount  | money     | 8      | NULL          | YES         |
| NO          | LineDiscount       | money     | 8      | NULL          | YES         |
| NO          | SalesAmount        | numeric   | 17     | NULL          | YES         |
| NO          | TaxAmount          | numeric   | 17     | NULL          | YES         |
| NO          | Freight            | numeric   | 17     | NULL          | YES         |
| NO          | TotalDue           | numeric   | 17     | NULL          | YES         |
| NO          | UnitProductCost    | money     | 8      | NULL          | YES         |
| NO          | LineProductCost    | money     | 8      | NULL          | YES         |
| NO          | NetProfit          | numeric   | 17     | NULL          | YES         |


#### 4. dbo.DimCustomer
##### Description
Dimension table containing personal information and profile of individuals who has transaction record/s in FactInternetSales table.

##### Properties
| Date   Created         | 02/10/2024           |
|------------------------|----------------------|
|  Number of Rows        |            18,485    |
|  Data Space Used (KB)  |               6,552  |
| Index Space Used (KB)  | 32                   |

##### Columns
| Primary Key | Column               | Data Type | Length | Default Value | Allow Nulls | CONSTRAINT_NAME           |
|-------------|----------------------|-----------|--------|---------------|-------------|---------------------------|
| YES         | CustomerUniqueID     | int       | 4      | NULL          | NO          | PK_DimCustomer_CustomerID |
| NO          | AccountNumber        | nvarchar  | 10     | NULL          | NO          | NULL                      |
| YES         | GeographyUniqueID    | int       | 4      | NULL          | NO          | PK_DimGeography_AddressID |
| NO          | FirstName            | nvarchar  | 50     | NULL          | YES         | NULL                      |
| NO          | MiddleName           | nvarchar  | 50     | NULL          | YES         | NULL                      |
| NO          | LastName             | nvarchar  | 50     | NULL          | YES         | NULL                      |
| NO          | FullName             | nvarchar  | 150    | NULL          | NO          | NULL                      |
| NO          | NameSuffix           | nvarchar  | 10     | NULL          | YES         | NULL                      |
| NO          | EmailAddress         | nvarchar  | 50     | NULL          | NO          | NULL                      |
| NO          | PhoneNumber          | nvarchar  | 25     | NULL          | NO          | NULL                      |
| NO          | BirthDate            | date      | 3      | NULL          | NO          | NULL                      |
| NO          | MaritalStatus        | nchar     | 1      | NULL          | YES         | NULL                      |
| NO          | YearlyIncome         | nvarchar  | 50     | NULL          | YES         | NULL                      |
| NO          | GenderCode           | nchar     | 1      | NULL          | YES         | NULL                      |
| NO          | Gender               | nvarchar  | 10     | NULL          | NO          | NULL                      |
| NO          | TotalChildren        | int       | 4      | NULL          | YES         | NULL                      |
| NO          | NumberChildrenAtHome | int       | 4      | NULL          | YES         | NULL                      |
| NO          | Education            | nvarchar  | 25     | NULL          | YES         | NULL                      |
| NO          | Occupation           | nvarchar  | 25     | NULL          | YES         | NULL                      |
| NO          | HomeOwnerIndicator   | nvarchar  | 15     | NULL          | YES         | NULL                      |
| NO          | NumberCarsOwned      | int       | 4      | NULL          | YES         | NULL                      |
| NO          | CommuteDistance      | nvarchar  | 25     | NULL          | YES         | NULL                      |
| NO          | DateCreated          | date      | 3      | NULL          | NO          | NULL                      |
| NO          | DateModified         | date      | 3      | NULL          | NO          | NULL                      |


#### 5. dbo.DimDate
##### Description
Dimension table containing dates from 2010 to 2049, as well as their attributes such as year, month, day and so on.

##### Properties
| Date   Created         | 02/10/2024           |
|------------------------|----------------------|
|  Number of Rows        |            14,611    |
|  Data Space Used (KB)  |               1,968  |
| Index Space Used (KB)  | 16                   |

##### Columns
| Primary Key | Column                 | Data Type | Length | Default Value | Allow Nulls | CONSTRAINT_NAME    |
|-------------|------------------------|-----------|--------|---------------|-------------|--------------------|
| YES         | DateKey                | int       | 4      | NULL          | NO          | PK_DimDate_DateKey |
| NO          | Date                   | date      | 3      | NULL          | NO          | NULL               |
| NO          | Year                   | int       | 4      | NULL          | NO          | NULL               |
| NO          | YearHalfID             | char      | 6      | NULL          | NO          | NULL               |
| NO          | YearHalf               | int       | 4      | NULL          | NO          | NULL               |
| NO          | QuarterID              | char      | 6      | NULL          | NO          | NULL               |
| NO          | Quarter                | int       | 4      | NULL          | NO          | NULL               |
| NO          | MonthID                | char      | 6      | NULL          | NO          | NULL               |
| NO          | Month                  | int       | 4      | NULL          | NO          | NULL               |
| NO          | MonthName              | varchar   | 10     | NULL          | NO          | NULL               |
| NO          | ShortMonthName         | char      | 3      | NULL          | NO          | NULL               |
| NO          | WeekID                 | char      | 7      | NULL          | NO          | NULL               |
| NO          | WeekofYear             | int       | 4      | NULL          | NO          | NULL               |
| NO          | WeekofMonth            | int       | 4      | NULL          | NO          | NULL               |
| NO          | DayOfYear              | int       | 4      | NULL          | NO          | NULL               |
| NO          | DayOfMonth             | int       | 4      | NULL          | NO          | NULL               |
| NO          | DayOfWeek              | int       | 4      | NULL          | NO          | NULL               |
| NO          | DayName                | varchar   | 10     | NULL          | NO          | NULL               |
| NO          | ShortDayName           | char      | 3      | NULL          | NO          | NULL               |
| NO          | CurrentDayIndicator    | varchar   | 16     | NULL          | NO          | NULL               |
| NO          | IsOnOrBeforeCurrentDay | varchar   | 3      | NULL          | NO          | NULL               |
| NO          | HolidayIndicator       | varchar   | 15     | NULL          | NO          | NULL               |

#### 6. dbo.FactUSDExchangeRate
##### Description
Fact table containing daily exchange rate of USD to other currency.

##### Properties
| Date   Created         | 02/17/2024              |
|------------------------|-------------------------|
|  Number of Rows        |            13,532       |
|  Data Space Used (KB)  |                    552  |
| Index Space Used (KB)  | 8                       |

##### Columns
| Primary Key | Column                 | Data Type | Length | Default Value | Allow Nulls | CONSTRAINT_NAME                 |
|-------------|------------------------|-----------|--------|---------------|-------------|---------------------------------|
| NO          | RateDateKey            | int       | 4      | NULL          | NO          | NULL                            |
| NO          | RateDate               | datetime  | 8      | NULL          | NO          | NULL                            |
| YES         | CurrencyUniqueID       | int       | 4      | NULL          | NO          | PK_DimCurrency_CurrencyUniqueID |
| NO          | AverageRate            | money     | 8      | NULL          | NO          | NULL                            |
| NO          | EndOfDayRate           | money     | 8      | NULL          | NO          | NULL                            |
| YES         | DateKey                | int       | 4      | NULL          | NO          | PK_DimDate_DateKey              |
| NO          | Date                   | date      | 3      | NULL          | NO          | NULL                            |
| NO          | Year                   | int       | 4      | NULL          | NO          | NULL                            |
| NO          | YearHalfID             | char      | 6      | NULL          | NO          | NULL                            |
| NO          | YearHalf               | int       | 4      | NULL          | NO          | NULL                            |
| NO          | QuarterID              | char      | 6      | NULL          | NO          | NULL                            |
| NO          | Quarter                | int       | 4      | NULL          | NO          | NULL                            |
| NO          | MonthID                | char      | 6      | NULL          | NO          | NULL                            |
| NO          | Month                  | int       | 4      | NULL          | NO          | NULL                            |
| NO          | MonthName              | varchar   | 10     | NULL          | NO          | NULL                            |
| NO          | ShortMonthName         | char      | 3      | NULL          | NO          | NULL                            |
| NO          | WeekID                 | char      | 7      | NULL          | NO          | NULL                            |
| NO          | WeekofYear             | int       | 4      | NULL          | NO          | NULL                            |
| NO          | WeekofMonth            | int       | 4      | NULL          | NO          | NULL                            |
| NO          | DayOfYear              | int       | 4      | NULL          | NO          | NULL                            |
| NO          | DayOfMonth             | int       | 4      | NULL          | NO          | NULL                            |
| NO          | DayOfWeek              | int       | 4      | NULL          | NO          | NULL                            |
| NO          | DayName                | varchar   | 10     | NULL          | NO          | NULL                            |
| NO          | ShortDayName           | char      | 3      | NULL          | NO          | NULL                            |
| NO          | CurrentDayIndicator    | varchar   | 16     | NULL          | NO          | NULL                            |
| NO          | IsOnOrBeforeCurrentDay | varchar   | 3      | NULL          | NO          | NULL                            |
| NO          | HolidayIndicator       | varchar   | 15     | NULL          | NO          | NULL                            |

#### 7. dbo.DimGeography
##### Description
Dimension table for storing unique locations, with city as the most basic location level. 

##### Properties
| Date   Created         | 02/10/2024              |
|------------------------|-------------------------|
|  Number of Rows        |                    684  |
|  Data Space Used (KB)  |                    136  |
| Index Space Used (KB)  | 16                      |

##### Columns
| Primary Key | Column              | Data Type | Length | Default Value | Allow Nulls | CONSTRAINT_NAME           |
|-------------|---------------------|-----------|--------|---------------|-------------|---------------------------|
| YES         | GeographyUniqueID   | int       | 4      | NULL          | NO          | PK_DimGeography_AddressID |
| NO          | City                | nvarchar  | 30     | NULL          | NO          | NULL                      |
| NO          | StateCode           | nvarchar  | 3      | NULL          | YES         | NULL                      |
| NO          | State               | nvarchar  | 50     | NULL          | YES         | NULL                      |
| NO          | City-State          | nvarchar  | 80     | NULL          | NO          | NULL                      |
| NO          | CountryCode         | nvarchar  | 3      | NULL          | YES         | NULL                      |
| NO          | Country             | nvarchar  | 50     | NULL          | YES         | NULL                      |
| NO          | SalesTerritory      | nvarchar  | 50     | NULL          | YES         | NULL                      |
| NO          | SalesTerritoryGroup | nvarchar  | 50     | NULL          | NO          | NULL                      |
| NO          | PostalCode          | nvarchar  | 15     | NULL          | NO          | NULL                      |
| NO          | DateCreated         | date      | 3      | NULL          | NO          | NULL                      |
| NO          | DateModified        | date      | 3      | NULL          | NO          | NULL                      |

#### 8. dbo.DimCustomerStore
##### Description
Dimension table containing store descriptions of resellers whcih have transaction record/s in FactStoreSales table.

##### Properties
| Date   Created         | 02/10/2024              |
|------------------------|-------------------------|
|  Number of Rows        |                    702  |
|  Data Space Used (KB)  |                    120  |
| Index Space Used (KB)  | 16                      |

##### Columns

| Primary Key | Column                 | Data Type | Length | Default Value | Allow Nulls | CONSTRAINT_NAME                       |
|-------------|------------------------|-----------|--------|---------------|-------------|---------------------------------------|
| YES         | StoreUniqueID          | int       | 4      | NULL          | NO          | PK_DimCustomerStore_StoreID           |
| YES         | SalesTerritoryUniqueID | int       | 4      | NULL          | NO          | PK_DimSalesTerritory_SalesTerritoryID |
| YES         | SalesPersonUniqueID    | int       | 4      | NULL          | NO          | PK_DimSalesPerson_SalesPersonID       |
| NO          | StoreName              | nvarchar  | 50     | NULL          | YES         | NULL                                  |
| NO          | AnnualSales            | int       | 4      | NULL          | YES         | NULL                                  |
| NO          | AnnualRevenue          | int       | 4      | NULL          | YES         | NULL                                  |
| NO          | BankName               | nvarchar  | 50     | NULL          | YES         | NULL                                  |
| NO          | BusinessType           | nvarchar  | 5      | NULL          | YES         | NULL                                  |
| NO          | YearOpened             | int       | 4      | NULL          | YES         | NULL                                  |
| NO          | Specialty              | nvarchar  | 50     | NULL          | YES         | NULL                                  |
| NO          | SquareFeet             | int       | 4      | NULL          | YES         | NULL                                  |
| NO          | Brands                 | nvarchar  | 30     | NULL          | YES         | NULL                                  |
| NO          | Internet               | nvarchar  | 30     | NULL          | YES         | NULL                                  |
| NO          | NumberEmployees        | int       | 4      | NULL          | YES         | NULL                                  |
| NO          | DateCreated            | date      | 3      | NULL          | NO          | NULL                                  |
| NO          | DateModified           | date      | 3      | NULL          | NO          | NULL                                  |
| NO          | SquareFeetGroup        | varchar   | 15     | NULL          | YES         | NULL                                  |

#### 9. dbo.DimProduct
##### Description
Dimension table containing details of saleable items of Adventure Works.

##### Properties
| Date   Created         | 02/10/2024                  |
|------------------------|-----------------------------|
|  Number of Rows        |                    296      |
|  Data Space Used (KB)  |                       96    |
| Index Space Used (KB)  | 16                          |

##### Columns
| Primary Key | Column                | Data Type | Length | Default Value | Allow Nulls | CONSTRAINT_NAME         |
|-------------|-----------------------|-----------|--------|---------------|-------------|-------------------------|
| YES         | ProductUniqueID       | int       | 4      | NULL          | NO          | PK_DimProduct_ProductID |
| NO          | ProductCode           | nvarchar  | 25     | NULL          | NO          | NULL                    |
| NO          | ProductName           | nvarchar  | 50     | NULL          | YES         | NULL                    |
| NO          | SalelableIndicator    | nvarchar  | 15     | NULL          | NO          | NULL                    |
| NO          | Color                 | nvarchar  | 15     | NULL          | YES         | NULL                    |
| NO          | StandardCost          | float     | 8      | NULL          | NO          | NULL                    |
| NO          | ListPrice             | float     | 8      | NULL          | NO          | NULL                    |
| NO          | Size                  | nvarchar  | 5      | NULL          | YES         | NULL                    |
| NO          | SizeUnitMeasureCode   | nvarchar  | 3      | NULL          | YES         | NULL                    |
| NO          | SizeUnitMeasure       | nvarchar  | 50     | NULL          | YES         | NULL                    |
| NO          | Weight                | decimal   | 17     | NULL          | YES         | NULL                    |
| NO          | WeightUnitMeasureCode | nvarchar  | 3      | NULL          | YES         | NULL                    |
| NO          | WeightUnitMeasure     | nvarchar  | 50     | NULL          | YES         | NULL                    |
| NO          | ProductLineCode       | nvarchar  | 2      | NULL          | YES         | NULL                    |
| NO          | ProductLine           | nvarchar  | 15     | NULL          | YES         | NULL                    |
| NO          | ClassCode             | nvarchar  | 2      | NULL          | YES         | NULL                    |
| NO          | Class                 | nvarchar  | 10     | NULL          | YES         | NULL                    |
| NO          | StyleCode             | nvarchar  | 2      | NULL          | YES         | NULL                    |
| NO          | Style                 | nvarchar  | 15     | NULL          | YES         | NULL                    |
| NO          | SubCategory           | nvarchar  | 50     | NULL          | YES         | NULL                    |
| NO          | Category              | nvarchar  | 50     | NULL          | YES         | NULL                    |
| NO          | Model                 | nvarchar  | 50     | NULL          | YES         | NULL                    |
| NO          | SellStartDate         | date      | 3      | NULL          | YES         | NULL                    |
| NO          | SellEndDate           | date      | 3      | NULL          | YES         | NULL                    |
| NO          | IsActive              | int       | 4      | NULL          | YES         | NULL                    |
| NO          | DateCreated           | date      | 3      | NULL          | NO          | NULL                    |
| NO          | DateModified          | date      | 3      | NULL          | NO          | NULL                    |


#### 10. dbo.DimPromo
##### Description
Dimension table containing discount percentages, duration, and terms of promotions.

##### Properties
| Date   Created         | 02/10/2024                    |
|------------------------|-------------------------------|
|  Number of Rows        |                       17      |
|  Data Space Used (KB)  |                            8  |
| Index Space Used (KB)  | 8                             |

##### Columns
| Primary Key | Column        | Data Type | Length | Default Value | Allow Nulls | CONSTRAINT_NAME     |
|-------------|---------------|-----------|--------|---------------|-------------|---------------------|
| YES         | PromoUniqueID | int       | 4      | NULL          | NO          | PK_DimPromo_PromoID |
| NO          | Promo         | nvarchar  | 255    | NULL          | NO          | NULL                |
| NO          | DiscountPct   | float     | 8      | NULL          | NO          | NULL                |
| NO          | Type          | nvarchar  | 50     | NULL          | NO          | NULL                |
| NO          | Category      | nvarchar  | 50     | NULL          | NO          | NULL                |
| NO          | StartDate     | date      | 3      | NULL          | NO          | NULL                |
| NO          | EndDate       | date      | 3      | NULL          | NO          | NULL                |
| NO          | IsActive      | int       | 4      | NULL          | YES         | NULL                |
| NO          | MinQuantity   | int       | 4      | NULL          | NO          | NULL                |
| NO          | MaxQuantity   | int       | 4      | NULL          | YES         | NULL                |
| NO          | DateCreated   | date      | 3      | NULL          | NO          | NULL                |
| NO          | DateModified  | date      | 3      | NULL          | NO          | NULL                |


#### 11. dbo.DimCurrency
##### Description
Dimension table containing currency codes and their corresponding currency names.

##### Properties
| Date   Created         | 02/10/2024                    |
|------------------------|-------------------------------|
|  Number of Rows        |                    105        |
|  Data Space Used (KB)  |                            8  |
| Index Space Used (KB)  | 8                             |

##### Columns
| Primary Key | Column           | Data Type | Length | Default Value | Allow Nulls | CONSTRAINT_NAME                 |
|-------------|------------------|-----------|--------|---------------|-------------|---------------------------------|
| YES         | CurrencyUniqueID | int       | 4      | NULL          | NO          | PK_DimCurrency_CurrencyUniqueID |
| NO          | CurrencyCode     | nchar     | 3      | NULL          | NO          | NULL                            |
| NO          | Currency         | nvarchar  | 50     | NULL          | YES         | NULL                            |
| NO          | DateCreated      | date      | 3      | NULL          | NO          | NULL                            |
| NO          | DateModified     | date      | 3      | NULL          | NO          | NULL                            |


#### 12. dbo.DimSalesPerson
##### Description
Dimension table containing the salesperson responsible for closing sales to store resellers. This is only related to FactStoreSales and not to FactInternetSales.

##### Properties
| Date   Created         | 02/10/2024                    |
|------------------------|-------------------------------|
|  Number of Rows        |                       18      |
|  Data Space Used (KB)  |                            8  |
| Index Space Used (KB)  | 8                             |

##### Columns
| Primary Key | Column              | Data Type | Length | Default Value | Allow Nulls | CONSTRAINT_NAME                 |
|-------------|---------------------|-----------|--------|---------------|-------------|---------------------------------|
| YES         | SalesPersonUniqueID | int       | 4      | NULL          | NO          | PK_DimSalesPerson_SalesPersonID |
| NO          | FirstName           | nvarchar  | 50     | NULL          | YES         | NULL                            |
| NO          | MiddleName          | nvarchar  | 50     | NULL          | YES         | NULL                            |
| NO          | LastName            | nvarchar  | 50     | NULL          | YES         | NULL                            |
| NO          | FullName            | nvarchar  | 150    | NULL          | NO          | NULL                            |
| NO          | NameSuffix          | nvarchar  | 10     | NULL          | YES         | NULL                            |
| NO          | JobTitle            | nvarchar  | 50     | NULL          | YES         | NULL                            |
| NO          | BirthDate           | date      | 3      | NULL          | NO          | NULL                            |
| NO          | GenderCode          | nchar     | 1      | NULL          | YES         | NULL                            |
| NO          | Gender              | nvarchar  | 10     | NULL          | NO          | NULL                            |
| NO          | PhoneNumber         | nvarchar  | 25     | NULL          | NO          | NULL                            |
| NO          | EmailAddress        | nvarchar  | 50     | NULL          | YES         | NULL                            |
| NO          | SalesQuota          | float     | 8      | ((0.00))      | YES         | NULL                            |
| NO          | Bonus               | float     | 8      | ((0.00))      | NO          | NULL                            |
| NO          | CommissionPct       | float     | 8      | ((0.00))      | NO          | NULL                            |
| NO          | DateCreated         | date      | 3      | NULL          | NO          | NULL                            |
| NO          | DateModified        | date      | 3      | NULL          | NO          | NULL                            |


#### 13. dbo.DimSalesTerritory
##### Description
Dimension table containing the salesperson responsible for closing sales to store resellers. This is only related to FactStoreSales and not to FactInternetSales.

##### Properties
| Date   Created         | 02/10/2024                    |
|------------------------|-------------------------------|
|  Number of Rows        |                       11      |
|  Data Space Used (KB)  |                            8  |
| Index Space Used (KB)  | 8                             |


##### Columns

| Primary Key | Column                 | Data Type | Length | Default Value | Allow Nulls | CONSTRAINT_NAME                       |
|-------------|------------------------|-----------|--------|---------------|-------------|---------------------------------------|
| YES         | SalesTerritoryUniqueID | int       | 4      | NULL          | NO          | PK_DimSalesTerritory_SalesTerritoryID |
| NO          | SalesTerritory         | nvarchar  | 50     | NULL          | YES         | NULL                                  |
| NO          | CountryCode            | nvarchar  | 3      | NULL          | YES         | NULL                                  |
| NO          | Country                | nvarchar  | 50     | NULL          | NO          | NULL                                  |
| NO          | TerritoryGroup         | nvarchar  | 50     | NULL          | NO          | NULL                                  |
| NO          | DateCreated            | date      | 3      | NULL          | NO          | NULL                                  |
| NO          | DateModified           | date      | 3      | NULL          | NO          | NULL                                  |


#### 14. dbo.DimChannel
##### Description
Dimension table containing Adventure Works sales sources, namely internet and store resellers. 

##### Properties
| Date   Created         | 02/16/2024                    |
|------------------------|-------------------------------|
|  Number of Rows        |                            2  |
|  Data Space Used (KB)  |                            8  |
| Index Space Used (KB)  | 8                             |

##### Columns
| Primary Key | Column          | Data Type | Length | Default Value | Allow Nulls | CONSTRAINT_NAME               |
|-------------|-----------------|-----------|--------|---------------|-------------|-------------------------------|
| YES         | UniqueChannelID | int       | 4      | NULL          | NO          | PK_DimChannel_UniqueChannelID |
| NO          | ChannelCode     | nvarchar  | 5      | NULL          | NO          | NULL                          |
| NO          | Channel         | nvarchar  | 50     | NULL          | YES         | NULL                          |
| NO          | OnlineOrderFlag | int       | 4      | NULL          | YES         | NULL                          |
| NO          | DateCreated     | date      | 3      | NULL          | NO          | NULL                          |
| NO          | DateModified    | date      | 3      | NULL          | NO          | NULL                          |



### Data Model
-------------------
The illustration below shows the dimension and fact tables arranged as a star schema 

![Star Schema Model](https://github.com/blumea7/AdventureWorks-Sales-DataMart/blob/53-add-a-readmemd-file/assets/star-schema.png)

### Dashboards
-------------------

The overall dashboard format and feel refers to this design manual

![Design Manual](https://github.com/blumea7/AdventureWorks-Sales-DataMart/blob/53-add-a-readmemd-file/assets/brand-manual.png)


Four dashboards were derived from the data mart that was built.
Sales Trend 

![Design Manual](https://github.com/blumea7/AdventureWorks-Sales-DataMart/blob/53-add-a-readmemd-file/assets/sales-trend.png)


Year Over Year

![Design Manual](https://github.com/blumea7/AdventureWorks-Sales-DataMart/blob/53-add-a-readmemd-file/assets/year-over-year.png)


Customer Profile

![Design Manual](https://github.com/blumea7/AdventureWorks-Sales-DataMart/blob/53-add-a-readmemd-file/assets/customer-profile.png)


Store Reseller Profile

![Design Manual](https://github.com/blumea7/AdventureWorks-Sales-DataMart/blob/53-add-a-readmemd-file/assets/store-reseller.png)