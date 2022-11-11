## Set Up Database

In this set of exercises, we will work with a billing database for a company that provides web hosting services to its customers. The database will contain information about its customers and the services each customer uses. Each customer can have any number of services, and every service can have any number of customers. Thus, there will be a many-to-many (M:M) relationship between the customers and the services. Some customers don't presently have any services, and not every service must be in use by any customers.

Initially, we need to create a `billing` database with a `customers` table and a `services` table. The `customers` table should include the following columns:

- `id` is a unique numeric customer id that auto-increments and serves as a primary key for this table.
- `name` is the customer's name. This value must be present in every record and may contain names of any length.
- `payment_token` is a required unique 8-character string that consists of solely uppercase alphabetic letters. It identifies each customer's payment information with the payment processor the company uses.


The `services` table should include the following columns:
- `id` is a unique numeric service id that auto-increments and serves as a primary key for this table.
- `description` is the service description. This value must be present and may contain any text.
- `price` is the annual service price. It must be present, must be greater than or equal to `0.00`. The data type is `numeric(10, 2)`.

Once you've created these tables, here is some data that you can enter into them (feel free to enter some data of your own as well):

```plaintext
-- Data for the customers table

id | name          | payment_token
--------------------------------
1  | Pat Johnson   | XHGOAHEQ
2  | Nancy Monreal | JKWQPJKL
3  | Lynn Blake    | KLZXWEEE
4  | Chen Ke-Hua   | KWETYCVX
5  | Scott Lakso   | UUEAPQPS
6  | Jim Pornot    | XKJEYAZA
```

```plaintext
-- Data for the services table

id | description         | price
---------------------------------
1  | Unix Hosting        | 5.95
2  | DNS                 | 4.95
3  | Whois Registration  | 1.95
4  | High Bandwidth      | 15.00
5  | Business Support    | 250.00
6  | Dedicated Hosting   | 50.00
7  | Bulk Email          | 250.00
8  | One-to-one Training | 999.00
```

Once you have entered the data into your tables, create a join table that associates customers with services and vice versa. The join table should have columns for both the services id and the customers id, as well as a primary key named `id` that auto-increments.

The customer id in this table should have the property that deleting the corresponding customer record from the `customers` table will automatically delete all rows from the join table that have that customer_id. Do **not** apply this same property to the service id.

Each combination of customer and service in the table should be unique. In other words, a customer shouldn't be listed as using a particular service more than once.

Enter some data in the join table that shows which services each customer uses as follows:

- Pat Johnson uses Unix Hosting, DNS, and Whois Registration
- Nancy Monreal doesn't have any active services
- Lynn Blake uses Unix Hosting, DNS, Whois Registration, High Bandwidth, and Business Support
- Chen Ke-Hua uses Unix Hosting and High Bandwidth
- Scott Lakso uses Unix Hosting, DNS, and Dedicated Hosting
- Jim Pornot uses Unix Hosting, Dedicated Hosting, and Bulk Email


My answer

- Create `billing` database from terminal and connect to it
```terminal
CREATEDB billing
psql -d billing
```

- Create `customers` table within `billing` database
```sql
CREATE TABLE customers (
  id integer GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  name text NOT NULL,
  payment_token char(8) NOT NULL UNIQUE CHECK (payment_token SIMILAR TO '[A-Z]{8}')
);
```

- Create a `services` table within `billing` database
```sql
CREATE TABLE services (
  id integer GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  description text NOT NULL,
  price numeric(10, 2) NOT NULL CHECK (price >= 0.00)
);

- Insert given data into `customers` table
```sql
INSERT INTO customers (name, payment_token)
  VALUES ('Pat Johnson', 'XHGOAHEQ'),
         ('Nancy Monreal', 'JKWQPJKL'),
         ('Lynn Blake', 'KLZXWEEE'),
         ('Chen Ke-Hua', 'KWETYCVX'),
         ('Scott Lakso', 'UUEAPQPS'),
         ('Jim Pornot', 'XKJEYAZA');
```

- Insert given data into `services` table
```sql
INSERT INTO services (description, price)
  VALUES ('Unix Hosting', 5.95),
         ('DNS', 4.95),
         ('Whois Registration', 1.95),
         ('High Bandwidth', 15.00),
         ('Business Support', 250.00),
         ('Dedicated Hosting', 50.00),
         ('Bulk Email', 250.00),
         ('One-to-one Training', 999.00);
```

- Create Join Table
```sql
CREATE TABLE customers_services (
  id integer GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  customer_id integer REFERENCES customers(id) ON DELETE CASCADE,
  service_id integer REFERENCES services(id)
);

ALTER TABLE customers_services
  ALTER COLUMN customer_id SET NOT NULL,
  ALTER COLUMN service_id SET NOT NULL,
  ADD UNIQUE (customer_id, service_id);
```

- Insert data to `customers_services` join table
```sql
INSERT INTO customers_services (customer_id, service_id)(
  SELECT customers.id, services.id
    FROM customers
      CROSS JOIN services
    WHERE customers.name = 'Pat Johnson' 
      AND services.description IN ('Unix Hosting', 'DNS', 'Whois Registration')
);

