## SELECT part_number

We want to grab all parts that have a `part_number` that starts with 3. Write a `SELECT` query to get this information. This table may show all attributes of the parts table.


My answer:
```sql
SELECT *
  FROM parts
  WHERE part_number::text LIKE '3%';
```


**Approach/Algorithm**

We'll need two important tools to solve this exercise: one is [type conversion](https://www.postgresql.org/docs/current/sql-expressions.html#SQL-SYNTAX-TYPE-CASTS), and the other is the `LIKE` [operator](https://launchschool.com/books/sql/read/select_queries#operators).

**Solution**
```sql
SELECT * FROM parts WHERE part_number::text LIKE '3%';
 id | part_number | device_id
----+-------------+-----------
  4 |          31 |         2
  5 |          33 |         2
  6 |          35 |         2
  7 |          37 |         2
  8 |          39 |         2
(5 rows)
```

**Discussion**

To solve this exercise, we need some way to check if the first digit of a `part_number` is 3. Recall, that in an earlier problem, it was stated that part numbers may be between 1 and 10000. Given that information, there isn't really an easy way to go about this using mathematics.

What we can do is temporarily convert the `part_number` to type text and then use the `LIKE` operator to check if a `part_number` starts with 3. To accomplish this, first we use type conversion to change our `part_numbers` to type text. Then, we use the `LIKE` operator to check a text version of our part number for an initial digit of 3. This gives us: `WHERE part_number::text LIKE '3%'`. `%` is a wildcard character, it will match any character. So, `3%` will look for a value that starts with 3, followed by any character(s). This works well for our purposes.

You may be thinking that looking for 3 followed by any character is too loose of a condition. If `part_number` was originally of type text then this would certainly be true. Technically, `%` could match non-integer characters as well. But, since `part_number` is actually of type integer, there is no way that it could have a non-digit character. This is a temporary conversion for use in this query. The above query statement works just fine for our purposes.
