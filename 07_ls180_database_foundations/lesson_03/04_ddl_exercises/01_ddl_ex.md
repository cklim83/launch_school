
Create an Extrasolar Planetary Database

For this exercise set, we will be working with the DDL statements to create and modify tables in a database that tracks planets around stars other than our Sun. To get started, first create a postgresql database named "extrasolar", and then create two tables in the database as follows:

stars table

    id: a unique serial number that auto-increments and serves as a primary key for this table.
    name: the name of the star,e,g., "Alpha Centauri A". Allow room for 25 characters. Must be unique and non-null.
    distance: the distance in light years from Earth. Define this as a whole number (e.g., 1, 2, 3, etc) that must be non-null and greater than 0.
    spectral_type: the spectral type of the star: O, B, A, F, G, K, and M. Use a one character string.
    companions: how many companion stars does the star have? A whole number will do. Must be non-null and non-negative.

planets table

    id: a unique serial number that auto-increments and serves as a primary key for this table.
    designation: a single alphabetic character that uniquely identifies the planet in its star system ('a', 'b', 'c', etc.)
    mass: estimated mass in terms of Jupiter masses; use an integer for this value.


My answer:
```sql
CREATE TABLE stars (
  id serial PRIMARY KEY,
  name VARCHAR(25) UNIQUE NOT NULL,
  distance INTEGER NOT NULL CHECK (distance > 0),
  spectral_type CHAR(1) CHECK (spectral_type IN ('O', 'B', 'A', 'F', 'G', 'K', 'M')),
  companions INTEGER NOT NULL CHECK (companions > 0)
);

CREATE TABLE planets (
  id SERIAL PRIMARY KEY,
  designation CHAR(1),
  mass INTEGER
);

```


Solution
```sql
CREATE DATABASE extrasolar;

\c extrasolar

CREATE TABLE stars (
  id serial PRIMARY KEY,
  name varchar(25) UNIQUE NOT NULL,
  distance integer NOT NULL CHECK (distance > 0),
  spectral_type char(1),
  companions integer NOT NULL CHECK (companions >= 0)
);

CREATE TABLE planets (
  id serial PRIMARY KEY,
  designation char(1) UNIQUE,
  mass integer
);
```

Discussion

We start by creating a database named extrasolar, then use the \c command to connect to that database. If we fail to use \c, we will create our tables in the wrong database.

Next we create the stars table using the criteria outlined in the problem description. Of particular interest here is the designation of id as being serial PRIMARY KEY, the CHECK (distance > 0) constraint for the distance column, and the CHECK (companions >= 0) constraint for the companions column.

Finally, we create the planets table, using the criteria described above.

This won't be the final version of our database schema: in the remaining exercises in this set, we will make a variety of adjustments to both tables to get practice with the DDL component of SQL.
