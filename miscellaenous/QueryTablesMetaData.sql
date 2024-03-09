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

SELECT * FROM sys.tables

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




SELECT 
	st.[name] AS 'Table'
	, st.create_date AS 'Date Created'
 FROM sys.tables st



 SELECT
  t.object_id,
  OBJECT_NAME(t.object_id) ObjectName,
  sum(u.total_pages) * 8 Total_Reserved_kb,
  sum(u.used_pages) * 8 Used_Space_kb,
  u.type_desc,
  max(p.rows) RowsCount
FROM
  sys.allocation_units 
  JOIN sys.partitions p on u.container_id = p.hobt_id

  JOIN sys.tables t on p.object_id = t.object_id
WHERE 
	t.object_id = 1429580131
GROUP BY
  t.object_id,
  OBJECT_NAME(t.object_id),
  u.type_desc
ORDER BY
  Used_Space_kb desc,
  ObjectName;

/*
Computation Notes: 

An allocation unit is a fundamental component of the storage architecture, representing a 
group of pages where data is stored. SQL Server organizes database files into pages, 
which are the basic units of data storage, each being 8 KB in size.

https://learn.microsoft.com/en-us/sql/relational-databases/system-catalog-views/sys-allocation-units-transact-sql?view=sql-server-ver16
*/
