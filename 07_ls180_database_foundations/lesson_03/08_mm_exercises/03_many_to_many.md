## Get Customers With No Services

Write a query to retrieve the `customer` data for every customer who does not currently subscribe to any services.

My answer:
```sql
SELECT customers.*
  FROM customers
    LEFT JOIN customers_services ON customers.id = customers_services.customer_id
  GROUP BY customers.id
  HAVING count(customers_services.id) = 0;
```

**Solution**

```sql
SELECT customers.* FROM customers
LEFT OUTER JOIN customers_services
             ON customer_id = customers.id
WHERE service_id IS NULL;
```

**Discussion**

Initially, we need to perform a join of `customers` and `customers_services` so we can associate every customer with their appropriate services. Since we need results for customers who don't have any services, we need to do an `OUTER JOIN`; specifically, we need to do a `LEFT OUTER JOIN` so we have a row for every customer in the `customers` table, regardless of whether they have any services.
```sql
SELECT customers.* FROM customers
LEFT OUTER JOIN customers_services
             ON customer_id = customers.id;
```

This yields:
```plaintext
 id |     name      | payment_token
----+---------------+---------------
  1 | Pat Johnson   | XHGOAHEQ
  1 | Pat Johnson   | XHGOAHEQ
  1 | Pat Johnson   | XHGOAHEQ
  3 | Lynn Blake    | KLZXWEEE
  3 | Lynn Blake    | KLZXWEEE
  3 | Lynn Blake    | KLZXWEEE
  3 | Lynn Blake    | KLZXWEEE
  3 | Lynn Blake    | KLZXWEEE
  4 | Chen Ke-Hua   | KWETYCVX
  4 | Chen Ke-Hua   | KWETYCVX
  5 | Scott Lakso   | UUEAPQPS
  5 | Scott Lakso   | UUEAPQPS
  5 | Scott Lakso   | UUEAPQPS
  6 | Jim Pornot    | XKJEYAZA
  6 | Jim Pornot    | XKJEYAZA
  6 | Jim Pornot    | XKJEYAZA
  2 | Nancy Monreal | JKWQPJKL
(17 rows)
```

which is obviously far more than we need. We need to restrict the result to just those customers that have no services. The way to do that is to add a `WHERE` clause that looks for a NULL `service_id`:
```sql
SELECT customers.* FROM customers
LEFT OUTER JOIN customers_services
             ON customer_id = customers.id
WHERE service_id IS NULL;
```

This yields:
```plaintext
 id |     name      | payment_token
----+---------------+---------------
  2 | Nancy Monreal | JKWQPJKL
(1 row)
```
which is the information we want.

**Further Exploration**

Can you write a query that displays all customers with no services and all services that currently don't have any customers? The output should look like this:
```plaintext
 id |     name      | payment_token | id |     description     | price
----+---------------+---------------+----+---------------------+--------
  2 | Nancy Monreal | JKWQPJKL      |    |                     |
    |               |               |  8 | One-to-one Training | 999.00
(2 rows)
```

My answer
```sql
SELECT customers.*, services.*
  FROM customers
    LEFT OUTER JOIN customers_services ON customers.id = customers_services.customer_id
    FULL OUTER JOIN services ON customers_services.service_id = services.id
  WHERE customers.id IS NULL OR services.id IS NULL;
```
