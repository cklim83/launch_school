## IS NULL and IS NOT NULL

Write two SQL queries:

    One that generates a listing of parts that currently belong to a device.
    One that generates a listing of parts that don't belong to a device.

Do not include the id column in your queries.

**Expected Output:**
```plaintext
part_number | device_id
------------+-----------
         12 |         1
         14 |         1
         16 |         1
         31 |         2
         33 |         2
         35 |         2
         37 |         2
         39 |         2
(8 rows)
```

```plaintext
part_number | device_id
------------+-----------
         50 |
         54 |
         58 |
(3 rows)
```


My answer:
```sql
-- parts associated with devices
SELECT part_number, device_id
  FROM parts
  WHERE device_id IS NOT NULL;

-- parts not associated with devices
SELECT part_number, device_id
  FROM parts
  WHERE device_id IS NULL;
```


**Approach/Algorithm**

If an column value is empty in a SQL table, it contains a `NULL` value.

**Solution**
```sql
-- Doesn't belong to a device
SELECT part_number, device_id FROM parts
WHERE device_id IS NULL;

-- Does belong to a device
SELECT part_number, device_id FROM parts
WHERE device_id IS NOT NULL;
```

**Discussion**

For this exercise, we need to utilize some special constructs for `WHERE`. These constructs are `IS NULL` and `IS NOT NULL`. We make sure to `SELECT` everything from parts except for the id column (as requested).
```
