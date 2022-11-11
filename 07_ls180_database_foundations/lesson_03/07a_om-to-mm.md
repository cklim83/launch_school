## Convert One-to-Many to Many-to-Many

1. Import this [file](07b_films.sql) into a database using psql.

My answer:
```terminal
createdb om-to-mm
psql -d om-to-mm < 07b_films.sql
```

**Solution**
```terminal
$ createdb om-to-mm
$ psql -d om-to-mm < films7.sql
```


2. Write the SQL statement needed to create a join table that will allow a film to have multiple directors, and directors to have multiple films. Include an id column in this table, and add foreign key constraints to the other columns.

My answer:
```sql
CREATE TABLE directors_films (
  id integer GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  director_id integer NOT NULL REFERENCES directors(id),
  film_id integer NOT NULL REFERENCES films(id)
);

ALTER TABLE directors_films
  ADD UNIQUE (director_id, film_id);
```

**Solution**
```sql
CREATE TABLE directors_films (
  id serial PRIMARY KEY,
  director_id integer REFERENCES directors (id),
  film_id integer REFERENCES films (id)
);
```

Notice that the table above is named `directors_films` and not `films_directors`. The convention for naming tables in SQL is to use alphabetical order when the table name consists of more than one word.


3. Write the SQL statements needed to insert data into the new join table to represent the existing one-to-many relationships.

My answer:
```sql
INSERT INTO directors_films (director_id, film_id)
  VALUES (1, 1),
         (2, 2),
         (3, 3),
         (4, 4),
         (5, 5),
         (6, 6),
         (3, 7),
         (7, 8),
         (8, 9),
         (4, 10);
```

**Solution**
```sql
INSERT INTO directors_films (film_id, director_id) VALUES (1, 1);
INSERT INTO directors_films (film_id, director_id) VALUES (2, 2);
INSERT INTO directors_films (film_id, director_id) VALUES (3, 3);
INSERT INTO directors_films (film_id, director_id) VALUES (4, 4);
INSERT INTO directors_films (film_id, director_id) VALUES (5, 5);
INSERT INTO directors_films (film_id, director_id) VALUES (6, 6);
INSERT INTO directors_films (film_id, director_id) VALUES (7, 3);
INSERT INTO directors_films (film_id, director_id) VALUES (8, 7);
INSERT INTO directors_films (film_id, director_id) VALUES (9, 8);
INSERT INTO directors_films (film_id, director_id) VALUES (10, 4);
```

