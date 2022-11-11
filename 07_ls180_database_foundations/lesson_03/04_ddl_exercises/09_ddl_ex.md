## Add a Moons Table

Someday in the future, technology will allow us to start observing the moons of extrasolar planets. At that point, we're going to need a `moons` table in our `extrasolar` database. For this exercise, your task is to add that table to the database. The table should include the following data:

   `id`: a unique serial number that auto-increments and serves as a primary key for this table.
    `designation`: the designation of the moon. We will assume that moon designations will be numbers, with the first moon discovered for each planet being moon 1, the second moon being moon 2, etc. The designation is required.
    `semi_major_axis`: the average distance in kilometers from the planet when a moon is farthest from its corresponding planet. This field must be a number greater than 0, but is not required; it may take some time before we are able to measure moon-to-planet distances in extrasolar systems.
    `mass`: the mass of the moon measured in terms of Earth Moon masses. This field must be a numeric value greater than 0, but is not required.

Make sure you also specify any foreign keys necessary to tie each moon to other rows in the database.


My answer:
```sql
CREATE TABLE moons (
  id serial PRIMARY KEY,
  designation integer GENERATED ALWAYS AS IDENTITY,
  semi_major_axis numeric CHECK (semi_major_axis > 0.0),
  mass numeric CHECK(mass > 0.0),
  planet_id integer NOT NULL REFERENCES planets (id)
);
```


**Solution**
```sql
CREATE TABLE moons (
  id serial PRIMARY KEY,
  designation integer NOT NULL CHECK (designation > 0),
  semi_major_axis numeric CHECK (semi_major_axis > 0.0),
  mass numeric CHECK (mass > 0.0),
  planet_id integer NOT NULL REFERENCES planets (id)
);
```

**Discussion**

As mentioned in an earlier exercise, there are several different data types we can use to store a number with a fractional component. For this problem, we have again chosen `numeric` because it allows numbers of arbitrary size and precision.

The main item of note here is that we need a `planet_id` foreign key to tie the moons to their respective planets. We don't need a `star_id` foreign key -- that is already taken care of in the planets table.
