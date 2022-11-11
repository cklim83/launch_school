1. Load this [file](https://raw.githubusercontent.com/launchschool/sql_course_data/master/sql-and-relational-databases/schema-data-and-sql/loading-database-dumps/films1.sql) into your database.

    What does the file do?
    What is the output of the command? What does each line in this output mean?
    Open up the file and look at its contents. What does the first line do?


  My answer:
  The file deletes any pre-existing table called films, then create a new films table
  with 3 columns: title (up to 255 chars), "year" (integer) and genre (up to 100 chars)

  It then insert the following values into this films table:
  | title | "year" | genre |
  | --- | --- | --- |
  | Die Hard | 1988 | action |
  | Casablanca | 1942 | drama |
  | The Conversation | 1974 | thriller |

  After running the SQL Statements, we get the following outputs:
  ```sql
  DROP TABLE
  CREATE TABLE
  INSERT 0 1
  INSERT 0 1
  INSERT 0 1
  ```

  Solution:
  The SQL file we used has the column name year in quotes. While it's fine to use year without quotes in PostgreSQL, it can cause issues in other RDBMSs when year is a reserved word.

  1. The file contains SQL statements, when imported the statements are executed.
     

  2. NOTICE:  table "films" does not exist, skipping
     DROP TABLE IF EXISTS public.films; # there is no table called `films` in the database so this command is skipped
     CREATE TABLE # Creates a table
     INSERT 0 1 # Inserts one record into a table
     INSERT 0 1 # Inserts one record into a table
     INSERT 0 1 # Inserts one record into a table

  3. Drops the table films if it already exists


2.  Write a SQL statement that returns all rows in the films table.

  My answer:
  ```sql
  SELECT * FROM films;
  ```
  
  Solution:
  ```sql
  SELECT * FROM films;
  ```


3. Write a SQL statement that returns all rows in the films table with a title shorter than 12 letters.

  My answer:
  ```sql
  SELECT * FROM films WHERE length(title) < 12;
  ```

  Solution:
  ```sql
  SELECT * FROM films WHERE length(title) < 12;
  ```


4. Write the SQL statements needed to add two additional columns to the films table: director, which will hold a director's full name, and duration, which will hold the length of the film in minutes.

  My answer:
  ```sql
  ALTER TABLE films
    ADD COLUMN director VARCHAR(255),
    ADD COLUMN duration INTEGER;
  ```

  Solution:
  ```sql
  ALTER TABLE films ADD COLUMN director varchar(255);
  ALTER TABLE films ADD COLUMN duration integer;
  ```


5. Write SQL statements to update the existing rows in the database with values for the new columns:
  
  | title | director | duration |
  | --- | --- | --- |
  | Die Hard | John McTiernan | 132 |
  | Casablanca | Michael Curtiz | 102 |
  | The Conversation | Francis Ford Coppola | 113 |


  My answer:
  ```sql
  INSERT INTO films (director, duration)
  VALUES ('John McTiernan', 132),
         ('Michael Curtiz', 102),
         ('Francis Ford Coppola', 113);
  ```

  Solution:
  ```sql
  UPDATE films
    SET director = 'John McTiernan',
        duration = 132
    WHERE title = 'Die Hard';
  UPDATE films
    SET director = 'Michael Curtiz',
        duration = 102
    WHERE title = 'Casablanca';
  UPDATE films
    SET director = 'Francis Ford Coppola',
        duration = 113
    WHERE title = 'The Conversation';
  ```  

  REVIEW:
  My answer is wrong as `INSERT` will add new rows. We need to use `UPDATE` instead if
  we want to change existing rows. Result of using `INSERT` will be:

        title       | year |  genre   |       director       | duration 
  ------------------+------+----------+----------------------+----------
   Die Hard         | 1988 | action   |                      |         
   Casablanca       | 1942 | drama    |                      |         
   The Conversation | 1974 | thriller |                      |         
                    |      |          | John McTiernan       |      132
                    |      |          | Michael Curtiz       |      102
                    |      |          | Francis Ford Coppola |      113
  (6 rows)


6. Write SQL statements to insert the following data into the films table:

  | title | year | genre | director | duration | 
  | --- | --- | --- | --- | --- |
  | 1984 | 1956 | scifi | Michael Anderson | 90 |
  | Tinker Tailor Soldier Spy | 2011 | espionage | Tomas Alfredson | 127 |
  | The Birdcage | 1996 | comedy | Mike Nichols | 118 |


  My answer:
  ```sql
  INSERT INTO films 
  VALUES ('1984', 1956, 'scifi', 'Michael Anderson', 90),
         ('Tinker Tailor Soldier Spy', 2011, 'espionage', 'Tomas Alfredson', 127),
         ('The Birdcage', 1996, 'comedy', 'Mike Nichols', 118);
  ```

  Solution:
  ```sql
  INSERT INTO films (title, "year", genre, director, duration)
  VALUES ('1984', 1956, 'scifi', 'Michael Anderson', 90),
         ('Tinker Tailor Soldier Spy', 2011, 'espionage',
           'Tomas Alfredson', 127),
         ('The Birdcage', 1996, 'comedy', 'Mike Nichols', 118);
  ```

  REVIEW:
  Preferable to include the table columns to be sure the order is correct.


7. Write a SQL statement that will return the title and age in years of each movie, with newest movies listed first:

  My answer:
  ```sql
  SELECT title, extract(year from CURRENT_DATE) - "year" AS age
  FROM films
  ORDER BY age ASC;
  ```

  Solution:
  ```sql
  SELECT title, extract("year" from current_date) - "year" AS age
    FROM films
    ORDER BY age ASC;
  ```


8. Write a SQL statement that will return the title and duration of each movie longer than two hours, with the longest movies first.

  My answer:
  ```sql
  SELECT title, duration
  FROM films
  WHERE duration > 120
  ORDER BY duration DESC;
  ```

  Solution:
  ```sql
  SELECT title, duration FROM films WHERE duration > 120 ORDER BY duration DESC;
  ```


9. Write a SQL statement that returns the title of the longest film.

  My answer:
  ```sql
  SELECT title
  FROM films 
  WHERE duration = (SELECT max(duration) FROM films);
  ```

  Solution:
  ``sql
  SELECT title FROM films ORDER BY duration DESC LIMIT 1;
  ```
