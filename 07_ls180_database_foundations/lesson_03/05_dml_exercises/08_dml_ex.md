## Oldest Device

Insert one more device into the devices table. You may use this SQL statement or create your own.

```sql
INSERT INTO devices (name) VALUES ('Magnetometer');
INSERT INTO parts (part_number, device_id) VALUES (42, 3);
```

Assuming nothing about the existing order of the records in the database, write an SQL statement that will return the name of the oldest device from our devices table.


My answer:
```sql
SELECT name
  FROM devices
  ORDER BY created_at ASC
  LIMIT 1;
```


**Approach/Algorithm**

To solve this exercise, you will need to use `ORDER BY` and you'll have to use a `LIMIT` clause. You can find more information on `LIMIT` [here](https://launchschool.com/books/sql/read/more_on_select#limitoffset).

**Solution**
```sql
SELECT name AS oldest_device
 FROM devices
ORDER BY created_at ASC
LIMIT 1;
```

**Discussion**

To solve this exercise, we must query all devices by `name`, and we need to order that query by when each device was created. To do that we use an `ORDER BY` clause with attribute `created_at`.

Remember: we are assuming that we don't know the order in which these devices were added to our devices. We also cannot assume a direct correlation between when a device is inserted and its creation date, since it is possible to use a non-default value for `created_at`.

With that in mind, we must set an order for our query. Finally, we must also specify that we want only one item back using the clause `LIMIT 1`. Since we are ordering our table in ascending order by creation date, the first item will end up being the oldest as well.


