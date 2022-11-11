## Hypothetically

The company president is looking to increase revenue. As a prelude to his decision making, he asks for two numbers: the amount of expected income from "big ticket" services (those services that cost more than $100) and the maximum income the company could achieve if it managed to convince all of its customers to select all of the company's big ticket items.

For simplicity, your solution should involve two separate SQL queries: one that reports the current expected income level, and one that reports the hypothetical maximum. The outputs should look like this:

```plaintext
 sum
--------
 500.00
(1 row)
```

```plaintext
   sum
---------
 10493.00
(1 row)
```

My answer
```sql
-- Current big ticket revenue based on subscriptions
SELECT SUM(price)
  FROM customers_services
    INNER JOIN services 
            ON service_id = services.id
  WHERE price > 100;
```

```sql
-- Theoretical maximum, assuming all customers subscribes to all services exceeding $100
SELECT SUM(price)
  FROM customers
    CROSS JOIN services
  WHERE price > 100;
```

**Solution**

```sql
SELECT SUM(price)
FROM services
INNER JOIN customers_services
        ON services.id = service_id
WHERE price > 100;

SELECT SUM(price)
FROM customers
CROSS JOIN services
WHERE price > 100;
```

**Discussion**

The first part of the solution is straightforward; we perform an `INNER JOIN` between the `services` table and the join table to get the services that are currently being used by our customers, then limit that result to the big ticket items.

The second part of the solution looks simpler, but it's a bit trickier. Here we use the very rarely required `CROSS JOIN`. `CROSS JOIN` produces a result that has one row for every possible combination of rows from the original tables. Thus, if one table has 6 rows and the other 8, then the result has 48 rows. Rather than print all that data, we first limit the results for combinations that are produced for big ticket items, then we sum all of the prices to determine the hypothetical input.

Did you have trouble following that last paragraph? See what happens when you run:

```sql
SELECT *
FROM customers
CROSS JOIN services;
```

then:

```sql
SELECT *
FROM customers
CROSS JOIN services
WHERE price > 100;
```

and then finally, the solution code:

```sql
SELECT SUM(price)
FROM customers
CROSS JOIN services
WHERE price > 100;
```

**Further Exploration**

This exercise is really contrived: it just shows how hard it is to come up with a possible use case for CROSS JOIN. CROSS JOIN is generally best suited to generating test data rather than production queries.

Can you think of any other situations where a CROSS JOIN might be useful?

My answer:
`CROSS JOIN` is useful to generate all possible combinations from multiple tables
in scenario analysis.
