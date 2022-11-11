## Delete Accelerometer

Our workshop has decided to not make an Accelerometer after all. Delete any data related to "Accelerometer", this includes the parts associated with an Accelerometer.


My answer:
```sql
-- Change the foreign key constraint to cascade deletion in primary table
ALTER TABLE parts DROP CONSTRAINT parts_device_id_fkey;
ALTER TABLE parts ADD FOREIGN KEY (device_id) REFERENCES devices(id) ON DELETE CASCADE;

DELETE FROM devices WHERE name = 'Accelerometer';


-- One time data scrubbing all parts without associated device.ids
DELETE
  FROM parts 
  WHERE NOT EXISTS (
    SELECT * 
      FROM devices
      WHERE devices.id = parts.device_id
  );
```


**Approach/Algorithm**

Check the documentation for `DELETE`; it should prove useful. This exercise can be solved with two SQL statements, but the ordering is important; be sure to keep that in mind.

**Solution**
```sql
DELETE FROM parts WHERE device_id = 1;
DELETE FROM devices WHERE name = 'Accelerometer';
```

**Discussion**

For this exercise, we have to use the SQL statement `DELETE`. We specify the table we wish to delete from, and then use a `WHERE` clause to pick a particular row to delete based on some condition.

What if we tried to run those two SQL statement above in reverse order?
```sql
DELETE FROM devices WHERE name = 'Accelerometer';
DELETE FROM parts WHERE device_id = 1;
```

Let's see here..
```plaintext
ERROR:  update or delete on table "devices" violates foreign key constraint "parts_device_id_fkey" on table "parts"
DETAIL:  Key (id)=(1) is still referenced from table "parts".
```

First we have to delete all the parts associated with the Accelerometer, then we can delete the Accelerometer itself from the database. If we try to do this the other way around, we'll get an error because we'll have parts that try to reference a non-existent device. Switch the order and there you have it. Our Accelerometer and all its associated parts have been deleted from the database.

**Further Exploration**

This process may have been a bit simpler if we had initially defined our devices tables a bit differently. We could delete both a device and its associated parts with one SQL statement if that were the case. What change would have to be made to table parts to make this possible? Also, what SQL statement would you have to write that can delete both a device and its parts all in one go?

See my first answer above on altering foreign key constraint to cascade on delete.


**Another answer:**
Further exploration

I had already set up the parts table with ON DELETE CASCADE, so all I had to do was this:

```sql
DELETE FROM devices WHERE name = 'Accelerometer';
```

I created the parts table like this:
```sql
CREATE TABLE parts (
  id serial PRIMARY KEY,
  part_number integer UNIQUE NOT NULL,
  device_id integer REFERENCES devices(id) ON DELETE CASCADE
);
```

To add cascading deletes after the fact, you have to first drop the existing foreign key constraint (to get the name of the constraint, you can do \d parts):

```sql
ALTER TABLE parts 
  DROP CONSTRAINT parts_device_id_fkey;
```

And then, add it in again with `ON DELETE CASCADE` specified:
```sql
ALTER TABLE parts 
  ADD FOREIGN KEY (device_id) REFERENCES device(id) ON DELETE CASCADE;
```

You can merge these two into one ALTER TABLE statement:
```sql
ALTER TABLE parts 
  DROP CONSTRAINT parts_device_id_fkey,
  ADD FOREIGN KEY (device_id) REFERENCES device(id) ON DELETE CASCADE;
```

Several others have basically explained the same thing. However, there's one thing I don't see mentioned below: when adding a constraint, you only need to use the `ADD CONSTRAINT` sub-clause if you want to give your own name to a constraint. If you don't want to do that, you can leave it out as I have here and PSQL will assign a default name to it. I think it's generally preferable to do that; figuring out what constraint name somebody has given to a constraint could add to maintenance overhead.

