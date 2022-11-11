
Stellar Distance Precision

For many of the closest stars, we know the distance from Earth fairly accurately; for instance, Proxima Centauri is roughly 4.3 light years away. Our database, as currently defined, only allows integer distances, so the most accurate value we can enter is 4. Modify the distance column in the stars table so that it allows fractional light years to any degree of precision required.


My answer:
```sql
ALTER TABLE stars
  ALTER distance TYPE numeric
```

[`numeric`](https://www.postgresql.org/docs/current/datatype-numeric.html#DATATYPE-NUMERIC-DECIMAL) without any precision or scale creates an unconstrained numeric column in which numeric values of any length can be stored, up till implementation limits.


**Solution**
```sql
ALTER TABLE stars
ALTER COLUMN distance TYPE numeric;
```

**Discussion**

There are several different data types we can use to store a number with a fractional component: `numeric` (also known as `decimal`), `real`, and `double precision`. For this problem, we have simply chosen `numeric` because it allows numbers of arbitrary size and precision. We could have easily chosen `real` or `double precision` as well, but those types are mostly intended for use in applications that perform a lot of mathematical processing.

The main thing to understand with our solution is that we have chosen type `numeric` without a precision or scale. The precision and scale are optional characteristics that may be specified when creating a `numeric` column; if they are omitted, PostgreSQL allows values that have any precision or scale.


**Further Exploration**

Assume the `stars` table already contains one or more rows of data. What will happen when you try to run the above command? To test this, revert the modification and add a row or two of data:

```sql
ALTER TABLE stars
ALTER COLUMN distance TYPE integer;

INSERT INTO stars (name, distance, spectral_type, companions)
           VALUES ('Alpha Orionis', 643, 'M', 9);

ALTER TABLE stars
ALTER COLUMN distance TYPE numeric ;
```

My answer:
Changing from INTEGER to NUMERIC will not cause any error since INTEGER is just a NUMERIC of scale 0. Changing from NUMERIC to INTEGER will however result in truncation and loss of fractional parts of data. 
