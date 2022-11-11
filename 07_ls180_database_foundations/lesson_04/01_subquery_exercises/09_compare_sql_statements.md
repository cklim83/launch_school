## Comparing SQL Statements

In this exercise, we'll use `EXPLAIN ANALYZE` to compare the efficiency of two SQL statements. These two statements are actually from the "Query From a Virtual Table" exercise in this set. In that exercise, we stated that our subquery-based solution:

```sql
SELECT MAX(bid_counts.count) FROM
  (SELECT COUNT(bidder_id) FROM bids GROUP BY bidder_id) AS bid_counts;
```

was actually faster than the simpler equivalent without subqueries:

```sql
SELECT COUNT(bidder_id) AS max_bid FROM bids
  GROUP BY bidder_id
  ORDER BY max_bid DESC
  LIMIT 1;
```

In this exercise, we will demonstrate this fact.

Run `EXPLAIN ANALYZE` on the two statements above. Compare the planning time, execution time, and the total time required to run these two statements. Also compare the total "costs". Which statement is more efficient and why?


My answer
```psql
auction=# EXPLAIN ANALYZE SELECT MAX(bid_counts.count) FROM
auction-#   (SELECT COUNT(bidder_id) FROM bids GROUP BY bidder_id) AS bid_counts;
                                                  QUERY PLAN                                                   
---------------------------------------------------------------------------------------------------------------
 Aggregate  (cost=37.15..37.16 rows=1 width=8) (actual time=0.299..0.299 rows=1 loops=1)
   ->  HashAggregate  (cost=32.65..34.65 rows=200 width=12) (actual time=0.292..0.294 rows=6 loops=1)
         Group Key: bids.bidder_id
         Batches: 1  Memory Usage: 40kB
         ->  Seq Scan on bids  (cost=0.00..25.10 rows=1510 width=4) (actual time=0.042..0.045 rows=26 loops=1)
 Planning Time: 0.304 ms
 Execution Time: 0.746 ms
(7 rows)
```

```psql
auction=# EXPLAIN ANALYZE SELECT COUNT(bidder_id) AS max_bid FROM bids
auction-#   GROUP BY bidder_id
auction-#   ORDER BY max_bid DESC
auction-#   LIMIT 1;
                                                     QUERY PLAN                                                      
---------------------------------------------------------------------------------------------------------------------
 Limit  (cost=35.65..35.65 rows=1 width=12) (actual time=0.471..0.472 rows=1 loops=1)
   ->  Sort  (cost=35.65..36.15 rows=200 width=12) (actual time=0.469..0.470 rows=1 loops=1)
         Sort Key: (count(bidder_id)) DESC
         Sort Method: top-N heapsort  Memory: 25kB
         ->  HashAggregate  (cost=32.65..34.65 rows=200 width=12) (actual time=0.046..0.049 rows=6 loops=1)
               Group Key: bidder_id
               Batches: 1  Memory Usage: 40kB
               ->  Seq Scan on bids  (cost=0.00..25.10 rows=1510 width=4) (actual time=0.019..0.023 rows=26 loops=1)
 Planning Time: 0.187 ms
 Execution Time: 0.599 ms
(10 rows)
```

|Query Type | Estimated Total Cost | Total Planning Time | Total Execution Time | Total Query Time |
| --- | --- | --- | --- | --- |
| Subquery | 37.16 | 0.304ms | 0.746ms | 1.05ms |
| GROUP BY, ORDER BY, LIMIT | 35.65 | 0.187ms | 0.599ms | 0.786ms |

Based on the data above, the query using `GROUP BY AND ORDER BY AND LIMIT` is expected to be marginally more efficient based on the estimated cost by the planner. However, when executed, it turns out to be slightly faster than then subquery version in for planning and execution time.

