## Scalar Subqueries

For this exercise, use a scalar subquery to determine the number of bids on each item. The entire query should return a table that has the `name` of each item along with the number of bids on an item.

Here is the expected output:
```plaintext
    name      | count
--------------+-------
Video Game    |     4
Outdoor Grill |     1
Painting      |     8
Tent          |     4
Vase          |     9
Television    |     0
(6 rows)
```

My answer
```sql
SELECT name, (SELECT count(item_id) FROM bids WHERE item_id = items.id)
FROM items;
```

**Approach/Algorithm**
Refer to the PostgreSQL documentation on [scalar subqueries](https://www.postgresql.org/docs/9.5/sql-expressions.html#SQL-SYNTAX-SCALAR-SUBQUERIES) to solve this exercise. Keep a few key facts in mind:
- You may reference columns within your subquery from the outer `SELECT` query. Those values will act as constants for the current subquery evaluation.
- A scalar subquery must only return one column and one row.


**Solution**
```sql
SELECT name,
       (SELECT COUNT(item_id) FROM bids WHERE item_id = items.id)
FROM items;
```

**Discussion**

So far, we've seen quite a few ways to use subqueries. They can be used in the `WHERE` clause, within the `FROM` clause, and now we see they may be used within the expression list that comes right after `SELECT`. A good way to understand this is to break it up. First, let's analyze the subquery.

```sql
SELECT COUNT(item_id) FROM bids WHERE item_id = items.id;
```

This counts the number of bids on a particular item where the `item_id` is equal to the current `items.id`. For each item in the outer `SELECT`, `items.id` will equal the current `id` value from that outer `SELECT`. This kind of subquery lets us conveniently query another table and then associate that table's data with another table based on a foreign key.

Once again, it can be said that using a subquery is more efficient than the alternative (using `JOIN` in this case). We'll take a closer look at checking SQL statement execution efficiency later on in this exercise set.

**Further Exploration**

If we wanted to get an equivalent result, without using a subquery, then we would have to use a `LEFT OUTER JOIN`. Can you come up with the equivalent query that uses `LEFT OUTER JOIN`?

My answer
```sql
SELECT name, count(item_id)
FROM items
  LEFT OUTER JOIN bids ON items.id = bids.item_id
GROUP BY name;
```