There is a shorter way to accomplish the same thing by using `SELECT` within an `INSERT` statement. Be careful though since using `SELECT` within an `INSERT` statement can be tricky. You can read more about this technique [here](http://www.chesnok.com/daily/2013/11/19/everyday-postgres-insert-with-select/comment-page-1/).


4. Write a SQL statement to remove any unneeded columns from `films`.

My answer
```sql
ALTER TABLE films
  DROP COLUMN director_id;
```

**Solution**
```sql
ALTER TABLE films DROP COLUMN director_id;
```


5. Write a SQL statement that will return the following result:

```plaintext
           title           |         name
---------------------------+----------------------
 12 Angry Men              | Sidney Lumet
 1984                      | Michael Anderson
 Casablanca                | Michael Curtiz
 Die Hard                  | John McTiernan
 Let the Right One In      | Michael Anderson
 The Birdcage              | Mike Nichols
 The Conversation          | Francis Ford Coppola
 The Godfather             | Francis Ford Coppola
 Tinker Tailor Soldier Spy | Tomas Alfredson
 Wayne's World             | Penelope Spheeris
(10 rows)
```

My answer:
```sql
SELECT f.title, d.name
  FROM films AS f
    INNER JOIN directors_films AS df ON f.id = df.film_id
    INNER JOIN directors AS d ON df.director_id = d.id
  ORDER BY f.title;
```

**Solution**
```sql
SELECT films.title, directors.name
  FROM films
    INNER JOIN directors_films ON directors_films.film_id = films.id
    INNER JOIN directors ON directors.id = directors_films.director_id
  ORDER BY films.title ASC;
```


6. Write SQL statements to insert data for the following films into the database:

| Film | Year | Genre | Duration | Directors |
| --- | --- | --- | --- | --- |
| Fargo | 1996 | comedy | 98 | Joel Coen |
| No Country for Old Men | 2007 | western | 122 | Joel Coen, Ethan Coen |
| Sin City | 2005 | crime | 124 | Frank Miller, Robert Rodriguez |
| Spy Kids | 2001 | scifi | 88 | Robert Rodriguez | 

My answer:
```sql
INSERT INTO films (title, year, genre, duration)
  VALUES ('Fargo', 1996, 'comedy', 98),
         ('No Country for Old Men', 2007, 'western', 122),
         ('Sin City', 2005, 'crime', 124),
         ('Spy Kids', 2001, 'scifi', 88);

INSERT INTO directors (name)
  VALUES ('Joel Coen'),
         ('Ethan Coen'),
         ('Frank Miller'),
         ('Robert Rodriguez');

INSERT INTO directors_films (director_id, film_id) (
  SELECT directors.id, films.id
    FROM films
      CROSS JOIN directors
    WHERE films.title = 'Fargo' AND directors.name IN ('Joel Coen')
);

INSERT INTO directors_films (director_id, film_id) (
  SELECT directors.id, films.id                                                           FROM films                                                                        
      CROSS JOIN directors                                                            
    WHERE films.title = 'No Country for Old Men' AND directors.name IN ('Joel Coen', 'Ethan Coen')
);

INSERT INTO directors_films (director_id, film_id) (
  SELECT directors.id, films.id                                                           FROM films
      CROSS JOIN directors
    WHERE films.title = 'Sin City' AND directors.name IN ('Frank Miller', 'Robert Rodriguez')
);

INSERT INTO directors_films (director_id, film_id) (     
  SELECT directors.id, films.id                                                           FROM films
      CROSS JOIN directors
    WHERE films.title = 'Spy Kids' AND directors.name IN ('Robert Rodriguez')
);
```

**Solution**
```sql
INSERT INTO films (title, year, genre, duration) VALUES ('Fargo', 1996, 'comedy', 98);
INSERT INTO directors (name) VALUES ('Joel Coen');
INSERT INTO directors (name) VALUES ('Ethan Coen');
INSERT INTO directors_films (director_id, film_id) VALUES (9, 11);

INSERT INTO films (title, year, genre, duration) VALUES ('No Country for Old Men', 2007, 'western', 122);
INSERT INTO directors_films (director_id, film_id) VALUES (9, 12);
INSERT INTO directors_films (director_id, film_id) VALUES (10, 12);

INSERT INTO films (title, year, genre, duration) VALUES ('Sin City', 2005, 'crime', 124);
INSERT INTO directors (name) VALUES ('Frank Miller');
INSERT INTO directors (name) VALUES ('Robert Rodriguez');
INSERT INTO directors_films (director_id, film_id) VALUES (11, 13);
INSERT INTO directors_films (director_id, film_id) VALUES (12, 13);

INSERT INTO films (title, year, genre, duration) VALUES ('Spy Kids', 2001, 'scifi', 88) RETURNING id;
INSERT INTO directors_films (director_id, film_id) VALUES (12, 14);
```

You can verify the data is entered correctly by running the statement from #5 again. You should get the following result:

```plaintext
           title           |         name
---------------------------+----------------------
 12 Angry Men              | Sidney Lumet
 1984                      | Michael Anderson
 Casablanca                | Michael Curtiz
 Die Hard                  | John McTiernan
 Fargo                     | Joel Coen
 Let the Right One In      | Michael Anderson
 No Country for Old Men    | Joel Coen
 No Country for Old Men    | Ethan Coen
 Sin City                  | Robert Rodriguez
 Sin City                  | Frank Miller
 Spy Kids                  | Robert Rodriguez
 The Birdcage              | Mike Nichols
 The Conversation          | Francis Ford Coppola
 The Godfather             | Francis Ford Coppola
 Tinker Tailor Soldier Spy | Tomas Alfredson
 Wayne's World             | Penelope Spheeris
(16 rows)
```

You might have slightly different ordering of the data in the name column as that column was not used in the ORDER BY clause.


7. Write a SQL statement that determines how many films each director in the database has directed. Sort the results by number of films (greatest first) and then name (in alphabetical order).

**Expected Result**
```plaintext
       director       | films
----------------------+-------
 Francis Ford Coppola |     2
 Joel Coen            |     2
 Michael Anderson     |     2
 Robert Rodriguez     |     2
 Ethan Coen           |     1
 Frank Miller         |     1
 John McTiernan       |     1
 Michael Curtiz       |     1
 Mike Nichols         |     1
 Penelope Spheeris    |     1
 Sidney Lumet         |     1
 Tomas Alfredson      |     1
(12 rows)
```
You may assume that every director has at least one film.

My answer:
```sql
SELECT directors.name AS director, COUNT(films.id) AS films
  FROM directors 
    LEFT JOIN directors_films ON directors.id = directors_films.director_id
    LEFT JOIN films ON directors_films.film_id = films.id
  GROUP BY director
  ORDER BY films DESC, director ASC;
```

**Solution**
```sql
SELECT directors.name AS director, COUNT(directors_films.film_id) AS films
  FROM directors
    INNER JOIN directors_films ON directors.id = directors_films.director_id
  GROUP BY directors.id
  ORDER BY films DESC, directors.name ASC;
```
