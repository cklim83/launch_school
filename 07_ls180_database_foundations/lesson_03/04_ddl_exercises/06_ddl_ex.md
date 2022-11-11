## Enumerated Types

In the previous exercise, we added a `CHECK` constraint to the `stars` table to enforce that the value stored in the `spectral_type` column for each row is valid. In this exercise, we will use an alternate approach to the same problem.

PostgreSQL provides what is called an enumerated data type; that is, a data type that must have one of a finite set of values. For instance, a traffic light can be red, green, or yellow: these are enumerate values for the color of the currently lit signal light.

Modify the `stars` table to remove the `CHECK` constraint on the `spectral_type` column, and then modify the `spectral_type` column so it becomes an enumerated type that restricts it to one of the following 7 values: `'O'`, `'B'`, `'A'`, `'F'`, `'G'`, `'K'`, and `'M'`.


My answer:
```sql
-- DROP the previous constraint, else we cannot change the type below
ALTER TABLE stars DROP CONSTRAINT stars_spectral_type_check;
ALTER TABLE

-- Create the ENUM type, then alter the type for column spectral_type
CREATE TYPE spectral AS ENUM ('O', 'B', 'A', 'F', 'G', 'K', 'M');
ALTER TABLE stars
  ALTER spectral_type TYPE spectral USING (spectral_type::spectral);
ALTER TABLE

-- test with invalid spectral_type
INSERT INTO stars (name, distance, spectral_type, companions)
  VALUES('test', 475.23, 'Z', 3);
ERROR:  invalid input value for enum spectral: "Z"
LINE 2:   VALUES('test', 475.23, 'Z', 3);

-- test with valid spectral_type
INSERT INTO stars (name, distance, spectral_type, companions)
  VALUES('test', 475.23, 'B', 3);
INSERT 0 1
```


**Approach/Algorithm**

You can find information on enumerated types at this URL:

[https://www.postgresql.org/docs/9.5/static/datatype-enum.html]

Replace 9.5 with the version of PostgreSQL you are using.

**Solution**
```sql
ALTER TABLE stars
DROP CONSTRAINT stars_spectral_type_check;

CREATE TYPE spectral_type_enum AS ENUM ('O', 'B', 'A', 'F', 'G', 'K', 'M');

ALTER TABLE stars
ALTER COLUMN spectral_type TYPE spectral_type_enum
                           USING spectral_type::spectral_type_enum;
```

**Discussion**

We start out by first dropping the `CHECK` constraint from the table. To do this, we need to know the constraint name, which can be found by displaying the schema for the table: the constraint name is listed in the section on Check constraints below the list of columns.

Next, we need to create an enumerated type, which we will call `spectral_type_enum`; the type is restricted to the values in the list in the `AS ENUM` clause.

Finally, we change the type of the `spectral_type` column to `spectral_type_enum`. On our first attempt to do this, we omitted the `USING` clause, and received an error message:

```sql
ERROR:  column "spectral_type" cannot be cast automatically to type spectral_type_enum
HINT:  You might need to specify "USING spectral_type::spectral_type_enum".
```

Fortunately, the hint part of that message was just what we needed -- we added the `USING` clause, and the column data type change worked. The reason for this `USING` clause is that there is no defined way in PostgreSQL to convert char values to an enumerated type: the `USING` clause tells PostgreSQL to simply use the existing values from spectral_type as though they are the enumerated values.


REVIEW:
- Note: If the existing spectral type constraint `"stars_spectral_type_check" CHECK (spectral_type = ANY (ARRAY['O'::bpchar, 'B'::bpchar, 'A'::bpchar, 'F'::bpchar, 'G'::bpchar, 'K'::bpchar, 'M'::bpchar]))` is not removed, trying to alter the column type will lead to the following error:

```sql
ALTER TABLE stars
  ALTER spectral_type TYPE spectral USING (spectral_type::spectral);
ERROR:  operator does not exist: spectral = character
HINT:  No operator matches the given name and argument types. You might need to add explicit type casts.
```

