## Add New Customer

A new customer, 'John Doe', has signed up with our company. His payment token is 'EYODHLCN'. Initially, he has signed up for UNIX hosting, DNS, and Whois Registration. Create any SQL statement(s) needed to add this record to the database.

My answer
```sql
-- insert customer details into customers table
INSERT INTO customers (name, payment_token)
  VALUES ('John Doe', 'EYODHLCN');

-- insert subscription into customers_services table
INSERT INTO customers_services (customer_id, service_id) (
  SELECT customers.id, services.id
    FROM customers CROSS JOIN services
    WHERE customers.name = 'John Doe' AND services.description IN ('Unix Hosting', 'DNS', 'Whois Registration')
);
```

**Solution**
```sql
INSERT INTO customers (name, payment_token)
VALUES ('John Doe', 'EYODHLCN');

INSERT INTO customers_services (customer_id, service_id)
VALUES (7, 1), (7, 2), (7, 3);
```

**Discussion**

The main issue of concern here is to remember that there is a many-to-many relationship between the `customers` and `services` tables. To deal with this, we must use the `customers_services` join table to describe the relationships between the new customer and his services. Thus, we need 2 `INSERT` statements: one to insert a row in the `customers` table, and one to insert 3 rows into the join table, `customers_services`. Note that our solution assumes that the id for the new customer is `7`; your database may have a different id.

The order in which the two statements are executed is important: you can't add any rows to the join table until there is a corresponding row in both the `customers` and `services` tables; the `services` table already has the appropriate rows, but `customers` does not until we insert it. Thus, the insertion into the `customers` table must be performed first.
