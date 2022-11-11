## UPDATE device_id

We've realized that the last two parts we're using for device number 2, "Gyroscope", actually belong to an "Accelerometer". Write an SQL statement that will associate the last two parts from our parts table with an "Accelerometer" instead of a "Gyroscope".


My answer:
```sql
UPDATE parts SET device_id = 1 WHERE id = 7;
UPDATE parts SET device_id = 1 WHERE id = 8;
```


**Solution**
```sql
UPDATE parts SET device_id = 1
WHERE part_number=37 OR part_number=39;
```

**Discussion**
To accomplish this task, we want to `UPDATE` our `parts` table. So, we'll use an update statement. We want to make sure we don't change all of the parts, so we also have to include a `WHERE` clause that restricts the rows that will be modified to just those we want to modify. We happen to know the `part_number` of the last two parts in our database, so we'll use them here by specifying `WHERE part_number=37 OR part_number=39`. We can then apply the update to just those parts.


**Further Exploration**

What if we wanted to set the part with the smallest part_number to be associated with "Gyroscope"? How would we go about doing that? 


My answer:
```sql
UPDATE parts SET device_id = 2
  WHERE part_number = (SELECT part_number FROM parts ORDER BY part_number LIMIT 1);
```


**Other Answers:**
This works even if you don't know the part numbers you want to change:

```sql
UPDATE parts 
SET device_id = 1
WHERE part_number IN (
  SELECT part_number
  FROM parts 
  WHERE device_id = 2
  ORDER BY part_number DESC
  LIMIT 2
);
```

This assumes that "last two parts" means the two parts with the highest numbers. If it means the "last two parts entered," we can simply order by `created_at` instead. (Edit: well, we could if there were a `created_at` column in the table! If we need to report on parts by age in any sort of way, the best way to do that is include a timestamp in the table.) If we want the two parts with the lowest numbers, we can remove the `DESC` in the `ORDER BY` clause.

**Further exploration**

`MIN` works fine, if you are only dealing with one possible record and only the smallest one, but using `ORDER BY` with `LIMIT` and (if necessary) `OFFSET` gives more flexibility than `MIN`. So this works just as well:

```sql
UPDATE parts 
SET device_id = 1
WHERE part_number IN (
  SELECT part_number
  FROM parts 
  ORDER BY part_number
  LIMIT 1
);
```

Basically, any version of top, bottom, highest, lowest and so on can be handled by some variation of this approach. Since `MIN` and `MAX` only deal with single cases, one could argue that using some combination of `ORDER BY`, `LIMIT` and `OFFSET` represents a more consistent and comprehensive solution to problems of this type.

