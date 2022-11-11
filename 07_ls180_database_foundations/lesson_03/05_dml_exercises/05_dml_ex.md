## Aggregate Functions

Write an SQL query that returns a result table with the name of each device in our database together with the number of parts for that device.

```sql
SELECT name, COUNT(part_number) AS num_parts
  FROM devices
  INNER JOIN parts ON devices.id = parts.device_id
  GROUP BY name;
```


**Approach/Algorithm**

You'll need an aggregate function to solve this problem. You'll also need access to both tables. Keep this in mind when deciding on how to write your SQL query.

**Solution**
```sql
SELECT devices.name, COUNT(parts.device_id) FROM devices
LEFT OUTER JOIN parts ON devices.id = parts.device_id GROUP BY devices.name;
```

**Discussion**

The key to solving this exercise is to use the `COUNT()` function to get the number of parts for each device. We select the `name` for each device along with the parts count for the device. We use the attribute `device_id` from the parts table to count the parts for each device.

It's also important to have access to both tables, `parts` and `devices`. We use a `LEFT OUTER JOIN` in case the devices table contains a device that has no parts. Lastly, we must include a `GROUP BY` clause so we can associate the count of parts with their respective devices.
