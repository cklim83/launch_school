## EXPLAIN

For this exercise, let's explore the `EXPLAIN` PostgreSQL statement. It's a very useful SQL statement that lets us analyze the efficiency of our SQL statements. More specifically, use `EXPLAIN` to check the efficiency of the query statement we used in the exercise on `EXISTS`:

```sql
SELECT name FROM bidders
WHERE EXISTS (SELECT 1 FROM bids WHERE bids.bidder_id = bidders.id);
```

First use just `EXPLAIN`, then include the `ANALYZE` option as well. For your answer, list any SQL statements you used, along with the output you get back, and your thoughts on what is happening in both cases.


My answer:
```psql
EXPLAIN SELECT name FROM bidders
WHERE EXISTS (SELECT 1 FROM bids WHERE bids.bidder_id = bidders.id);
```

```plaintext
                                QUERY PLAN                                
--------------------------------------------------------------------------
 Hash Join  (cost=33.38..66.47 rows=635 width=32)
   Hash Cond: (bidders.id = bids.bidder_id)
   ->  Seq Scan on bidders  (cost=0.00..22.70 rows=1270 width=36)
   ->  Hash  (cost=30.88..30.88 rows=200 width=4)
         ->  HashAggregate  (cost=28.88..30.88 rows=200 width=4)
               Group Key: bids.bidder_id
               ->  Seq Scan on bids  (cost=0.00..25.10 rows=1510 width=4)
(7 rows)
```

`EXPLAIN` lists down the actions to be taken in the query plan in a node-tree format. Each node represents an action and contains estimated values for start-up and total cost, number of return rows and the memory size in bytes involved. Nested nodes are pre-requisited actions that have to be taken before the outer nodes can be executed. From this example, the estimated total cost is `66.47`. 

```psql
EXPLAIN ANALYZE SELECT name FROM bidders
WHERE EXISTS (SELECT 1 FROM bids WHERE bids.bidder_id = bidders.id);
```

```plaintext
                                                     QUERY PLAN                                                      
---------------------------------------------------------------------------------------------------------------------
 Hash Join  (cost=33.38..66.47 rows=635 width=32) (actual time=0.395..0.399 rows=6 loops=1)
   Hash Cond: (bidders.id = bids.bidder_id)
   ->  Seq Scan on bidders  (cost=0.00..22.70 rows=1270 width=36) (actual time=0.049..0.051 rows=7 loops=1)
   ->  Hash  (cost=30.88..30.88 rows=200 width=4) (actual time=0.321..0.321 rows=6 loops=1)
         Buckets: 1024  Batches: 1  Memory Usage: 9kB
         ->  HashAggregate  (cost=28.88..30.88 rows=200 width=4) (actual time=0.302..0.304 rows=6 loops=1)
               Group Key: bids.bidder_id
               Batches: 1  Memory Usage: 40kB
               ->  Seq Scan on bids  (cost=0.00..25.10 rows=1510 width=4) (actual time=0.018..0.022 rows=26 loops=1)
 Planning Time: 2.743 ms
 Execution Time: 1.359 ms
(11 rows)
```

Adding the `ANALYZE` option results in the query being run to get the actual query time taken. On top of the query plan breakdown, the actual time taken is also broken
down on a node level and then aggregated and displayed at the bottom.

