1. Create a new database called residents using the PostgreSQL command line tools.

  My answer:
  ```terminal
  $ createdb residents
  ```

  Solution:
  ```terminal
  $ createdb residents
  ```


2. Load this [file](https://raw.githubusercontent.com/launchschool/sql_course_data/master/sql-and-relational-databases/schema-data-and-sql/more-single-table-queries/residents_with_data.sql) into the database created in #1.

  My answer:
  ```terminal
  psql -d residents < residents_with_data.sql
  ```
  
  Alternatively, within sql
  ```sql
  residents=# \i ~/path_to_file/residents_with_data.sql
  ```

  Solution:
  ```terminal
  $ psql -d residents < residents_with_data.sql
  ```


3. Write a SQL query to list the ten states with the most rows in the people table in descending order.

  My answer:
  ```sql
  SELECT state, count(*)
  FROM people
  GROUP BY state
  ORDER BY count(*) DESC
  LIMIT 10;
  ```

  Solution:
  ```sql
  SELECT state, COUNT(id) FROM people GROUP BY state ORDER BY count DESC LIMIT 10;
  ```


4. Write a SQL query that lists each domain used in an email address in the people table and how many people in the database have an email address containing that domain. Domains should be listed with the most popular first.

  My answer:
  ```sql
  SELECT
    substring(email similar '%@#"%#"' escape '#') AS domain,
    count(email)
  FROM people
  GROUP BY domain
  ORDER BY count(email) DESC;
  ``` 
  See [Regex](https://www.postgresql.org/docs/15/functions-matching.html) in PostgreSQL

  Solution:
  ```sql
  SELECT substr(email, strpos(email, '@') + 1) as domain,
         COUNT(id)
    FROM people
    GROUP BY domain
    ORDER BY count DESC;
  ```

  REVIEW:
  We can just use ORDER BY count rather than ORDER BY count(colname)


5. Write a SQL statement that will delete the person with ID 3399 from the people table.

  My answer:
  ```sql
  DELETE FROM people
    WHERE id = 3399;
  ```

  Solution:
  ```sql
  DELETE FROM people WHERE id = 3399;
  ```


6. Write a SQL statement that will delete all users that are located in the state of California (`CA`).

  My answer:
  ```sql
  DELETE FROM people
    WHERE state = 'CA';
  ```

  Solution:
  ```sql
  DELETE FROM people WHERE state = 'CA';
  ```


7. Write a SQL statement that will update the given_name values to be all uppercase for all users with an email address that contains teleworm.us.

  My answer:
  ```sql
  UPDATE people
    SET give_name = upper(given_name)
    WHERE email ILIKE '%teleworm.us';
  ```

  Solution:
  ```sql
  UPDATE people SET given_name = UPPER(given_name) WHERE email LIKE '%teleworm.us';
  ```


8. Write a SQL statement that will delete all rows from the people table.

  My answer:
  ```sql
  DELETE FROM people;
  ```

  Solution:
  ```sql
  DELETE FROM people;
  ```
