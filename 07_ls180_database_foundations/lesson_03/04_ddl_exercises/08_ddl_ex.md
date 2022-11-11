## Add a Semi-Major Axis Column

Add a `semi_major_axis` column for the semi-major axis of each planet's orbit; the semi-major axis is the average distance from the planet's star as measured in astronomical units (1 AU is the average distance of the Earth from the Sun). Use a data type of `numeric`, and require that each planet have a value for the `semi_major_axis`.

My answer:
```sql
ALTER TABLE planets
  ADD COLUMN semi_major_axis numeric NOT NULL;
```


**Solution**
```sql
ALTER TABLE planets
ADD COLUMN semi_major_axis numeric NOT NULL;
```

**Discussion**

Our solution simply uses the `ADD COLUMN` clause of the `ALTER TABLE` statement to add a numeric column named `semi_major_axis` whose value must be specified.


**Further Exploration**

Assume the planets table already contains one or more rows of data. What will happen when you try to run the above command? What will you need to do differently to obtain the desired result? To test this, delete the `semi_major_axis` column and then add a row or two of data (note: your `stars` table will also need some data that corresponds to the `star_id` values):

```sql
ALTER TABLE planets
DROP COLUMN semi_major_axis;

DELETE FROM stars;
INSERT INTO stars (name, distance, spectral_type, companions)
           VALUES ('Alpha Centauri B', 4.37, 'K', 3);
INSERT INTO stars (name, distance, spectral_type, companions)
           VALUES ('Epsilon Eridani', 10.5, 'K', 0);

INSERT INTO planets (designation, mass, star_id)
           VALUES ('b', 0.0036, 1); -- check star_id; see note below
INSERT INTO planets (designation, mass, star_id)
           VALUES ('c', 0.1, 2); -- check star_id; see note below

ALTER TABLE planets
ADD COLUMN semi_major_axis numeric NOT NULL;
```

NOTE: The `semi_major_axis` for Alpha Centauri B planet b is 0.04 AU while that for Epsilon Eridani planet c is about 40 AU. Note also that the `star_id` values shown above may be different from what is in your database. Check your `stars` table to see which `star_id` values to use.


My answer:
If there are existing data in `planets`, we can only add the `semi_major_axis`
column without the `NOT NULL` constraint. Once the column is created, we can
then update the values of this column, before we add the NOT NULL constraint.
