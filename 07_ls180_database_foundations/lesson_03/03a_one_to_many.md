Import this [file](https://raw.githubusercontent.com/launchschool/sql_course_data/master/sql-and-relational-databases/relational-data-and-joins/one-to-many-relationships/one-to-many.sql) into a new database before continuing.

```terminal
createdb one-to-many
psql -d one-to-many < 03b_one-to-many.sql
```

1. Write a SQL statement to add the following call data to the database:

  | when | duration | first_name | last_name | number |
  | --- | --- | --- | --- | --- |
  | 2016-01-18 14:47:00 | 632 | William | Swift | 7204890809 |


  My answer:
  ```sql
  INSERT INTO calls ("when", duration, contact_id)
    VALUES ('2016-01-18 14:47:00', 632, 6);
  INSERT 0 1
  ```
  
  `when` is a keyword in SQL. To insert the value without error, we need to
  refer to that column as "when".


  Solution:
  There is one column in our table that shares a name with a SQL keyword. This may cause some issues when you try to add call data to the database. Here list of [SQL keywords](https://www.postgresql.org/docs/8.1/sql-keywords-appendix.html). And here is a page about [SQL identifiers](https://www.postgresql.org/docs/9.1/sql-syntax-lexical.html#SQL-SYNTAX-IDENTIFIERS). These pages should help explain how to reference a table column that happens to share the same name as a SQL keyword.

  ```sql
  INSERT INTO calls ("when", duration, contact_id) VALUES ('2016-01-18 14:47:00', 632, 6);
  ```


2. Write a SQL statement to retrieve the call times, duration, and first name for all calls not made to William Swift.

  My answer:
  ```sql
  SELECT "when", duration, first_name
    FROM calls
    INNER JOIN contacts ON calls.contact_id = contacts.id
    WHERE (first_name || ' ' || last_name) != 'William Swift';
  ```

  Solution:
  ```sql
  sql-course=# SELECT calls.when, calls.duration, contacts.first_name
  sql-course-# FROM calls INNER JOIN contacts ON calls.contact_id = contacts.id
  sql-course-# WHERE (contacts.first_name || ' ' || contacts.last_name) != 'William Swift';
          when         | duration | first_name
  ---------------------+----------+------------
   2016-01-08 15:30:00 |      350 | Yuan
   2016-01-11 11:06:00 |      111 | Tamila
   2016-01-13 18:13:00 |     2521 | Tamila
   2016-01-17 09:43:00 |      982 | Yuan
  (4 rows)
  ```


3. Write SQL statements to add the following call data to the database:
  
  | when | duration | first_name | last_name | number |
  | --- | --- | --- | --- | --- |
  | 2016-01-17 11:52:00 | 175 | Merve | Elk | 6343511126 |
  | 2016-01-18 21:22:00 | 79 | Sawa | Fyodorov | 6125594874 |


  My answer:
  ```sql
  INSERT INTO contacts (first_name, last_name, number)
    VALUES ('Merve', 'Elk', '6343511126'),
           ('Sawa', 'Fyodorov', '6125594874');
  INSERT 0 2

  INSERT INTO calls ("when", duration, contact_id)
    VALUES ('2016-01-17 11:52:00', 175, 26),
           ('2016-01-18 21:22:00', 79, 27);
  INSERT 0 2
  ```

  Have to insert the contacts first since the foreign key contact_id in calls refers to these values and have a not null constraint.


  Solution:
  ```sql
  INSERT INTO contacts (first_name, last_name, number) VALUES ('Merve', 'Elk', '6343511126');
  INSERT INTO calls ("when", duration, contact_id) VALUES ('2016-01-17 11:52:00', 175, 26);

  INSERT INTO contacts (first_name, last_name, number) VALUES ('Sawa', 'Fyodorov', '6125594874');
  INSERT INTO calls ("when", duration, contact_id) VALUES ('2016-01-18 21:22:00', 79, 27);
  ``` 


4. Add a constraint to contacts that prevents a duplicate value being added in the column number.

  My answer:
  ```sql
  ALTER TABLE contacts ADD UNIQUE(number);
  ```

  Solution:
  ```sql
  ALTER TABLE contacts ADD CONSTRAINT number_unique UNIQUE (number);
  ```


5. Write a SQL statement that attempts to insert a duplicate number for a new contact but fails. What error is shown?

  ```sql
  INSERT INTO contacts (first_name, last_name, number)
    VALUES ('Tom', 'Duncan', '7204890809');

  ERROR:  duplicate key value violates unique constraint "contacts_number_key"
  DETAIL:  Key (number)=(7204890809) already exists.
  ```

  Solution:
  ```sql
  one-to-many=# INSERT INTO contacts (first_name, last_name, number) VALUES ('Nivi', 'Petrussen', '6125594874');
  ERROR:  duplicate key value violates unique constraint "number_unique"
  DETAIL:  Key (number)=(6125594874) already exists.
  ```


6. Why does "when" need to be quoted in many of the queries in this lesson?

  My answer:
  'WHEN' is a **reserved keyword** in SQL and cannot be used as identifiers. We add double quotes to inform PostgreSQL we are not referring to the reserved keyword.

  Solution:
  
  It is a reserved word. For a full list, see http://www.postgresql.org/docs/9.5/static/sql-keywords-appendix.html. Note that there are words on that list that are "non-reserved", which means they are allowed as table or column names but are known to the SQL parser as having a special meaning.

    As a general rule, if you get spurious parser errors for commands that contain any of the listed key words as an identifier you should try to quote the identifier to see if the problem goes away.


7. Draw an entity-relationship diagram for the data we've been working with in this assignment.

  Solution
  ![Entity Relationship Diagram](./03c_qn7_solution.png)
