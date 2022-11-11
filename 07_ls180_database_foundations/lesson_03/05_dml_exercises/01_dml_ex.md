## Set Up Database

For this set of exercises we'll want to create a new database and some tables to work with. The theme for the exercise is that of a workshop. Create a database to store information and tables related to this workshop.

One table should be called `devices`. This table should have columns that meet the following specifications:

    Includes a primary key called `id` that is auto-incrementing.
    A column called `name`, that can contain a String. It cannot be `NULL`.
    A column called `created_at` that lists the date this device was created. It should be of type `timestamp` and it should also have a default value related to when a device is created.

In the workshop, we have several devices, and each device should have many different parts. These parts are unique to each device, so one device can have various parts, but those parts won't be used in any other device. Make a table called `parts` that reflects the information listed above. Table `parts` should have the following columns that meet the following specifications:

    An `id` which auto-increments and acts as the primary key
    A `part_number`. This column should be unique and not null.
    A foreign key column called `device_id`. This will be used to associate various parts with a device.


My answer:
```terminal
createdb workshop
psql -d workshop
```

```sql
CREATE TABLE devices (
  id integer GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  name text NOT NULL,
  created_at timestamp DEFAULT now()
);
```

```sql
CREATE TABLE parts (
  id integer GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  part_number integer UNIQUE NOT NULL,
  device_id integer REFERENCES devices(id)
);


**Solution**

```sql
-- Create our workshop database
CREATE DATABASE workshop;

-- Make workshop the current database
\c workshop

-- Create a devices table
CREATE TABLE devices (
  id serial PRIMARY KEY,
  name text NOT NULL,
  created_at timestamp DEFAULT CURRENT_TIMESTAMP
);

-- Create a parts table
CREATE TABLE parts (
  id serial PRIMARY KEY,
  part_number integer UNIQUE NOT NULL,
  device_id integer REFERENCES devices (id)
);
```

**Discussion**

For this exercise, we'll use the SQL command `CREATE DATABASE` workshop. Since we are dealing with workshop related data, we'll go with "workshop" as the name of this database. We must also remember to connect to the database with the `\c workshop` psql console command. We don't have to use this command: you can also use the wrapper function `createdb` as a terminal command.

Next, let's create the `devices` table. First, let's deal with the primary key. By now, we know that this should be of type `serial`, and that this will auto-increment. We also make sure to use a `PRIMARY KEY` constraint in the table definition. This ensures that any ids must be `UNIQUE` and `NOT NULL`.

Next, we want a column that can hold a String. The easiest way to accomplish this is to use type `text`, which will allow for a String of any size to be inserted into this field. This column should never be `NULL` so we have to add a `NOT NULL` constraint after the column type.

Finally, we get to the `created_at` column. The directions specify that it should be of type `timestamp`, so we go ahead and write that in. It should also default to the time of creation for this particular device. To accomplish this we can set a `DEFAULT` constraint: if no value is entered, a default value of the current time is used. We get this by using either `NOW()` or its alias `CURRENT_TIMESTAMP`. Either one will work.

Finally, we set up the `parts` table. Just as we did before, we use type `serial` and specify a `PRIMARY KEY` constraint for our `id` column. For `part_number`, we'll use the data type `integer`.

Lastly, we need a way to associate our device parts with their devices. To do that, we use a foreign key, a unique identifier specifically created just for this purpose. We set our foreign key, `device_id` to be of type `integer` and then use the `REFERENCES` keyword to specify which column we wish to reference. In this case we want a part to be associated with a device, so we reference the `id` column on the `devices` table.
