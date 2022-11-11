## ORDER BY

In the previous exercise, we had to use a `GROUP BY` clause to obtain the expected output. In that exercise, we used an SQL query like:

```sql
SELECT devices.name AS name, COUNT(parts.device_id)
FROM devices
JOIN parts ON devices.id = parts.device_id
GROUP BY devices.name;
```

Now, we want to work with the same query, but we want to guarantee that the devices and the count of their parts are listed in descending alphabetical order. Alter the SQL query above so that we get a result table that looks like the following.

```plaintext
name          | count
--------------+-------
Gyroscope     |     5
Accelerometer |     3
(2 rows)
```


My answer:
```sql
SELECT devices.name AS name, COUNT(parts.device_id)
  FROM devices
  JOIN parts ON devices.id = parts.device_id
  GROUP BY name
  ORDER BY COUNT DESC;
```


**Solution**
```sql
SELECT devices.name AS name, COUNT(parts.device_id)
FROM devices
JOIN parts ON devices.id = parts.device_id
GROUP BY devices.name
ORDER BY devices.name DESC;
```


**Discussion**
To ensure a specific order, we must add an `ORDER BY` clause. This clause orders our result table based on any column(s) we specify. In this case, we want it ordered in descending alphabetical sequence based on a device's name, so we use `ORDER BY devices.name DESC`. If we want it in ascending order, we would instead have to write, `ORDER BY devices.name ASC`.
