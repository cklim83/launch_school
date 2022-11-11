## Services With At Least 3 Customers

Write a query that displays the description for every service that is subscribed to by at least 3 customers. Include the customer count for each description in the report. The report should look like this:

```plaintext
 description  | count
--------------+-------
 DNS          |     3
 Unix Hosting |     5
(2 rows)
```

My answer
```sql
SELECT description, count(customer_id)
FROM services
INNER JOIN customers_services 
        ON services.id = service_id
GROUP BY services.id
HAVING count(customer_id) >= 3;
```

**Solution**
```sql
SELECT description, COUNT(service_id)
FROM services
LEFT OUTER JOIN customers_services
             ON services.id = service_id
GROUP BY description
HAVING COUNT(customers_services.customer_id) >= 3
ORDER BY description;
```

**Discussion**

It helps to approach this exercise step-by-step. The first step is to obtain a list of the service descriptions, associated customer names, and the id of each service ordered by the description:

```sql
SELECT description, name, service_id
FROM services
LEFT OUTER JOIN customers_services
             ON services.id = service_id
LEFT OUTER JOIN customers
             ON customer_id = customers.id
ORDER BY description;
```

This produces:
```plaintext
    description     |    name     | service_id
--------------------+-------------+------------
Bulk Email          | Jim Pornot  |          7
Business Support    | Lynn Blake  |          5
DNS                 | Lynn Blake  |          2
DNS                 | Pat Johnson |          2
DNS                 | Scott Lakso |          2
Dedicated Hosting   | Jim Pornot  |          6
Dedicated Hosting   | Scott Lakso |          6
High Bandwidth      | Lynn Blake  |          4
High Bandwidth      | Chen Ke-Hua |          4
One-to-one Training |             |
Unix Hosting        | Chen Ke-Hua |          1
Unix Hosting        | Lynn Blake  |          1
Unix Hosting        | Pat Johnson |          1
Unix Hosting        | Scott Lakso |          1
Unix Hosting        | Jim Pornot  |          1
Whois Registration  | Lynn Blake  |          3
Whois Registration  | Pat Johnson |          3

(17 rows)
```

We know that based on join table, `customers_services`, each service is associated with a customer through the `service_id` and the `customer_id`. We can see this clearly above since we are able to match each customer by name with a `service_id`. But ultimately, the customer name isn't needed. It's enough to use either the `customer_id` or the `service_id` to show the connection between each customer and the service they are using. The next step is to remove the name column. Since we are removing the name column from the query, we can also remove the JOIN associated with the `customers` table. Lastly, let's also use `count` function with `service_id`, which will give us a total count of each service:

```sql
SELECT description, COUNT(service_id)
FROM services
LEFT OUTER JOIN customers_services
             ON services.id = service_id
GROUP BY description
ORDER BY description;
```

Note that we need to use the `GROUP BY` clause if we want to count the number of customers for each service. We group by the service description in this case. The output now looks like this:

```plaintext
     description     | count
---------------------+-------
 Bulk Email          |     1
 Business Support    |     1
 DNS                 |     3
 Dedicated Hosting   |     2
 High Bandwidth      |     2
 One-to-one Training |     0
 Unix Hosting        |     5
 Whois Registration  |     2
(8 rows)
```

We now need to restrict the output to just those services that have a count of at least 3. To do that, we need to use `HAVING` clause: this is required when selecting rows based on aggregated data such as a count. This leads to the solution and output we showed at the top of this exercise.
