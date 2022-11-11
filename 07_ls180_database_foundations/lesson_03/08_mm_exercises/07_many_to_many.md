## Total Gross Income

Assuming that everybody in our database has a bill coming due, and that all of them will pay on time, write a query to compute the total gross income we expect to receive.

Answer:
```plaintext
  gross
 --------
 678.50
(1 row)
```

My answer:
```sql
SELECT sum(price) AS gross
FROM services
  INNER JOIN customers_services
          ON services.id = service_id;
```

**Solution**
```sql
SELECT SUM(price) as gross
FROM services
INNER JOIN customers_services
        ON service_id = services.id;
```

**Discussion**

As with the previous exercise, it helps to approach this exercise step-by-step. Initially, let's display a list of customers, their services, and the prices of those services:

```sql
SELECT name, description, price
FROM services
INNER JOIN customers_services
        ON service_id = services.id
INNER JOIN customers
        ON customer_id = customers.id;
```

This produces:
```plaintext
    name     |    description     | price
-------------+--------------------+--------
 Pat Johnson | Unix Hosting       |   5.95
 Pat Johnson | DNS                |   4.95
 Pat Johnson | Whois Registration |   1.95
 Lynn Blake  | Unix Hosting       |   5.95
 Lynn Blake  | DNS                |   4.95
 Lynn Blake  | Whois Registration |   1.95
 Lynn Blake  | High Bandwidth     |  15.00
 Lynn Blake  | Business Support   | 250.00
 Chen Ke-Hua | Unix Hosting       |   5.95
 Chen Ke-Hua | High Bandwidth     |  15.00
 Scott Lakso | Unix Hosting       |   5.95
 Scott Lakso | DNS                |   4.95
 Scott Lakso | Dedicated Hosting  |  50.00
 Jim Pornot  | Unix Hosting       |   5.95
 Jim Pornot  | Dedicated Hosting  |  50.00
 Jim Pornot  | Bulk Email         | 250.00
(16 rows)
```

Now, let's compute the sum of all price values across all rows:
```sql
SELECT name, description, SUM(price) as gross
FROM services
INNER JOIN customers_services
        ON service_id = services.id
INNER JOIN customers
        ON customer_id = customers.id
GROUP BY name, description;
```

The output of this statement is nearly identical to the previous statement; it varies only in the order of the output records. The reason why the output is generally the same is that `SUM` only computes the sum for each grouping, but our grouping uses two columns. Let's eliminate the `description` column:

```sql
SELECT name, SUM(price) as gross
FROM services
INNER JOIN customers_services
        ON service_id = services.id
INNER JOIN customers
        ON customer_id = customers.id
GROUP BY name;
```

We now get the following results:
```plaintext
    name     |  gross
-------------+--------
 Pat Johnson |  12.85
 Scott Lakso |  60.90
 Chen Ke-Hua |  20.95
 Jim Pornot  | 305.95
 Lynn Blake  | 277.85
(5 rows)
```

We're almost there. All we need to do now is eliminate the `name` column. We can also remove the second join clause in the process, since we don't have a use for customer names in the final query results:

```sql
SELECT SUM(price) as gross
FROM services
INNER JOIN customers_services
        ON service_id = services.id;
```

which produces our expected result.
