Check Values in List

The spectral_type column in the stars table is currently defined as a one-character string that contains one of the following 7 values: 'O', 'B', 'A', 'F', 'G', 'K', and 'M'. However, there is currently no enforcement on the values that may be entered. Add a constraint to the table stars that will enforce the requirement that a row must hold one of the 7 listed values above. Also, make sure that a value is required for this column.

My answer:
```sql
ALTER TABLE stars
  ADD CONSTRAINT check_spectral_type CHECK (spectral_type IN ('O', 'B', 'A', 'F', 'G', 'K', 'M')),
  ALTER spectral_type SET NOT NULL;
```


**Solution**
```sql
ALTER TABLE stars
ADD CHECK (spectral_type IN ('O', 'B', 'A', 'F', 'G', 'K', 'M')),
ALTER COLUMN spectral_type SET NOT NULL;
```

**Discussion**

To force `spectral_type` to only allow the 7 listed values, we need to add a `CHECK` constraint to the table that verifies `spectral_type` has one of those values. This is done with the `ADD CHECK` clause in our solution. We use the `IN` operator to ensure that `spectral_type` contains one of the 7 listed values.

We also add a `NOT NULL` constraint to the `spectral_type` column. In this case, we do this as part of the same `ALTER TABLE` statement we use to set the `CHECK` constraint for the column. This is accomplished by adding a comma after the `ADD CHECK` clause, and then adding an appropriate `ALTER COLUMN` clause. You could accomplish the same thing with two separate ALTER TABLE statements:

```sql
ALTER TABLE stars
ADD CHECK (spectral_type IN ('O', 'B', 'A', 'F', 'G', 'K', 'M'));

ALTER TABLE stars
ALTER COLUMN spectral_type SET NOT NULL;
```

**Further Exploration**

Assume the `stars` table contains one or more rows that are missing a `spectral_type value`, or that have an illegal value. What will happen when you try to alter the table schema? How would you go about adjusting the data to work around this problem. To test this, revert the modification and add some data:

```sql
ALTER TABLE stars
DROP CONSTRAINT stars_spectral_type_check,
ALTER COLUMN spectral_type DROP NOT NULL;

INSERT INTO stars (name, distance, companions)
           VALUES ('Epsilon Eridani', 10.5, 0);

INSERT INTO stars (name, distance, spectral_type, companions)
           VALUES ('Lacaille 9352', 10.68, 'X', 0);

ALTER TABLE stars
ADD CHECK (spectral_type IN ('O', 'B', 'A', 'F', 'G', 'K', 'M')),
ALTER COLUMN spectral_type SET NOT NULL;
```

My answer: 
If existing rows already contain a NULL/illegal value for spectral_type, we will
get an error when trying to imposing those constraints. To fix that, we can
either update the values to allowable values or simply delete those rows before
we change the schema.

```SQL
ALTER TABLE stars 
  ALTER spectral_type SET NOT NULL;
ERROR:  column "spectral_type" of relation "stars" contains null values

UPDATE stars SET spectral_type = 'A' WHERE name = 'Epsilon Eridani';
ALTER TABLE stars                                                         
  ALTER spectral_type SET NOT NULL;
ALTER TABLE


ALTER TABLE stars
  ADD CHECK (spectral_type IN ('O', 'B', 'A', 'F', 'G', 'K', 'M'));
ERROR:  check constraint "stars_spectral_type_check" of relation "stars" is violated by some row

UPDATE stars SET spectral_type = 'B' WHERE name = 'Lacaille 9352';
ALTER TABLE stars
  ADD CHECK (spectral_type IN ('O', 'B', 'A', 'F', 'G', 'K', 'M'));
ALTER TABLE
```
