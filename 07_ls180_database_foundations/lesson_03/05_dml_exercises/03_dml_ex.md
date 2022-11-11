## INNER JOIN

Write an SQL query to display all devices along with all the parts that make them up. We only want to display the name of the `devices`. Its `parts` should only display the `part_number`.


**Expected output:**
```sql
     name      | part_number
---------------+-------------
 Accelerometer |          12
 Accelerometer |          14
 Accelerometer |          16
 Gyroscope     |          31
 Gyroscope     |          33
 Gyroscope     |          35
 Gyroscope     |          37
 Gyroscope     |          39
(8 rows)
```

NOTE: The part numbers and sequence may vary from those shown above.

My answer:
```sql
SELECT name, part_number
  FROM devices 
  INNER JOIN parts
  ON devices.id = parts.device_id;
```


**Approach/Algorithm**

You will need to use either a `JOIN` or a subquery to solve this exercise.

**Solution**
```sql
SELECT devices.name, parts.part_number FROM devices
INNER JOIN parts ON devices.id = parts.device_id;
```

**Discussion**

In this exercise, we have a situation where we want information from two different tables. This is a perfect opportunity to practice joining these two tables together to get the information we need.

The description for this exercise explicitly says that we only want the name from `devices` and the part number from `parts`, so we have to be sure to specify those items in the columns part of the `SELECT` clause, e.g.,

```sql
SELECT devices.name, parts.part_number
```

Since we are taking data from two different tables, we should specify which tables these two values come from. This isn't actually needed in this case since the column names are unique, but it doesn't hurt to use clear code in your queries.

To join the two tables together, we use an `INNER JOIN`. This only displays query matches where some condition is met. That condition is specified in the `ON` clause:

```sql
ON devices.id = parts.device_id
```

If that condition is met, then we join the relevant data from the two matching rows into one and add that to our result table.
