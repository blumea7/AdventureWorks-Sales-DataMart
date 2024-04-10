USE MAU_AdventureWorks2022_DW
GO


-- Shows there are 14 tables in the dbo schema of MAU_AdventureWorks2022_DW database
SELECT 
	TABLE_NAME AS table_names
	, ROW_NUMBER() OVER (ORDER BY TABLE_NAME) table_count
FROM INFORMATION_SCHEMA.TABLES
WHERE 
	TABLE_CATALOG = 'MAU_AdventureWorks2022_DW'
	AND TABLE_SCHEMA = 'dbo'

-- End of showing count of tables

/*
Shows the ff. column metadata:
	a) is primary key
	a) column name,
	b) data type,
	c) max column value size/length,
	d) default value,
	e) is nullable, and
	f) source table
*/

SELECT 
	CASE WHEN
		iskcu.COLUMN_NAME IS NULL THEN 'NO'
		ELSE 'YES'
	END AS 'Primary Key'
	, isc.COLUMN_NAME AS 'Column'
	, isc.DATA_TYPE AS 'Data Type'
	, CASE WHEN isc.CHARACTER_MAXIMUM_LENGTH IS NULL THEN st.max_length
		   ELSE isc.CHARACTER_MAXIMUM_LENGTH
	  END AS 'Length'
	, isc.COLUMN_DEFAULT AS 'Default Value'
	, isc.IS_NULLABLE AS 'Allow Nulls'
	, isc.TABLE_NAME AS 'Source Table'
	, iskcu.*
FROM INFORMATION_SCHEMA.COLUMNS isc
	 LEFT JOIN sys.types st ON isc.DATA_TYPE = st.[name]
	 LEFT JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE iskcu ON iskcu.COLUMN_NAME = isc.COLUMN_NAME 
WHERE 
	isc.TABLE_CATALOG = 'MAU_AdventureWorks2022_DW'
	AND isc.TABLE_SCHEMA = 'dbo'


-- End of Showing Column Metadata 

/*
Notes:

As a common ground, both INFORMATION_SCHEMA and sys provide metadata for
database objects

1. INFORMATION_SCHEMA schema
	SQL Standard:  
	
	This is universal SQL schema, so you may have access to this even in
	MySQL, PostgreSQL, among others

	Scope: 

	Provides metadata for constraints(primary, check, referrential domain)
	, columns, tables, views and routines (procedures and functions)

	Limitations:

	Detailed provided is not as detailed as sys schema. 
	No detail regarding indexes, data space used, number of rows, etc.


2. sys schema

	Specific for SQL server:

	Unlike INFORMATION_SCHEMA, sys schema is only available in SQL server. 

	Scope:

	Provides a comprehensive view of the internal and administrative metadata of the server
	such as:
		a)physical storage data
		b)index information
		c)query execution plans
*/


-- Shows table metadata such as table name, date of creation, row count, and space used
SELECT 
	st.[name] AS 'Table'
	, st.create_date AS 'Date Created'
	, MAX(sp.[rows]) AS 'Number of Rows'
	, SUM(sau.data_pages) * 8 AS 'Data Space Used (KB)'
	, (SUM(sau.used_pages) - SUM(sau.data_pages)) * 8 AS 'Index Space Used (KB)'
FROM sys.tables st
LEFT JOIN sys.partitions sp ON sp.object_id = st.object_id -- id of table which the partition belongs
LEFT JOIN sys.allocation_units sau ON sau.container_id = sp.hobt_id -- Heap or B-Tree ID. Unique identifier for the internal data structure used to store the partition's data
GROUP BY 
	st.[name]
	, st.create_date
ORDER BY 'Data Space Used (KB)' DESC


/*
Data Space Computation Notes: 

1. partitions
Partitions are subsets of a table or index that are stored separately

2. allocation_units

An allocation unit is a fundamental component of the storage architecture, representing a 
group of pages where data is stored. SQL Server organizes database files into pages, 
which are the basic units of data storage, each being 8 KB in size.
*/
