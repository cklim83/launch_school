## Get Services With No Customers

Using `RIGHT OUTER JOIN`, write a query to display a list of all services that are not currently in use. Your output should look like this:

```plaintext
 description
-------------
 One-to-one Training
(1 row)
```

My answer:
```sql
SELECT description
  FROM customers_services AS cs
    RIGHT OUTER JOIN services AS s ON cs.service_id = s.id
  WHERE cs.service_id IS NULL;
```

**Solution**
```sql
SELECT description FROM customers_services
RIGHT OUTER JOIN services
              ON services.id = service_id
WHERE service_id IS NULL;
```

**Discussion**

This exercise is basically the same as the previous exercise, so we could, in theory, solve this like so:

```sql
SELECT description FROM services
LEFT OUTER JOIN customers_services
             ON service_id = services.id
WHERE service_id IS NULL;
```

However, the requirements call for a `RIGHT OUTER JOIN` instead of a `LEFT OUTER JOIN`. With a `LEFT OUTER JOIN`, rows in the first table (the one to the left of the `JOIN` clause) that don't match any rows in the second table (the one to the right of the `JOIN`) are retained; a `RIGHT OUTER JOIN` reverses that. The easiest way to address this difference is to use the `customers_services` table as the left table, and the `services` table as the right table. Once we have the joined results, we use `WHERE` to limit the results to just those entries that don't have a service id.

We could add `DISTINCT` to this query, which may be helpful if we have a large number of services or customers with a large number of services, but it isn't absolutely necessary for this exercise.
