1. Import this [file](https://raw.githubusercontent.com/launchschool/sql_course_data/master/sql-and-relational-databases/schema-data-and-sql/group-by-and-aggregate-functions/films4.sql) into a database.

  My answer:
  ```terminal
  psql -d cklim < films4.sql
  ```

  Solution:
  ```terminal
  $ psql -d films < films4.sql
  ```


2. Write SQL statements that will insert the following films into the database:

  | title | year | genre | director | duration | 
  | --- | --- | --- | --- | --- |
  | Wayne's World | 1992 | comedy | Penelope Spheeris | 95 |
  | Bourne Identity | 2002 | espionage | Doug Liman | 118 |

  My answer:
  ```sql
  INSERT INTO films (title, year, genre, director, duration)
  VALUES ('Wayne''s World', 1992, 'comedy', 'Penelope Spheeris', 95),
         ('Bourne Identity', 2002, 'espionage', 'Doug Liman', 118);
  ```

  Solution:
  ```sql
  INSERT INTO films (title, year, genre, director, duration)
    VALUES ('The Bourne Identity', 2002, 'espionage', 'Doug Liman', 118);
  INSERT INTO films (title, year, genre, director, duration)
    VALUES ('Wayne''s World', 1992, 'comedy', 'Penelope Spheeris', 95);
  ```


3. Write a SQL query that lists all genres for which there is a movie in the films table.

  My answer:
  ```sql
  SELECT distinct genre FROM films;
  ```

  Solution:
  ```sql
  films=# SELECT DISTINCT genre FROM films;
   genre
  -----------
   comedy
   thriller
   drama
   espionage
   horror
   scifi
   action
   crime
  (8 rows)
  ``` 


4. Write a SQL query that returns the same results as the answer for #3, but without using DISTINCT.

  My answer:
  ```sql
  SELECT genre FROM films GROUP BY genre;
  ```

  Solution:
  ```sql
  SELECT genre FROM films GROUP BY genre;
  ```


5. Write a SQL query that determines the average duration across all the movies in the films table, rounded to the nearest minute.

  **Output**
  ```plaintext
    round
  -------
     119
  (1 row)
  ```

  My answer:
  ```sql
  SELECT round(AVG(duration), 0) FROM films;
  ```

  Solution:
  ```sql
  SELECT ROUND(AVG(duration)) FROM films;
  ```


6. Write a SQL query that determines the average duration for each genre in the films table, rounded to the nearest minute.

  **Output**
  ```plaintext
     genre   | average_duration
  -----------+------------------
   comedy    |              102
   thriller  |              113
   drama     |               99
   espionage |              123
   horror    |              113
   scifi     |              126
   action    |              132
   crime     |              175
  (8 rows)
  ```

  My answer:
  ```sql
  SELECT genre, ROUND(AVG(duration)) AS average_duration
    FROM films
    GROUP BY genre;
  ```

  Solution:
  ```sql
  SELECT genre, ROUND(AVG(duration)) AS average_duration FROM films GROUP BY genre;
  ```


7. Write a SQL query that determines the average duration of movies for each decade represented in the films table, rounded to the nearest minute and listed in chronological order.

  **Output**
  ```plaintext
   decade | average_duration
  --------+------------------
     1940 |              102
     1950 |               93
     1970 |              144
     1980 |              112
     1990 |              114
     2000 |              116
     2010 |              133
  (7 rows)
  ```

  My answer:
  ```sql
  SELECT div(year, 10) * 10 AS decade, ROUND(AVG(duration)) AS average_duration
    FROM films
    GROUP BY decade;
    ORDER BY decade ASC;
  ``` 

  Solution:
  ```sql
  SELECT year / 10 * 10 as decade, ROUND(AVG(duration)) as average_duration
    FROM films GROUP BY decade ORDER BY decade;
  ```
  If that year / 10 * 10 looks a little odd, that's understandable. This code works to round the year down to the decade since year is defined as an integer, and an integer divided by another integer always yields an integer in SQL. Thus, for instance, 1944 / 10 is 194. We then multiply that by 10 to get 1940.

  You can also use the ROUND function to do the same thing a little less cryptically:

  ```sql
  SELECT ROUND(year, -1) as decade, ROUND(AVG(duration)) as average_duration
    FROM films GROUP BY decade ORDER BY decade;
  ```

  REVIEW:
  We cannot use ROUND(year, -1) to form the decade as round(1965, -1) will be in 1970 decade rather than 1960 as intended.


8. Write a SQL query that finds all films whose director has the first name `John`.

  **Output**
  ```plaintext
   id |   title    | year | genre  |        director         | duration
  ----+------------+------+--------+-------------------------+----------
    1 | Die Hard   | 1988 | action | John McTiernan          |      132
   12 | Home Alone | 1990 | comedy | John Wilden Hughes, Jr. |      102
   13 | Hairspray  | 1988 | comedy | John Waters             |       92
  (3 rows)
  ```

  My answer:
  ```sql
  SELECT * FROM films WHERE director LIKE 'John%';
  ```

  Solution:
  ```sql
  SELECT * FROM films WHERE director LIKE 'John %';
  ``` 

  REVIEW:
  My answer could result in rows whose first name is not John. E.g. `Johnson ...` will also be a match.
  The space is important.


9. Write a SQL query that will return the following data:

  ```plaintext
     genre   | count
  -----------+-------
   scifi     |     5
   comedy    |     4
   drama     |     2
   espionage |     2
   crime     |     1
   thriller  |     1
   horror    |     1
   action    |     1
  (8 rows)
  ```

  My answer:
  ```sql
  SELECT genre, count(id)
    FROM films
    GROUP BY genre
    ORDER BY count DESC;
  ```

  Solution:
  ```sql
  SELECT genre, count(films.id) FROM films GROUP BY genre ORDER BY count DESC;
  ```


10. Write a SQL query that will return the following data:

  ```plaintext
   decade |   genre   |                  films
  --------+-----------+------------------------------------------
     1940 | drama     | Casablanca
     1950 | drama     | 12 Angry Men
     1950 | scifi     | 1984
     1970 | crime     | The Godfather
     1970 | thriller  | The Conversation
     1980 | action    | Die Hard
     1980 | comedy    | Hairspray
     1990 | comedy    | Home Alone, The Birdcage, Wayne's World
     1990 | scifi     | Godzilla
     2000 | espionage | Bourne Identity
     2000 | horror    | 28 Days Later
     2010 | espionage | Tinker Tailor Soldier Spy
     2010 | scifi     | Midnight Special, Interstellar, Godzilla
  (13 rows)
  ```

  My answer:
  ```sql
   SELECT year / 10 * 10 AS decade, genre, STRING_AGG(title, ', ') AS films
     FROM films
     GROUP BY decade, genre
     ORDER BY decade ASC genre ASC;
  ```

  Solution:
  ```sql
  SELECT year / 10 * 10 AS decade, genre, string_agg(title, ', ') AS films
  FROM films GROUP BY decade, genre ORDER BY decade, genre;
  ```


11. Write a SQL query that will return the following data:

  ```plaintext
     genre   | total_duration
  -----------+----------------
   horror    |            113
   thriller  |            113
   action    |            132
   crime     |            175
   drama     |            198
   espionage |            245
   comedy    |            407
   scifi     |            632
  (8 rows)
  ```

  My answer:
  ```sql
  SELECT genre, SUM(duration) AS total_duration
    FROM films
    GROUP BY genre
    ORDER BY total_duration, genre;
  ```

  Solution:
  ```sql
  SELECT genre, sum(duration) AS total_duration
    FROM films GROUP BY genre ORDER BY total_duration, genre ASC;
  ```
 
