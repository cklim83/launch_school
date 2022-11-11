1. Import this [file](https://raw.githubusercontent.com/launchschool/sql_course_data/master/sql-and-relational-databases/schema-data-and-sql/more-constraints/films2.sql) into a PostgreSQL database.

  My answer:
  ```terminal
  psql -d cklim < ~/path_to_file/films2.sql
  ```

  Solution: 
  ```terminal
  $ psql -d sql-course < films2.sql
  ```


2. Modify all of the columns to be NOT NULL.

  My answer:
  ```sql
  ALTER TABLE films 
    ALTER COLUMN title SET NOT NULL,
    ALTER COLUMN year SET NOT NULL,
    ALTER COLUMN genre SET NOT NULL,
    ALTER COLUMN director SET NOT NULL,
    ALTER COLUMN duration SET NOT NULL;
  ```

  Solution:
  ```sql
  ALTER TABLE films ALTER COLUMN title SET NOT NULL;
  ALTER TABLE films ALTER COLUMN year SET NOT NULL;
  ALTER TABLE films ALTER COLUMN genre SET NOT NULL;
  ALTER TABLE films ALTER COLUMN director SET NOT NULL;
  ALTER TABLE films ALTER COLUMN duration SET NOT NULL;
  ```


3. How does modifying a column to be NOT NULL affect how it is displayed by \d films?

  My answer:
  The NOT NULL constraint will be added under the nullable column of the schema of table films.
  ```plaintext
                            Table "public.films"
    Column  |          Type          | Collation | Nullable | Default 
  ----------+------------------------+-----------+----------+---------
   title    | character varying(255) |           | not null | 
   year     | integer                |           | not null | 
   genre    | character varying(100) |           | not null | 
   director | character varying(255) |           | not null | 
   duration | integer                |           | not null | 
  ```

  Solution: 
  not null will be included in that column's Modifiers column:
  ```sql
  sql-course=# \d films
               Table "public.films"
    Column  |          Type          | Modifiers
  ----------+------------------------+-----------
   title    | character varying(255) | not null
   year     | integer                | not null
   genre    | character varying(100) | not null
   director | character varying(255) | not null
   duration | integer                | not null
  ```
  Note: the output of \d varies between versions of PostgreSQL. The look is basically the same, but the column names may be different, and there may be other columns present. In particular, the 'Modifiers' column name may be different.


4. Add a constraint to the table films that ensures that all films have a unique title.

  My answer:
  ```sql
  ALTER TABLE films
    ADD CONSTRAINT unique_title UNIQUE (title);
  ```
  Note: Giving the constraint a name using CONSTRAINT unique_title is optional. Without it, the constraint will
  be given a name of tablename_colname_key by default, i.e. films_title_key in this case.


  Solution:
  ```sql
  ALTER TABLE films ADD CONSTRAINT title_unique UNIQUE (title);
  ```


5. How is the constraint added in #4 displayed by \d films?

  My answer:
  ```plaintext
  Indexes:
    "title_unique" UNIQUE CONSTRAINT, btree (title)
  ```

  Solution:
  It appears as an index:
  ```plaintext
  Indexes:
    "title_unique" UNIQUE CONSTRAINT, btree (title)
  ```

  REVIEW:
  - A `UNIQUE` constraint is used to create an index.



6. Write a SQL statement to remove the constraint added in #4.

  My answer:
  ```sql
  ALTER TABLE films DROP CONSTRAINT title_unique;
  ```

  Solution:
  ```sql
  ALTER TABLE films DROP CONSTRAINT title_unique;
  ```


7. Add a constraint to films that requires all rows to have a value for title that is at least 1 character long.

  My answer:
  ```sql
  ALTER TABLE films ADD CONSTRAINT title_length CHECK (title <> '');
  ```

  Solution:
  ```sql
  ALTER TABLE films ADD CONSTRAINT title_length CHECK (length(title) >= 1);
  ```

  REVIEW:
  title not equal to empty string is not equivalent to length of at least one, if title column can take on NULL value.


8. What error is shown if the constraint created in #7 is violated? Write a SQL INSERT statement that demonstrates this.

  My answer:
  ```sql
  INSERT INTO films VALUES ('', 1970, 'comedy', 'John Mayer', 124);
  ERROR:  new row for relation "films" violates check constraint "title_length"
  DETAIL:  Failing row contains (, 1970, comedy, John Mayer, 124).
  ```

  Solution:
  ```sql
  sql-course=# INSERT INTO films VALUES ('', 1901, 'action', 'JJ Abrams', 126);
  ERROR:  new row for relation "films" violates check constraint "title_length"
  DETAIL:  Failing row contains (, 1901, action, JJ Abrams, 126).
  ```


9. How is the constraint added in #7 displayed by \d films? 

  My answer:
  ```sql
  Check constraints:
    "title_length" CHECK (length(title::text) >= 1)
  ```

  Solution:
  It appears as a "check constraint":
  ```sql
  Check constraints:
      "title_length" CHECK (length(title::text) >= 1)
  ```


10. Write a SQL statement to remove the constraint added in #7.

  My answer:
  ```sql
  ALTER TABLE films DROP CONSTRAINT title_length;
  ```

  Solution:
  ```sql
  ALTER TABLE films DROP CONSTRAINT title_length;
  ```


11. Add a constraint to the table films that ensures that all films have a year between 1900 and 2100.

  My answer:
  ```sql
  ALTER TABLE films ADD CONSTRAINT year_range CHECK (year BETWEEN 1900 AND 2100);
  ```

  Solution:
  ```sql
  ALTER TABLE films ADD CONSTRAINT year_range CHECK (year BETWEEN 1900 AND 2100);
  ```


12. How is the constraint added in #11 displayed by \d films?

  My answer:
  It appears as a "CHECK" constraint.
  ```sql
  Check constraints:
    "year_range" CHECK (year >= 1900 AND year <= 2100)
  ```

  Solution:
  It appears as a "check constraint":
  ```sql
  Check constraints:
      "year_range" CHECK (year >= 1900 AND year <= 2100)
  ```


13. Add a constraint to films that requires all rows to have a value for director that is at least 3 characters long and contains at least one space character (` `).

  My answer:
  ```sql
  ALTER TABLE films ADD CONSTRAINT director_check CHECK (length(director) >=3 AND director LIKE '% %');
  ```

  Solution:
  ```sql
  ALTER TABLE films ADD CONSTRAINT director_name
    CHECK (length(director) >= 3 AND position(' ' in director) > 0);
  ```


14. How does the constraint created in #13 appear in \d films?

  My answer:
  It appears as a "check constraint"
  ```sql
  Check constraints:
      "director_name" CHECK (length(director::text) >= 3 AND "position"(director::text, ' '::text) > 0)
  ```

  Solution:
  It appears as a "check constraint":
  ```sql
  Check constraints:
      "director_name" CHECK (length(director::text) >= 3 AND "position"(director::text, ' '::text) > 0)
  ```


15. Write an UPDATE statement that attempts to change the director for "Die Hard" to "Johnny". Show the error that occurs when this statement is executed.

  My answer:
  ```sql
  UPDATE films SET director = 'Johnny' WHERE title = 'Die Hard';
  
  ERROR:  new row for relation "films" violates check constraint "director_name"
  DETAIL:  Failing row contains (Die Hard, 1988, action, Johnny, 132).
  ```

  Solution:
  ```sql
  sql-course=# UPDATE films SET director = 'Johnny' WHERE title = 'Die Hard';
  ERROR:  new row for relation "films" violates check constraint "director_name"
  DETAIL:  Failing row contains (Die Hard, 1988, action, Johnny, 132).
  ```


16. List three ways to use the schema to restrict what values can be stored in a column.

  My answer:
  - Using the NOT NULL constraint e.g. `ALTER TABLE table_name ALTER COLUMN col_name SET NOT NULL;`
  - Using the CHECK constraint  e.g. `ALTER TABLE table_name ADD CONSTRAINT constraint_name CHECK (expression);`
  - Using the UNIQUE constraint  e.g. `ALTER TABLE table_name ADD UNIQUE (col_name [, ...]);`

  Solution:
  - Data type (which can include a length limitation)
  - NOT NULL Constraint
  - Check Constraint


17. Is it possible to define a default value for a column that will be considered invalid by a constraint? Create a table that tests this.

  My answer:
  Yes, we can set a default value that contradicts an existing constraint. However, we will not be allow to insert/modify
  a row to hold that invalid value. See below.

  ```sql
  ALTER TABLE films ALTER COLUMN director DEFAULT 'u

  ```sql
  -- Setting a default value for director that conflict with director_name constraint
  ALTER TABLE films ALTER COLUMN director SET DEFAULT 'unknown';

  cklim=# \d films
                                      Table "public.films"
    Column  |          Type          | Collation | Nullable |           Default            
  ----------+------------------------+-----------+----------+------------------------------
   title    | character varying(255) |           | not null | 
   year     | integer                |           | not null | 
   genre    | character varying(100) |           | not null | 
   director | character varying(255) |           | not null | 'unknown'::character varying
   duration | integer                |           | not null | 
  Indexes:
      "title_unique" UNIQUE CONSTRAINT, btree (title)
  Check constraints:
      "director_name" CHECK (length(director::text) >= 3 AND POSITION((' '::text) IN (director)) > 0)

  -- Trying to insert a new row with default director value
  cklim=# INSERT INTO films VALUES ('test1', 1952, 'comedy', DEFAULT, 257);
  ERROR:  new row for relation "films" violates check constraint "director_name"
  DETAIL:  Failing row contains (test1, 1952, comedy, unknown, 257).
  ```

  Solution:
  ```sql
  sql-course=# CREATE TABLE shoes (name text, size numeric(3,1) DEFAULT 0);
  CREATE TABLE
  sql-course=# ALTER TABLE shoes ADD CONSTRAINT shoe_size CHECK (size BETWEEN 1 AND 15);
  ```

  Notice how the default value for size, 0, will be rejected by the shoe_size constraint:

  ```sql
  sql-course=# INSERT INTO shoes (name) VALUES ('blue sneakers');
  ERROR:  new row for relation "shoes" violates check constraint "shoe_size"
  DETAIL:  Failing row contains (blue sneakers, 0.0).
  ```

  REVIEW:
  It is possible for a table to have a default value that is deemed invalid by a constraint. During 
  row insertion, we will however not be able to insert the default value.


18. How can you see a list of all of the constraints on a table?

  My answer:
  `\d table_name`

  Solution:
  Using `\d $tablename`, where `$tablename` is the name of the table.
