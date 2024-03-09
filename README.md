### Adventure Works Overview
-------------------
To do...

### Data Mart Setup
-------------------
To do...


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

##### Indexes

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

##### Indexes

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

##### Indexes

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

##### Indexes

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

##### Indexes

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

##### Indexes

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

##### Indexes

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

##### Indexes

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

##### Indexes

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

##### Indexes

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

##### Indexes

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

##### Indexes

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

##### Indexes

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

##### Indexes




### Data Model
-------------------
To do...


### Dashboards
-------------------