INSERT INTO customers_services (customer_id, service_id)(
  SELECT customers.id, services.id
    FROM customers
      CROSS JOIN services
    WHERE customers.name = 'Lynn Blake'
      AND services.description IN ('Unix Hosting', 'DNS', 'Whois Registration',
                                   'High Bandwidth', 'Business Support')
);

INSERT INTO customers_services (customer_id, service_id)(
  SELECT customers.id, services.id
    FROM customers
      CROSS JOIN services
    WHERE customers.name = 'Chen Ke-Hua'
      AND services.description IN ('Unix Hosting','High Bandwidth')
);

INSERT INTO customers_services (customer_id, service_id)(
  SELECT customers.id, services.id
    FROM customers
      CROSS JOIN services
    WHERE customers.name = 'Scott Lakso'
      AND services.description IN ('Unix Hosting','DNS', 'Dedicated Hosting')
);

INSERT INTO customers_services (customer_id, service_id)(
  SELECT customers.id, services.id
    FROM customers
      CROSS JOIN services
    WHERE customers.name = 'Jim Pornot'
      AND services.description IN ('Unix Hosting', 'Dedicated Hosting', 'Bulk Email')
);
```


**Approach/Algorithm**

Check the PostgreSQL documentation for information on using regular expressions in SQL. You will need this to add a valid CHECK constraint to the `payment_token` column.


**Solution**

```sql
CREATE DATABASE billing;
\c billing

CREATE TABLE customers (
  id serial PRIMARY KEY,
  name text NOT NULL,
  payment_token char(8) NOT NULL UNIQUE CHECK (payment_token ~ '^[A-Z]{8}$')
);

CREATE TABLE services (
  id serial PRIMARY KEY,
  description text NOT NULL,
  price numeric(10, 2) NOT NULL CHECK (price >= 0.00)
);

INSERT INTO customers (name, payment_token)
VALUES
  ('Pat Johnson', 'XHGOAHEQ'),
  ('Nancy Monreal', 'JKWQPJKL'),
  ('Lynn Blake', 'KLZXWEEE'),
  ('Chen Ke-Hua', 'KWETYCVX'),
  ('Scott Lakso', 'UUEAPQPS'),
  ('Jim Pornot', 'XKJEYAZA');

INSERT INTO services (description, price)
VALUES
  ('Unix Hosting', 5.95),
  ('DNS', 4.95),
  ('Whois Registration', 1.95),
  ('High Bandwidth', 15.00),
  ('Business Support', 250.00),
  ('Dedicated Hosting', 50.00),
  ('Bulk Email', 250.00),
  ('One-to-one Training', 999.00);

CREATE TABLE customers_services (
  id serial PRIMARY KEY,
  customer_id integer
    REFERENCES customers (id)
    ON DELETE CASCADE
    NOT NULL,
  service_id integer
    REFERENCES services (id)
    NOT NULL,
  UNIQUE(customer_id, service_id)
);

INSERT INTO customers_services (customer_id, service_id)
VALUES
  (1, 1), -- Pat Johnson/Unix Hosting
  (1, 2), --            /DNS
  (1, 3), --            /Whois Registration
  (3, 1), -- Lynn Blake/Unix Hosting
  (3, 2), --           /DNS
  (3, 3), --           /Whois Registration
  (3, 4), --           /High Bandwidth
  (3, 5), --           /Business Support
  (4, 1), -- Chen Ke-Hua/Unix Hosting
  (4, 4), --            /High Bandwidth
  (5, 1), -- Scott Lakso/Unix Hosting
  (5, 2), --            /DNS
  (5, 6), --            /Dedicated Hosting
  (6, 1), -- Jim Pornot/Unix Hosting
  (6, 6), --           /Dedicated Hosting
  (6, 7); --           /Bulk Email
```

**Discussion**

Much of this exercise's solution should be familiar to you by now: create the database, set up some tables, add the data. Note that we use a shorthand notation for the `INSERT` commands that lets us insert more than one row with each `INSERT`.

One thing that may be new to you is the `CHECK` constraint for the `payment_token` in the `customers` table. This constraint uses the `~` operator to perform a regular expression match of the column's value vs. the regular expression on the right. The regular expression itself matches any string of precisely eight uppercase alphabetic letters; if you attempt to insert any other value, the constraint will fail.

The chief item of note, though, is the 3rd table; this is a "join table" that keeps track of the M:M relationship between the `customers` and `services` tables. Such join tables often have names that combine the names of the related tables, as we do here. The table contains three columns: an id primary key for the join table itself, and the primary keys for the two tables which are both defined as foreign keys in the join table. We impose a unique constraint on the combined foreign keys to prevent having duplicate join table records.

Once you have the join table set up, establishing the relationships between the two tables consists of adding one row to the join table for each relationship. For instance, Scott Lakso has a Unix Hosting, DNS, and a Dedicated Hosting service, so we add three records to the table:

- one that relates Scott (whose customer id is `5`) to the Unix Hosting service (service id `1`),
- one that associates Scott with the DNS service (service id `2`), and
- one that links Scott to the Dedicated Hosting service (service id `6`).

Note that the `customer_id` includes the clause `ON DELETE CASCADE`. This property ensures that PostgreSQL will automatically delete the corresponding rows from this table when you delete that customer from the `customers` table.

**Review**
- `~` regex operator
- We can add `NOT NULL` constraint after the foreign key
- We can add `UNIQUE(customer_id, service_id) after the fields.
