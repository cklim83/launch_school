1. Write a SQL statement that makes a new sequence called "counter".

  My answer:
  ```sql
  CREATE SEQUENCE counter;
  ```

  Solution:
  ```sql
  CREATE SEQUENCE counter;
  ```


2. Write a SQL statement to retrieve the next value from the sequence created in #1.

  My answer:
  ```sql
  SELECT nextval(counter);
  ```

  Solution:
  ```sql
  SELECT nextval('counter');
  ```

  REVIEW:
  Note the need for single quote for the Sequence relation when passed to `nextval`.


3. Write a SQL statement that removes a sequence called "counter".

  My answer:
  ```sql
  DROP SEQUENCE counter;
  ```

  Solution:
  ```sql
  DROP SEQUENCE counter;
  ```


4. Is it possible to create a sequence that returns only even numbers? The [documentation for sequence might be useful](https://www.postgresql.org/docs/9.5/sql-createsequence.html).

  My answer:
  Yes.
  ```sql
  CREATE SEQUENCE even_counter INCREMENT BY 2
    START WITH 0;
  ```

  Solution:
  Yes:
  ```sql
  sql-course=# CREATE SEQUENCE even_counter INCREMENT BY 2 MINVALUE 2;
  CREATE SEQUENCE
  sql-course=# SELECT nextval('even_counter');
   nextval
  ---------
         2
  (1 row)

  sql-course=# SELECT nextval('even_counter');
   nextval
  ---------
         4
  (1 row)
  ```

  REVIEW:
  Note, we cannot start 0 since by default, the min value of a sequence is 1 unless overwritten.
  Hence we could use `CREATE SEQUENCE even_counter INCREMENT BY 2 MINVALUE 0;`


5. What will the name of the sequence created by the following SQL statement be?
  ```sql
  CREATE TABLE regions (id serial PRIMARY KEY, name text, area integer);
  ```

  My answer:
  `regions_id_seq`

  Solution:
  `regions_id_seq`

  REVIEW:
  `serial` creates a sequence with the following name `tablename_colname_seq`


6. Write a SQL statement to add an auto-incrementing integer primary key column to the films table.

  My answer:
  ```sql
  ALTER TABLE films
    ADD COLUMN id integer GENERATED ALWAYS AS IDENTITY PRIMARY KEY;
  ```

  Solution:
  ```sql
  ALTER TABLE films ADD COLUMN id serial PRIMARY KEY;
  ```

7. What error do you receive if you attempt to update a row to have a value for id that is used by another row?


  Solution:
  ```sql
  What error do you receive if you attempt to update a row to have a value for id that is used by another row?7. What error do you receive if you attempt to update a row to have a value for id that is used by another row?

  My answer:
  ```sql
  cklim=# UPDATE films SET id = 2 WHERE title = 'Die Hard';
  ERROR:  column "id" can only be updated to DEFAULT
  DETAIL:  Column "id" is an identity column defined as GENERATED ALWAYS.
  ```
  Got the above error as I defined Column id as integer GERENATED ALWAYS AS IDENTITY PRIMARY KEY. This
  prevent the id column have being assigned a value other than `DEFAULT`.

  Solution:
  ```sql
  films=# UPDATE films SET id = 3 WHERE title = 'Die Hard';
  ERROR:  duplicate key value violates unique constraint "films_pkey"
  DETAIL:  Key (id)=(3) already exists.
  ```
  We will get this error instead if id is defined as serial PRIMARY KEY.


8. What error do you receive if you attempt to add another primary key column to the films table?

  My answer:
  ```sql
  ALTER TABLE films ADD COLUMN id2 serial PRIMARY KEY;
  ERROR:  multiple primary keys for table "films" are not allowed
  ```

  Solution:
  ```sql
  films=# ALTER TABLE films ADD COLUMN another_id serial PRIMARY KEY;
  ERROR:  multiple primary keys for table "films" are not allowed
  ```


9. Write a SQL statement that modifies the table films to remove its primary key while preserving the id column and the values it contains.

  My answer:
  ```sql
  ALTER TABLE films DROP CONSTRAINT films_pkey;
  ```

  Solution:
  ```sql
  ALTER TABLE films DROP CONSTRAINT films_pkey;
  ``` 
