## Services for each Customer

Write a query to display a list of all customer names together with a comma-separated list of the services they use. Your output should look like this:

```plaintext
     name      |                                services
---------------+-------------------------------------------------------------------------
 Pat Johnson   | Unix Hosting, DNS, Whois Registration
 Nancy Monreal |
 Lynn Blake    | DNS, Whois Registration, High Bandwidth, Business Support, Unix Hosting
 Chen Ke-Hua   | High Bandwidth, Unix Hosting
 Scott Lakso   | DNS, Dedicated Hosting, Unix Hosting
 Jim Pornot    | Unix Hosting, Dedicated Hosting, Bulk Email
(6 rows)
```

My answer
```sql
SELECT name, string_agg(description, ', ') AS services
  FROM customers AS c
    LEFT OUTER JOIN customers_services AS cs ON c.id = cs.customer_id
    LEFT OUTER JOIN services AS s ON s.id = cs.service_id
  GROUP BY c.id;
```

**Solution**
```sql
SELECT customers.name,
       string_agg(services.description, ', ') AS services
FROM customers
LEFT OUTER JOIN customers_services
             ON customer_id = customers.id
LEFT OUTER JOIN services
             ON services.id = service_id
GROUP BY customers.id;
```

**Discussion**

For this exercise, you will need the `string_agg` function to combine multiple service descriptions into a comma separated list. We will also use the `AS` clause to convert the column name shown in the output to `services`; if we don't use `AS`, the column name will be `string_agg`, which isn't very helpful.

Since we need to select data from both the `customers` and `services` tables, we need two `JOIN` clauses: one that joins `customers` to the `customers_services`, and one that joins `customers_services` to `services`. Both `JOIN` clauses need to be `LEFT OUTER JOIN` clauses; if we try to use an `INNER JOIN` for either clause, we will lose the record for `Nancy Monreal` since she does not have any services.

Finally, since we are using an aggregation function (`string_agg`), we must use a `GROUP BY` clause to group the results. We chose to group them by `customers.id` so all of the services for each customer id can be processed by `string_agg`. We could also group the results by `customers.name`: the order of the output might be different if we do, though, but we do not dictate an order in this exercise.


**Further Exploration**

Can you modify the above command so the output looks like this?

```plaintext
     name      |    description
---------------+--------------------
 Chen Ke-Hua   | High Bandwidth
               | Unix Hosting
 Jim Pornot    | Dedicated Hosting
               | Unix Hosting
               | Bulk Email
 Lynn Blake    | Whois Registration
               | High Bandwidth
               | Business Support
               | DNS
               | Unix Hosting
 Nancy Monreal |
 Pat Johnson   | Whois Registration
               | DNS
               | Unix Hosting
 Scott Lakso   | DNS
               | Dedicated Hosting
               | Unix Hosting
(17 rows)
```

This won't be easy! Hint: you will need to use the [window lag function](https://www.postgresql.org/docs/9.5/functions-window.html) together with a [CASE condition](https://www.postgresql.org/docs/9.5/functions-conditional.html) in your `SELECT`. To get you started, try this command:

```sql
SELECT customers.name,
       lag(customers.name, 2)
         OVER (ORDER BY customers.name)
         AS previous,
       services.description
FROM customers
LEFT OUTER JOIN customers_services
             ON customer_id = customers.id
LEFT OUTER JOIN services
             ON services.id = service_id;
```

Examine the relationship between the previous column and the rest of the table to get a handle on what lag does.


My answer:
Above sample code produce the following result:

```plaintext
     name      |   previous    |    description     
---------------+---------------+--------------------
 Chen Ke-Hua   |               | High Bandwidth
 Chen Ke-Hua   | Chen Ke-Hua   | Unix Hosting
 Jim Pornot    | Chen Ke-Hua   | Dedicated Hosting
 Jim Pornot    | Jim Pornot    | Unix Hosting
 Jim Pornot    | Jim Pornot    | Bulk Email
 Lynn Blake    | Jim Pornot    | Whois Registration
 Lynn Blake    | Lynn Blake    | High Bandwidth
 Lynn Blake    | Lynn Blake    | Business Support
 Lynn Blake    | Lynn Blake    | DNS
 Lynn Blake    | Lynn Blake    | Unix Hosting
 Nancy Monreal | Lynn Blake    | 
 Pat Johnson   | Nancy Monreal | Whois Registration
 Pat Johnson   | Pat Johnson   | DNS
 Pat Johnson   | Pat Johnson   | Unix Hosting
 Scott Lakso   | Pat Johnson   | DNS
 Scott Lakso   | Scott Lakso   | Dedicated Hosting
 Scott Lakso   | Scott Lakso   | Unix Hosting
(17 rows)
```

`lag(customers.name) OVER (ORDER BY customer.name)` AS previous repeats customer
names with a one row lag. Comparing the intended output with results from sample
code, we noticed that rows where we want the name to appear have different values
between `name` and `previous`. We can use a `CASE` statement to show the name if
values in `name` and `previous` are the same, show `NULL` in `name` column. Otherwise show customers.name. This will also take care of the the special case of comparing
`Chen Ke-Hua` with `NULL`. One possible solution is:

```sql
SELECT
  CASE WHEN customers.name = lag(customers.name) OVER (ORDER BY customers.name) THEN NULL
  ELSE customers.name END AS name,
  services.description
FROM customers
LEFT OUTER JOIN customers_services
             ON customer_id = customers.id
LEFT OUTER JOIN services
             ON services.id = service_id;
``` 

Another possible answer:
```sql
SELECT CASE rank() OVER (PARTITION BY c.name ORDER BY s.description)
         WHEN 1 THEN c.name
         ELSE NULL
       END AS name,
       s.description
FROM customers c
LEFT OUTER JOIN customers_services cs
             ON cs.customer_id = c.id
LEFT OUTER JOIN services s
             ON s.id = cs.service_id
ORDER BY c.name, s.description;
```
