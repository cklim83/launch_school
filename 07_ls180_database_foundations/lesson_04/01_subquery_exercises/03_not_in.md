## Conditional Subqueries: NOT IN

Write a SQL query that shows all items that have not had bids put on them. Use the logical operator `NOT IN` for this exercise, as well as a subquery.

Here is the expected output:
```plaintext
 Not Bid On
------------
 Television
(1 row)
```

My answer
```sql
SELECT name AS "Not Bid On"
FROM items
WHERE items.id NOT IN (SELECT DISTINCT item_id FROM bids);
```

**Approach/Algorithm**
This [assignment on subqueries](https://launchschool.com/lessons/e752508c/assignments/2009d549) should be of use for this exercise. This section on [subqueries](https://www.postgresql.org/docs/current/functions-subquery.html) in the PostgreSQL documentation should be helpful as well.

The output for this exercise should also have an alias in place for the column we need to select.

**Solution**
```sql
SELECT name AS "Not Bid On" FROM items
WHERE items.id NOT IN (SELECT item_id FROM bids);
```

**Discussion**

This exercise asks us for all items that have not been bid on. Which means, all items that are not referenced by our join table, bids. This results in a query that is nearly identical to the previous problem. The only difference here is that we need to use a `NOT IN` clause, instead of an `IN` clause. Notice that we are also using a different alias for the column `name`, so make sure to update that accordingly.
