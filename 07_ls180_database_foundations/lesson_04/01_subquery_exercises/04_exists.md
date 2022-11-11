## Conditional Subqueries: EXISTS

Write a `SELECT` query that returns a list of names of everyone who has bid in the auction. While it is possible (and perhaps easier) to do this with a `JOIN` clause, we're going to do things differently: use a subquery with the `EXISTS` clause instead. Here is the expected output:

```plaintext
      name
-----------------
 Alison Walker
 James Quinn
 Taylor Williams
 Alexis Jones
 Gwen Miller
 Alan Parker
(6 rows)
```

My answer
```sql
SELECT name FROM bidders
WHERE EXISTS (SELECT bidder_id FROM bids WHERE bidders.id = bids.bidder_id);
```

**Approach/Algorithm**
This [assignment on subqueries](https://launchschool.com/lessons/e752508c/assignments/2009d549) should be of use for this exercise. This section on [subqueries](https://www.postgresql.org/docs/current/functions-subquery.html) in the PostgreSQL documentation should be helpful as well.

**Solution**
```sql
SELECT name FROM bidders
WHERE EXISTS (SELECT 1 FROM bids WHERE bids.bidder_id = bidders.id);
```

**Discussion**

This is a bit tricky. We know we have to use the `EXISTS` clause. This clause checks whether the attached subquery returns any rows; if a row is returned, then `EXISTS` evaluates to true and the current `name` is grabbed and added to our result table. If we want to include all bidder names, then we need a subquery that will only return rows for anyone who has ever placed a bid. This is why we use `SELECT 1 FROM bids WHERE bids.bidder_id = bidders.id.`

Only bidders who have never placed a bid would cause this subquery to return 0 rows. If they haven't placed a bid, then their id won't have a matching foreign key in the `bids` table. As for the initial part of the subquery, `SELECT 1`, that is arbitrary. We only need a row to be returned to utilize the `EXISTS` clause; what's in that row doesn't usually matter.

**Further Exploration**

More often than not, we can get an equivalent result by using a `JOIN` clause, instead of a subquery. Can you figure out a `SELECT` query that uses a `JOIN` clause that returns the same output as our solution above?

My answer
```sql
SELECT DISTINCT name 
FROM bidders 
  INNER JOIN bids ON bidders.id = bids.bidder_id
ORDER BY name;
```

**Review**
- We can just return an arbitary value e.g. `SELECT 1`  when using `EXISTS` since it will include a value as long as something is returned.