**Approach/Algorithm**
To solve this exercise, you can refer to [this assignment](https://launchschool.com/lessons/e752508c/assignments/87715c5f) on `EXPLAIN`, and also the [documentation](https://www.postgresql.org/docs/9.5/sql-explain.html) for the `EXPLAIN` statement. Note, that there is no `EXPLAIN` statement in the SQL standard, but it is implemented in other RDBMSs.

Also, keep in mind that when using `ANALYZE`, the sql statement gets executed. When not using `ANALYZE`, the SQL statement isn't executed. Be careful when using `EXPLAIN` on a SQL statement that alters data or database schema.


**Solution**
```psql
EXPLAIN SELECT name FROM bidders
WHERE EXISTS (SELECT 1 FROM bids WHERE bids.bidder_id = bidders.id);
                                QUERY PLAN
--------------------------------------------------------------------------
 Hash Join  (cost=33.38..62.84 rows=635 width=32)
   Hash Cond: (bidders.id = bids.bidder_id)
   ->  Seq Scan on bidders  (cost=0.00..22.70 rows=1270 width=36)
   ->  Hash  (cost=30.88..30.88 rows=200 width=4)
         ->  HashAggregate  (cost=28.88..30.88 rows=200 width=4)
               Group Key: bids.bidder_id
               ->  Seq Scan on bids  (cost=0.00..25.10 rows=1510 width=4)
(7 rows)
```

```psql
EXPLAIN ANALYZE SELECT name FROM bidders
WHERE EXISTS (SELECT 1 FROM bids WHERE bids.bidder_id = bidders.id);
                                                    QUERY PLAN
-----------------------------------------------------------------------------------------------------------------
 Hash Join  (cost=33.38..62.84 rows=635 width=32) (actual time=0.083..0.088 rows=6 loops=1)
   Hash Cond: (bidders.id = bids.bidder_id)
   ->  Seq Scan on bidders  (cost=0.00..22.70 rows=1270 width=36) (actual time=0.018..0.021 rows=7 loops=1)
   ->  Hash  (cost=30.88..30.88 rows=200 width=4) (actual time=0.040..0.040 rows=6 loops=1)
         Buckets: 1024  Batches: 1  Memory Usage: 9kB
         ->  HashAggregate  (cost=28.88..30.88 rows=200 width=4) (actual time=0.031..0.032 rows=6 loops=1)
               Group Key: bids.bidder_id
               ->  Seq Scan on bids  (cost=0.00..25.10 rows=1510 width=4) (actual time=0.009..0.014 rows=26 loops=1)
 Planning time: 0.222 ms
 Execution time: 0.161 ms
(10 rows)
```

**Discussion**

`EXPLAIN` is used to show statistics about the query plan for a SQL statement. Here is the general form for `EXPLAINs` syntax:

`EXPLAIN sql_expression;`

Let's go through the output of each `EXPLAIN` statement and see what is going on.

The first `EXPLAIN` statement contains a fair amount of information. Each row represents an operation taken. The following items are listed in each row of information.
- The name of the node used to perform the SQL statement. A node represents some operation taken to run the SQL statement. An example would be the name in the first row of our query plan, `Hash Join`
- The estimated startup cost and estimated total cost. These can be seen here: `Hash Join (cost=33.38..62.84 rows=635 width=32)` The first number after `cost` is the estimated startup cost, and the second is the estimated total cost.
- The estimated number of rows to be shown when the SQL statement we are explaining is run. This is the number right after `rows=` above.
- The width is the estimated amount in bytes taken up by rows for the SQL statement we are explaining.

Did you notice how some nodes are nested further in than others? A nested node represents one that is a child of the one above it. That means that nested nodes were operations necessary to allow the parent node(operation) to run its course. One other important fact is that all of these numbers represent estimates. The SQL statement we're explaining isn't actually run, so all information listed above is an approximation of what will actually happen. Another thing to consider are the units used for describing the estimated startup and total costs. These units are arbitrary and are used by PostgreSQL internally to create the query plan. Their main purpose is to give some measure of the efficiency of using certain nodes, taking certain operations to execute a SQL statement. If the cost is greater than some other group of operations then it will probably be dropped for an alternative approach.

Next, let's take a look at the information that was added when we used the `ANALYZE` option. The information here is mostly the same: cost, rows, and width are still there. But there is one other bit of information that has been added to each node: the `actual_time` required for the startup and execution of that node. At the end of our query plan, the planning and execution time have also been added: these represent the total time required to set up the SQL statement along with the total time it took to execute that SQL statement.

Since the SQL statement is actually run when we use `EXPLAIN ANALYZE`, the results we get from our query plan are the actual results, and not estimates; that includes the costs and the measures of time elapsed per operation.

Now, one might wonder why bother with the `EXPLAIN` statement at all? Well, this statement can actually be really useful. We can compare the costs of running different SQL statements, which can help us with optimizing our DB calls. There may be some SQL statements that we don't actually want to run, but just want some estimated data on: in that case, use `EXPLAIN`. But, if we're ok with running the statement, and we need some extra data(maybe to compare the elapsed execution and setup time between two equivalent SQL statements), then we should use `EXPLAIN ANALYZE`.

We've been talking about runtimes and optimizing for efficiency between SQL statements. And now that you're a bit better equipped to understand how `EXPLAIN` works, you can try using it. The next exercise will focus on doing just that.