**Approach/Algorithm**
These assignments and PostgreSQL documents should prove useful for this exercise:
- [Assignment on EXPLAIN](https://launchschool.com/lessons/e752508c/assignments/87715c5f)
- [Documentation on SELECT](https://www.postgresql.org/docs/current/sql-select.html)
- [Documentation about using EXPLAIN](https://www.postgresql.org/docs/9.6/using-explain.html)


**Solution**
```psql
-- Subquery
                                          QUERY PLAN
-----------------------------------------------------------------------------------------------------------------
Aggregate  (cost=37.15..37.16 rows=1 width=8) (actual time=0.038..0.038 rows=1 loops=1)
  ->  HashAggregate  (cost=32.65..34.65 rows=200 width=4) (actual time=0.033..0.035 rows=6 loops=1)
        Group Key: bids.bidder_id
        ->  Seq Scan on bids  (cost=0.00..25.10 rows=1510 width=4) (actual time=0.006..0.012 rows=26 loops=1)
Planning time: 0.096 ms
Execution time: 0.164 ms
(6 rows)
```

```psql
-- ORDER BY and LIMIT

                                        QUERY PLAN
-----------------------------------------------------------------------------------------------------------------
Limit  (cost=35.65..35.65 rows=1 width=4) (actual time=0.541..0.541 rows=1 loops=1)
  ->  Sort  (cost=35.65..36.15 rows=200 width=4) (actual time=0.541..0.541 rows=1 loops=1)
        Sort Key: (count(bidder_id)) DESC
        Sort Method: top-N heapsort  Memory: 25kB
        ->  HashAggregate  (cost=32.65..34.65 rows=200 width=4) (actual time=0.017..0.018 rows=6 loops=1)
              Group Key: bidder_id
              ->  Seq Scan on bids  (cost=0.00..25.10 rows=1510 width=4) (actual time=0.003..0.004 rows=26 loops=1)
Planning time: 1.621 ms
Execution time: 1.486 ms
(9 rows)
```

**Discussion**
| Query Type | Planning Time | Execution Time | Total Costs |
| --- | --- | ---- | --- |
| Subquery | 0.096 ms | 0.164 ms | 37.16 |
| ORDER BY and LIMIT | 1.621 ms | 1.486 ms | 35.65 |

Looking at the data above, the planning and execution times for using a subquery are certainly better than that of the alternative. In this case it is preferable to use a subquery versus a more direct query that uses a sort and `LIMIT`. Interestingly enough, the costs do not match up with the planning and execution times. The total costs for running our subquery are a bit more than using `ORDER BY` and `LIMIT`.

If we compare the rows of our two query plans, we'll see that both plans have some things in common. They both do a sequential scan on `bids` and they both use a HashAggregate, which creates a temporary hash table for referencing rows being scanned.

The deviation occurs when comparing the top level nodes (operations) of these two query plans. Our subquery-based SQL statement uses the subquery results and runs the aggregate function `MAX` on them. Our `SELECT` with `ORDER BY` and `LIMIT` has to first sort all the rows, and then stop sorting once `n` number of rows are found, where `n` is the number specified in the limit clause `LIMIT`.

The take away from all this is that based on the results we can see that using a subquery is faster. But, using `ORDER BY` and `LIMIT` is a bit less costly on system resources. Regarding the time discrepancies, it can be attributed to a few things. `HashAggregate` and `Sort` are two costly operations and stopping a sort is also a bit expensive (`LIMIT` will stop a sort once the first `n` rows have been identified). These two operations combined are likely more time consuming than using `HashAggregate` and then `Aggregate` to combine the results and find a maximum.

There's certainly many other scenarios to take into account here. How would this scale at larger table sizes? Would using a subquery still be faster even with a very large table? One last thing that is important to mention is the cost differences between the "Limit" node and its child node, "Sort". Notice that the costs for "Limit" are lower than "Sort". "Sort" shows the costs for when the entire sort operation is completed and all rows are returned; "Limit" shows the costs of performing the "Sort" operation and only returning `n` rows. Note, that depending on your machine, your times of execution may differ slightly from what we list above.

**Further Exploration**

We mentioned earlier that using a scalar subquery was faster than using an equivalent JOIN clause. Determining that JOIN statement was part of the "Further Exploration" for that exercise. For this "Further Exploration", compare the times and costs of those two statements. The SQL statement that uses a scalar subquery is listed below.

Scalar Subquery:
```sql
SELECT name,
(SELECT COUNT(item_id) FROM bids WHERE item_id = items.id)
FROM items;
```

My answer
```psql
auction=# EXPLAIN ANALYZE SELECT name,
auction-# (SELECT COUNT(item_id) FROM bids WHERE item_id = items.id)
auction-# FROM items;
                                                 QUERY PLAN                                                  
-------------------------------------------------------------------------------------------------------------
 Seq Scan on items  (cost=0.00..25455.20 rows=880 width=40) (actual time=0.065..0.093 rows=6 loops=1)
   SubPlan 1
     ->  Aggregate  (cost=28.89..28.91 rows=1 width=8) (actual time=0.008..0.009 rows=1 loops=6)
           ->  Seq Scan on bids  (cost=0.00..28.88 rows=8 width=4) (actual time=0.005..0.006 rows=4 loops=6)
                 Filter: (item_id = items.id)
                 Rows Removed by Filter: 22
 Planning Time: 0.188 ms
 Execution Time: 0.183 ms
(8 rows)
```

```psql
auction=# EXPLAIN ANALYZE SELECT name, count(item_id)
auction-# FROM items
auction-#   LEFT OUTER JOIN bids ON items.id = bids.item_id
auction-# GROUP BY name;
                                                     QUERY PLAN                                                      
---------------------------------------------------------------------------------------------------------------------
 HashAggregate  (cost=66.44..68.44 rows=200 width=40) (actual time=0.193..0.200 rows=6 loops=1)
   Group Key: items.name
   Batches: 1  Memory Usage: 40kB
   ->  Hash Right Join  (cost=29.80..58.89 rows=1510 width=36) (actual time=0.127..0.155 rows=27 loops=1)
         Hash Cond: (bids.item_id = items.id)
         ->  Seq Scan on bids  (cost=0.00..25.10 rows=1510 width=4) (actual time=0.006..0.011 rows=26 loops=1)
         ->  Hash  (cost=18.80..18.80 rows=880 width=36) (actual time=0.068..0.069 rows=6 loops=1)
               Buckets: 1024  Batches: 1  Memory Usage: 9kB
               ->  Seq Scan on items  (cost=0.00..18.80 rows=880 width=36) (actual time=0.031..0.034 rows=6 loops=1)
 Planning Time: 0.396 ms
 Execution Time: 0.367 ms
(11 rows)
```

| Query Type | Total Cost | Planning Time | Execution Time | Total Time |
| --- | --- | --- | --- | --- |
| Scalar | 25455.20 | 0.188 ms | 0.183 ms | 0.371 ms |
| JOIN | 68.44 | 0.396 ms | 0.367 ms | 0.763 ms |

Scalar runs must faster but is much more resource intensive then JOIN statement. The resource drain is probably due to the aggregate
operation being runs 6 times (loops=6), each time for each item.

**Review**
- It was observed the results varies significantly depending on the version of PostgreSQL used. So we cannot conclusively say one query type is more efficient than the other
- Others also observed that the second query almost usually run faster than the first, potentially due to caching and reuse of some scans. So the order of comparing
  statements may also have impact on the results. Running the same query with `EXPLAIN ANALYZE` repeatedly is also observed to improve the query times.

