## Insert Data for Parts and Devices

Now that we have the infrastructure for our workshop set up, let's start adding in some data. Add in two different devices. One should be named, "Accelerometer". The other should be named, "Gyroscope".

The first device should have 3 parts (this is grossly simplified). The second device should have 5 parts. The part numbers may be any number between 1 and 10000. There should also be 3 parts that don't belong to any device yet.


My answer:
```sql
INSERT INTO devices (name)
  VALUES ('Accelerometer'), 
         ('Gyroscope');

INSERT INTO parts (part_number, device_id)
  VALUES (12, 1),
         (14, 1),
         (16, 1),
         (31, 2),
         (33, 2),
         (35, 2),
         (37, 2),
         (39, 2);

INSERT INTO parts (part_number)
  VALUES (50),
         (54),
         (58);
```


**Solution**

```sql
INSERT INTO devices (name) VALUES ('Accelerometer');
INSERT INTO devices (name) VALUES ('Gyroscope');

INSERT INTO parts (part_number, device_id) VALUES (12, 1);
INSERT INTO parts (part_number, device_id) VALUES (14, 1);
INSERT INTO parts (part_number, device_id) VALUES (16, 1);

INSERT INTO parts (part_number, device_id) VALUES (31, 2);
INSERT INTO parts (part_number, device_id) VALUES (33, 2);
INSERT INTO parts (part_number, device_id) VALUES (35, 2);
INSERT INTO parts (part_number, device_id) VALUES (37, 2);
INSERT INTO parts (part_number, device_id) VALUES (39, 2);

INSERT INTO parts (part_number) VALUES (50);
INSERT INTO parts (part_number) VALUES (54);
INSERT INTO parts (part_number) VALUES (58);
```

**Discussion**

The first set of insertions, for our `devices` table, are simple enough. We only need two insertions, each one holding the name we wish to add for these two records. The other two attributes, `id` and `created_at` will be generated for us.

After this we have to make two more sets of insertions into the database. 3 parts have to be recorded into the parts table, and these parts should be for our accelerometer. We make sure to associate these parts by setting the foreign key, `device_id` to equal the `id` of the device these parts belong to. The same is done for the 5 parts that are for our gyroscope. Finally, we insert 3 parts that aren't yet associated with a device.
