## Get Customers With Services

Write a query to retrieve the `customer` data for every customer who currently subscribes to at least one service.

My answer:
```sql
SELECT c.*
  FROM customers AS c
  INNER JOIN customers_services AS cs ON c.id = cs.customer_id
  GROUP BY c.id
  ORDER BY c.id;
```

**Solution**
```sql
SELECT DISTINCT customers.* 
  FROM customers
    INNER JOIN customers_services ON customer_id = customers.id;
```

**Discussion**

For this exercise, we need to retrieve every `customers` row that has at least one service. To do this, we need to find the `customers` rows that have at least one entry in the `customers_services` join table. If the customer doesn't have an entry in the join table, then they don't have any services.

The way to do this is to do an `INNER JOIN` of the `customers` rows with the rows in `customers_services` using the `customer_id` foreign key in the join table:

```sql
SELECT customers.* FROM customers
INNER JOIN customers_services
        ON customer_id = customers.id;
```

This yields:
```plaintext
 id |    name     | payment_token
----+-------------+---------------
  1 | Pat Johnson | XHGOAHEQ
  1 | Pat Johnson | XHGOAHEQ
  1 | Pat Johnson | XHGOAHEQ
  3 | Lynn Blake  | KLZXWEEE
  3 | Lynn Blake  | KLZXWEEE
  3 | Lynn Blake  | KLZXWEEE
  3 | Lynn Blake  | KLZXWEEE
  3 | Lynn Blake  | KLZXWEEE
  4 | Chen Ke-Hua | KWETYCVX
  4 | Chen Ke-Hua | KWETYCVX
  5 | Scott Lakso | UUEAPQPS
  5 | Scott Lakso | UUEAPQPS
  5 | Scott Lakso | UUEAPQPS
  6 | Jim Pornot  | XKJEYAZA
  6 | Jim Pornot  | XKJEYAZA
  6 | Jim Pornot  | XKJEYAZA
(16 rows)
```

which is almost what we want, except there are a lot of duplicates. We can eliminate the duplicates by limiting our `SELECT` to just the `DISTINCT` rows, which gives us our solution:

```plaintext
id |    name     | payment_token
----+-------------+---------------
 3 | Lynn Blake  | KLZXWEEE
 6 | Jim Pornot  | XKJEYAZA
 1 | Pat Johnson | XHGOAHEQ
 4 | Chen Ke-Hua | KWETYCVX
 5 | Scott Lakso | UUEAPQPS
(5 rows)
```
