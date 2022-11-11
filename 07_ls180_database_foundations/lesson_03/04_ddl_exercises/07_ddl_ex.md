## Planetary Mass Precision

We will measure Planetary masses in terms of the mass of Jupiter. As such, the current data type of integer is inappropriate; it is only really useful for planets as large as Jupiter or larger. These days, we know of many extrasolar planets that are smaller than Jupiter, so we need to be able to record fractional parts for the mass. Modify the mass column in the planets table so that it allows fractional masses to any degree of precision required. In addition, make sure the mass is required and positive.

While we're at it, also make the designation column required.


My answer:
```sql
ALTER TABLE planets
  ALTER mass TYPE numeric,
  ALTER mass SET NOT NULL,
  ADD CHECK(mass > 0),
  ALTER designation SET NOT NULL;
```


**Solution**

```sql
ALTER TABLE planets
ALTER COLUMN mass TYPE numeric,
ALTER COLUMN mass SET NOT NULL,
ADD CHECK (mass > 0.0),
ALTER COLUMN designation SET NOT NULL;
```

**Discussion**

As mentioned in an earlier exercise, there are several different data types we can use to store a number with a fractional component. For this problem, we have again chosen `numeric` because it allows numbers of arbitrary size and precision.

Our solution also uses the shorthand notation for combining several alterations in one `ALTER TABLE` statement. Note in particular that the addition of a `CHECK` constraint is a table-level operation: we add the `CHECK` to the table rather than the mass column.


REVIEW
- `CHECK`, `UNIQUE`, `PRIMARY KEY`, `FOREIGN KEY` are table level constraints
so they are preceded by `ADD`
- Column level constraints such as SET NOT NULL are preceded by ALTER [COLUMN] colname ...
