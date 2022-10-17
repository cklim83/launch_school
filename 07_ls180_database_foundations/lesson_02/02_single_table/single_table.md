1. Write a SQL statement that will create the following table, people:

  | name | age | occupation |
  | --- | --- | --- |
  | Abby | 34 | biologist |
  | Mu'nisah | 26 | NULL |
  | Mirabelle | 40 | contractor|

  My answer:
  ```sql
  CREATE TABLE people (
    name VARCHAR(20),
    age int,
    occupation VARCHAR(20)
  );
  ```

  Solution:
  ```sql
  CREATE TABLE people (name varchar(255), age integer, occupation varchar(255));
  ```

2. Write SQL statements to insert the data shown in #1 into the table.

  My answer:
  ```sql
  INSERT INTO people (name, age, occupation)
  VALUES ('Abby', 34, 'biologist'),
         ('Mu''nisah', 26, NULL),
         ('Mirabelle', 40, 'contractor');
  ```

  Solution:
  ```sql
  INSERT INTO people (name, age, occupation) VALUES ('Abby', 34, 'biologist');
  INSERT INTO people (name, age) VALUES ('Mu''nisah', 26);
  INSERT INTO people (name, age, occupation) VALUES ('Mirabelle', 40, 'contractor');
  ```

3. Write 3 SQL queries that can be used to retrieve the second row of the table shown in #1 and #2.

  My answer:
  ```sql
  SELECT * FROM people LIMIT 1 OFFSET 1;

  SELECT * FROM people WHERE name LIKE 'Mu%';

  SELECT * FROM people WHERE occupation IS NULL;
  ```

  Solution:
  ```sql
  SELECT * FROM people WHERE name = 'Mu''nisah';
  SELECT * FROM people WHERE age = 26;
  SELECT * FROM people WHERE occupation IS NULL;
  ```

4. Write a SQL statement that will create a table named birds that can hold the following values:

  | name | length | wingspan | family | extinct |
  | --- | --- | --- | --- | --- |
  | Spotted Towhee | 21.6 | 26.7 | Emberizidae | f |
  | American Robin | 25.5 | 36.0 | Turdidae | f |
  | Greater Koa Finch | 19.0 | 24.0 | Fringillidae | t |
  | Carolina Parakeet | 33.0 | 55.8 | Psittacidae | t |
  | Common Kestrel | 35.5 | 73.5 | Falconidae | f |

  My answer:
  ```sql
  CREATE TABLE birds (
    name VARCHAR(255),
    length REAL,
    wingspan REAL,
    family VARCHAR(255),
    extinct BOOLEAN
  );
  ```
  
  Solution
  ```sql
  CREATE TABLE birds (
    name character varying(255),
    length numeric(4,1),
    wingspan numeric(4,1),
    family text,
    extinct boolean
  );
  ```

  REVIEW:
  My answer will result in certain numeric values stored without a decimal point. For example:

  | name | length | wingspan | family | extinct |
  | --- | --- | --- | --- | --- |
  | Greater Koa Finch | 19 | 24 | Fingillidae | t |  

  Using numeric(4,1) allows up to 3 digits before the decimal place.


5. Using the table created in #4, write the SQL statements to insert the data as shown in the listing.

  My answer:
  ```sql
  INSERT INTO birds 
  VALUES ('Spotted Towhee', 21.6, 26.7, 'Emberizidae', false),
         ('American Robin', 25.5, 36.0, 'Turdidae', false),
         ('Greater Koa Finch', 19.0, 24.0, 'Fringillidae', true),
         ('Carolina Parakeet', 33.0, 55.8, 'Psittacidae', true),
         ('Common Kestrel', 35.5, 73.5, 'Falconidae', false);
  ```

  Solution:
  ```sql
  INSERT INTO birds VALUES ('Spotted Towhee', 21.6, 26.7, 'Emberizidae', false);
  INSERT INTO birds VALUES ('American Robin', 25.5, 36.0, 'Turdidae', false);
  INSERT INTO birds VALUES ('Greater Koa Finch', 19.0, 24.0, 'Fringillidae', true);
  INSERT INTO birds VALUES ('Carolina Parakeet', 33.0, 55.8, 'Psittacidae', true);
  INSERT INTO birds VALUES ('Common Kestrel', 35.5, 73.5, 'Falconidae', false);
  ```

