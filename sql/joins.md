# `JOINS JOINS JOINS`
5 standard joins exist

INNER, LEFT OUTER, RIGHT OUTER, FULL OUTER, CROSS

1 special join

JOIN 'aka self join'

## `CROSS JOIN`

Returns the 'Cartesian' product of two tables, ie it combines each row from the first table with each row of the second table. 

```sql
SELECT * FROM EMPLOYEE CROSS JOIN DEPARTMENT ;
```

Produces:

![http://cl.ly/image/173k3u0l3Q2S/Image%202014-12-16%20at%2011.13.40%20AM.png](http://cl.ly/image/173k3u0l3Q2S/Image%202014-12-16%20at%2011.13.40%20AM.png)

### `NATURAL JOIN`

A subset of a `CROSS JOIN`.

```sql
SELECT * FROM EMPLOYEE NATURAL JOIN DEPARTMENT ;
```

![http://cl.ly/image/1G1W2B2b201P/Image%202014-12-16%20at%2011.16.57%20AM.png](http://cl.ly/image/1G1W2B2b201P/Image%202014-12-16%20at%2011.16.57%20AM.png)

## `INNER JOIN`

Joins two tables based on one piece of common information, assumes that a record in one table has a matched record in the other table. 

```sql
SELECT * FROM employee INNER JOIN department ON employee.DepartmentID = department.DepartmentID;
```

![http://cl.ly/image/0p3I001i2c0F/Image%202014-12-16%20at%2011.19.34%20AM.png](http://cl.ly/image/0p3I001i2c0F/Image%202014-12-16%20at%2011.19.34%20AM.png)

## `OUTER JOIN`

Does not require a record to match in both tables.  Encompasses `LEFT OUTER JOIN`, `RIGHT OUTER JOIN`, `FULL OUTER JOIN`.

### `LEFT OUTER JOIN` given tableA and tableB.

Returns all records from tableA regardless of match in tableB.

```sql
SELECT *
FROM employee LEFT OUTER JOIN department
ON employee.DepartmentID = department.DepartmentID;
```

![http://cl.ly/image/1w220G05052f/Image%202014-12-16%20at%2011.26.01%20AM.png](http://cl.ly/image/1w220G05052f/Image%202014-12-16%20at%2011.26.01%20AM.png)

### `RIGHT OUTER JOIN`

Returns all the records from tableB regardless of match in tableA.

```sql
SELECT *
FROM employee RIGHT OUTER JOIN department
ON employee.DepartmentID = department.DepartmentID;
```

### `FULL OUTER JOIN`

Returns all the records from each table regardless of match in other table and insert null values when necessary.  Not implemented by all databases.

```sql
SELECT *
FROM employee FULL OUTER JOIN department
ON employee.DepartmentID = department.DepartmentID;
```

### `SELF JOIN`

A 'simulated join' based on an inner join, consider select 'xyz' from tableA and wanting to know what other records in tableA match.

![http://cl.ly/image/2k3R2u1A1j3u/Image%202014-12-16%20at%2011.34.01%20AM.png](http://cl.ly/image/2k3R2u1A1j3u/Image%202014-12-16%20at%2011.34.01%20AM.png)

```sql
SELECT F.EmployeeID, F.LastName, S.EmployeeID, S.LastName, F.Country
FROM Employee F INNER JOIN Employee S ON F.Country = S.Country
WHERE F.EmployeeID < S.EmployeeID
ORDER BY F.EmployeeID, S.EmployeeID;
```

Will match on country given `ON F.Country = S.Country`

![http://cl.ly/image/47310f1G3Z3E/Image%202014-12-16%20at%2011.34.47%20AM.png](http://cl.ly/image/47310f1G3Z3E/Image%202014-12-16%20at%2011.34.47%20AM.png)