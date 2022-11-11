## Query From a Virtual Table

For this exercise, we'll make a slight departure from how we've been using subqueries. We have so far used subqueries to filter our results using a WHERE clause. In this exercise, we will build that filtering into the table that we will query. Write an SQL query that finds the largest number of bids from an individual bidder.

For this exercise, you must use a subquery to generate a result table (or virtual table), and then query that table for the largest number of bids.

Your output should look like this:
```plaintext
  max
------
    9
(1 row)
```

My answer
```sql
SELECT max(count) 
FROM (SELECT COUNT(id) FROM bids
      GROUP BY bidder_id) AS A;
```

**Approach/Algorithm**
Here is the general form of syntax you'll want to use:

```sql
SELECT column_name FROM
  (SELECT column_name FROM a_table) AS alias_name
```

We can use a subquery within the `FROM` clause to generate a table, then use the outer `SELECT` to query data from that table.

We highly recommend that you first run the subquery by itself. That way, you will know what column names you can use in the outer SELECT statement and can ensure that the subquery will work as expected.


**Solution**
```sql
SELECT MAX(bid_counts.count) FROM
  (SELECT COUNT(bidder_id) FROM bids GROUP BY bidder_id) AS bid_counts;
```

**Discussion**

Let's go through the whole process of creating this query. First, let's create that subquery. We know that we want a table that has the number of bids for each bidder, so let's write that first.

```sql
SELECT COUNT(bidder_id) FROM bids GROUP BY bidder_id;
```

This query generates a table that has the total bids for each bidder. Take note of the column name, `count`, as that is information we'll need to use in our outer query.

We now want to find the maximum value out of all the bid counts. We can use the aggregate function `MAX` to do this in our outer query. We also must add an alias for the subquery table, which lets us use `bid_counts.count` as a column name: `bid_counts` is an alias for the generated table, and `count` is the column name we want. Putting it all together, we can write a query to search the generated table and locate the entry that has the greatest number of bids.

One final thing that is important to note: this method of using a subquery is a bit longer to write than if we had used no subqueries at all. We can get the same result without a subquery with this SQL statement:

```sql
SELECT COUNT(bidder_id) AS max_bid FROM bids
  GROUP BY bidder_id
  ORDER BY max_bid DESC
  LIMIT 1;
```

Having a shorter query doesn't necessarily make it better though. Our `SELECT` query that uses a subquery is faster than the one that uses `ORDER BY` and `LIMIT`. We'll learn later how to check the efficiency of SQL statements.

**Review**
- We need to enclose the entire virtual table with brackets and give it an alias. Else, sql will complain of an ERROR: subquery in FROM from have an alias.