6. Write a SQL statement that finds the names and families for all birds that are not extinct, in order from longest to shortest (based on the length column's value).

  My answer:
  ```sql
  SELECT name, family FROM birds 
  WHERE extinct = false
  ORDER BY length DESC;
  ```

  Solution
  ```sql
  SELECT name, family FROM birds WHERE extinct=false ORDER BY length DESC;
  ```

7. Use SQL to determine the average, minimum, and maximum wingspan for the birds shown in the table.

  My answer:
  ```sql
  SELECT ROUND(AVG(wingspan), 1) AS round, MIN(wingspan), MAX(wingspan) FROM birds;
  ```

  Solution:
  ```sql
  SELECT round(avg(wingspan), 1), min(wingspan), max(wingspan) FROM birds;
  ```

8. Write a SQL statement to create the table shown below, menu_items:

  | item | prep_time| ingredient_cost | sales | menu_price |
  | --- | --- | --- | --- | --- |
  | omelette | 10 | 1.50 | 182 | 7.99 |
  | tacos | 5 | 2.00 | 254 | 8.99 |
  | oatmeal | 1 | 0.50 | 79 | 5.99 |

  My answer:
  ```sql
  CREATE TABLE menu_items (
    item VARCHAR(255),
    prep_time INT,
    ingredient_cost NUMERIC(5, 2),
    sales INT,
    menu_price NUMERIC(5, 2)
  );
  ```

  Solution:
  ```sql
  CREATE TABLE menu_items (
    item text,
    prep_time integer,
    ingredient_cost numeric(4,2),
    sales integer,
    menu_price numeric(4,2)
  );
  ```

9. Write SQL statements to insert the data shown in #8 into the table.

  ```sql
  INSERT INTO menu_items
  VALUES ('omelette', 10, 1.50, 182, 7.99),
         ('tacos', 5, 2.00, 254, 8.99),
         ('oatmeal', 1, 0.50, 79, 5.99);
  ```

  Solution:
  ```sql
  INSERT INTO menu_items VALUES ('omelette', 10, 1.50, 182, 7.99);
  INSERT INTO menu_items VALUES ('tacos', 5, 2.00, 254, 8.99);
  INSERT INTO menu_items VALUES ('oatmeal', 1, 0.50, 79, 5.99);
  ```

10. Using the table and data from #8 and #9, write a SQL query to determine which menu item is the most profitable based on the cost of its ingredients, returning the name of the item and its profit.

  My answer:
  ```sql
  SELECT item, round((sales - sales/menu_price * ingredient_cost), 2) AS profit
  FROM menu_items
  ORDER BY profit DESC 
  LIMIT 1;
  ```

  Solution:
  ```sql
  SELECT item, menu_price - ingredient_cost AS profit FROM menu_items ORDER BY profit DESC LIMIT 1;
  ```

  REVIEW:
  Misinterpret the question. Thought intend was to calculate item with biggest profit in terms of 
  sales - item cost price * quantity sold


11. Write a SQL query to determine how profitable each item on the menu is based on the amount of time it takes to prepare one item. Assume that whoever is preparing the food is being paid $13 an hour. List the most profitable items first. Keep in mind that prep_time is represented in minutes and ingredient_cost and menu_price are in dollars and cents):

  My answer:
  ```sql
  SELECT item, menu_price, ingredient_cost, round((prep_time / 60.0 * 13), 2) AS labor, (menu_price - ingredient_cost - round((prep_time / 60.0 * 13), 2)) AS profit
  FROM menu_items
  ORDER BY profit DESC;
  ```

  Solution:
  ```sql
  SELECT item, menu_price, ingredient_cost,
       round(prep_time/60.0 * 13.0, 2) AS labor,
       menu_price - ingredient_cost - round(prep_time/60.0 * 13.0, 2) AS profit
  FROM menu_items
  ORDER BY profit DESC;
  ```

  REVIEW:
  - We cannot reference an alias (labor in this case) later in the same select list. This can be solved using subqueries.
  - prep_time / 60 returns 0 due to integer division.

