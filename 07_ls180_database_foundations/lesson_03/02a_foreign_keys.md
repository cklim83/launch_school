1. Import this [file](https://raw.githubusercontent.com/launchschool/sql_course_data/master/sql-and-relational-databases/relational-data-and-joins/foreign-keys/orders_products1.sql) into a new database.

  You may experience some errors while importing this database:
  
  ```plaintext
  ERROR:  relation "public.orders" does not exist
  ERROR:  relation "public.products" does not exist
  ERROR:  relation "public.orders" does not exist
  ERROR:  relation "public.products" does not exist
  ERROR:  relation "public.orders" does not exist
  ERROR:  sequence "products_id_seq" does not exist
  ERROR:  table "products" does not exist
  ERROR:  sequence "orders_id_seq" does not exist
  ERROR:  table "orders" does not exist

  You may ignore these errors.
  ```

  My answer:
  ```terminal
  createdb foreign_keys
  psql -d foreign_keys < 02b_orders_products.sql
  ```

2. Update the orders table so that referential integrity will be preserved for the data between orders and products.

  My answer:
  ```sql
  ALTER TABLE orders ADD FOREIGN KEY (product_id) REFERENCES products(id);
  ```

  Solution:
  ```sql
  ALTER TABLE orders ADD CONSTRAINT orders_product_id_fkey FOREIGN KEY (product_id) REFERENCES products(id);
  ```

  REVIEW
  - Unless we have a specific name in mind, [CONSTRAINT constraint_name] is optional. By default, PostgreSQL will name the constraint "tablename_colname_fkey"


3. Use psql to insert the data shown in the following table into the database:
  
  | Quantity | Product |
  | --- | --- |
  | 10 | small bolt |
  | 25 | small bolt |
  | 15 | large bolt |

  My answer:
  ```sql
  INSERT INTO products (name) 
    VALUES ('small bolt'),
           ('large bolt');
  
  INSERT INTO orders (product_id, quantity)
    VALUES (1, 10),
           (1, 25),
           (2, 15);
  ```
  
  Solution:
  ```sql
  foreign-keys=# INSERT INTO products (name) VALUES ('small bolt');
  INSERT 0 1
  foreign-keys=# INSERT INTO products (name) VALUES ('large bolt');
  INSERT 0 1
  foreign-keys=# SELECT * FROM products;
   id |    name
  ----+------------
    1 | small bolt
    2 | large bolt
  (2 rows)

  foreign-keys=# INSERT INTO orders (product_id, quantity) VALUES (1, 10);
  INSERT 0 1
  foreign-keys=# INSERT INTO orders (product_id, quantity) VALUES (1, 25);
  INSERT 0 1
  foreign-keys=# INSERT INTO orders (product_id, quantity) VALUES (2, 15);
  INSERT 0 1
  ```


4. Write a SQL statement that returns a result like this:

  ```plaintext
   quantity |    name
  ----------+------------
         10 | small bolt
         25 | small bolt
         15 | large bolt
  (3 rows)
  ```

  My answer:
  ```sql
  SELECT o.quantity, p.name
    FROM orders AS o
    INNER JOIN products AS p
      ON o.product_id = p.id;
  ```

  Solution:
  ```sql
  SELECT quantity, name FROM orders INNER JOIN products ON orders.product_id = products.id;
  ```


5. Can you insert a row into orders without a product_id? Write a SQL statement to prove your answer.

  My answer:
  No, an order cannot be inserted without a product_id due to the foreign key
  constraint, which checks to ensure any values for product_id has to be
  found in the id column of products.
  ```sql
  INSERT INTO orders (product_id, quantity) VALUES (NULL, 20);
  INSERT 0 1

  foreign_keys=# SELECT * from orders;
   id | product_id | quantity 
  ----+------------+----------
    1 |          1 |       10
    2 |          1 |       25
    3 |          2 |       15
    4 |            |       20
  (4 rows)
  ```

  Solution:
  Yes:
  ```sql
  foreign-keys=# INSERT INTO orders (quantity) VALUES (42);
  INSERT 0 1
  ```

  REVIEW
  - Although FOREIGN KEY constraint will restrict a column to values in the column its references, it will not reject NULL values. To ensure NULL values are rejected, we need to add a NOT NULL constraint.


6. Write a SQL statement that will prevent NULL values from being stored in orders.product_id. What happens if you execute that statement?

  My answer:
  ```sql
  ALTER TABLE orders ALTER COLUMN product_id SET NOT NULL;
  ERROR:  column "product_id" of relation "orders" contains null values
  ```

  Solution:
  ```sql
  foreign-keys=# ALTER TABLE orders ALTER COLUMN product_id SET NOT NULL;
  ERROR:  column "product_id" contains null values
  ```

7. Make any changes needed to avoid the error message encountered in #6.

  My answer:
  ```sql
  foreign_keys=# DELETE FROM orders WHERE product_id IS NULL;
  DELETE 1

  foreign_keys=# ALTER TABLE orders ALTER COLUMN product_id SET NOT NULL;
  ALTER TABLE
  ```

  Solution:
  ```sql
  foreign-keys=# SELECT * FROM orders;
   id | product_id | quantity
  ----+------------+----------
    1 |          1 |       10
    2 |          1 |       25
    3 |          2 |       15
    4 |            |       42
  (4 rows)
  
  foreign-keys=# DELETE FROM orders WHERE id = 4;
  DELETE 1
  foreign-keys=# ALTER TABLE orders ALTER COLUMN product_id SET NOT NULL;
  ALTER TABLE
  ```


8. Create a new table called reviews to store the data shown below. This table should include a primary key and a reference to the products table.

  | Product | Review |
  | small bolt | a little small |
  | small bolt | very round! |
  | large bolt | could have been smaller |

  My answer:
  ```sql
  foreign_keys=# CREATE TABLE reviews (
    id INTEGER GENERATED ALWAYS AS IDENTITY,
    review text,
    product_id INTEGER NOT NULL REFERENCES product(id)
  );
  CREATE TABLE
  ```
  
  Solution:
  ```sql
  CREATE TABLE reviews (
    id serial PRIMARY KEY,
    body text NOT NULL,
    product_id integer REFERENCES products (id)
  );
  ```


9. Write SQL statements to insert the data shown in the table in #8.

  My answer:
  ```sql
  foreign_keys=# INSERT INTO reviews (review, product_id)
    VALUES ('a little small', 1),
           ('very round!', 1),
           ('could have been smaller', 2);
  INSERT 0 3
  ```

  Solution:
  ```sql
  INSERT INTO reviews (product_id, body) VALUES (1, 'a little small');
  INSERT INTO reviews (product_id, body) VALUES (1, 'very round!');
  INSERT INTO reviews (product_id, body) VALUES (2, 'could have been smaller');
  ```


10. True or false: A foreign key constraint prevents NULL values from being stored in a column.

  My answer:
  **False**, as seen in Question 5 above. We need to add a NOT NULL constraint to achieve that.

  Solution:
  **False**. As we saw above, foreign key columns allow NULL values. As a result, it is often necessary to use NOT NULL and a foreign key constraint together.
