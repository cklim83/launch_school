## Set Up the Database using \copy

This set of exercises will focus on an `auction`. Create a new database called auction. In this database there will be three tables, `bidders`, `items`, and `bids`.

After creating the database, set up the 3 tables using the following specifications:

bidders
- `id` of type SERIAL: this should be a primary key
- `name` of type text: this should be `NOT NULL`

items
- `id` of type SERIAL: this should be a primary key
- `name` of type text: this should be NOT NULL
- `initial_price` and `sales_price`: These two columns should both be of type numeric. Each column should be able to hold a positive number as high as 1000 dollars with 2 decimal points of precision.
- The `initial_price` represents the starting price of an item when it is first put up for auction. This column should never be `NULL`.
- The `sales_price` represents the final price at which the item was sold. This column may be `NULL`, as it is possible to have an item that was never sold off.

bids
- `id` of type SERIAL: this should be a primary key
- `bidder_id`, `item_id`: These will be of type integer and should not be NULL. This table connects a bidder with an item and each row represents an individual bid. There should never be a row that has `bidder_id` or `item_id` unknown or `NULL`. Nor should there ever be a bid that references a nonexistent item or bidder. If the item or bidder associated with a bid is removed, that bid should also be removed from the database.
- Create your `bids` table so that both `bidder_id` and `item_id` together form a composite index for faster lookup.
- `amount` - The amount of money placed for each individual bid by a bidder. This column should be of the same type as `items.initial_price` and have the same constraints.

Finally, use the `\copy` meta-command to import the below files into your `auction` database. You'll have to create these files yourself before you can import them with `\copy`.


**bidders.csv**
```plaintext
id, name
1,Alison Walker
2,James Quinn
3,Taylor Williams
4,Alexis Jones
5,Gwen Miller
6,Alan Parker
7,Sam Carter
```

**items.csv**
```plaintext
id, name, initial_price, sales_price
1,Video Game, 39.99, 70.87
2,Outdoor Grill, 51.00, 83.25
3,Painting, 100.00, 250.00
4,Tent, 220.00, 300.00
5,Vase, 20.00, 42.00
6,Television, 550.00,
```

**bids.csv**
```plaintext
id, bidder_id, item_id, amount
1,1, 1, 40.00
2,3, 1, 52.00
3,1, 1, 53.00
4,3, 1, 70.87
5,5, 2, 83.25
6,2, 3, 110.00
7,4, 3, 140.00
8,2, 3, 150.00
9,6, 3, 175.00
10,4, 3, 185.00
11,2, 3, 200.00
12,6, 3, 225.00
13,4, 3, 250.00
14,1, 4, 222.00
15,2, 4, 262.00
16,1, 4, 290.00
17,1, 4, 300.00
18,2, 5, 21.72
19,6, 5, 23.00
20,2, 5, 25.00
21,6, 5, 30.00
22,2, 5, 32.00
23,6, 5, 33.00
24,2, 5, 38.00
25,6, 5, 40.00
26,2, 5, 42.00
```

If you are using AWS Cloud9, and running Postgres as the `postgres` user rather than the local user, you may see a message like the following when you try to run `\copy`:

```terminal
bidders.csv: No such file or directory
```
This will likely be because the `postgres` user doesn't have read permissions within the local environment. There's a couple of different ways you can fix this, but our suggestion is to run Postgres as the local user (which should have read permissions) rather than the `postgres` user. Refer back to this [section](https://launchschool.com/books/sql/read/preparations#installingpostgresql) of the Introduction to SQL book for more information about creating such a user if you haven't already done so.


My answer
```psql
CREATE DATABASE auction;
\c auction

CREATE TABLE bidders (
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL
);

CREATE TABLE items (
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  initial_price DECIMAL(6,2) NOT NULL CHECK (initial_price > 0.00),
  sales_price DECIMAL(6,2)
);

CREATE TABLE bids (
  id SERIAL PRIMARY KEY,
  bidder_id INTEGER REFERENCES bidders(id) ON DELETE CASCADE NOT NULL,
  item_id INTEGER REFERENCES items(id) ON DELETE CASCADE NOT NULL,
  amount DECIMAL(6,2) NOT NULL CHECK (amount > 0.00)
);

CREATE INDEX ON bids (bidder_id, item_id);
```

```psql
COPY bidders (id, name) 
FROM '/absolute/path/bidders.csv'
WITH CSV HEADER;

COPY items
FROM '/absolute/path/items.csv'
WITH CSV HEADER;

COPY bids
FROM '/absolute/path/bids.csv'
WITH CSV HEADER;
```

**Approach/Algorithm**
`psql` provides a useful command, `\copy` which allows you to import `csv` files. Read the [documentation](https://www.postgresql.org/docs/9.2/sql-copy.html) for `\copy` before proceeding with this exercise. Notice that the data files are of type csv and they have headers. Keep this in mind when deciding how to write the `\copy` command.

**Solution**

```terminal
createdb auction
```

```sql
CREATE TABLE bidders (
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL
);

CREATE TABLE items (
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  initial_price DECIMAL(6,2) NOT NULL CHECK(initial_price BETWEEN 0.01 AND 1000.00),
  sales_price DECIMAL(6,2) CHECK(sales_price BETWEEN 0.01 AND 1000.00)
);

CREATE TABLE bids (
  id SERIAL PRIMARY KEY,
  bidder_id integer NOT NULL REFERENCES bidders(id) ON DELETE CASCADE,
  item_id integer NOT NULL REFERENCES items(id) ON DELETE CASCADE,
  amount DECIMAL(6,2) NOT NULL CHECK(amount BETWEEN 0.01 AND 1000.00)
);

CREATE INDEX ON bids (bidder_id, item_id);
```

```psql
-- Copy data for bidders from the csv file to the bidders table
\copy bidders FROM 'bidders.csv' WITH HEADER CSV;

-- Copy data for items from the csv file to the items table
\copy items FROM 'items.csv' WITH HEADER CSV;

-- Copy data for bids from the csv file to the bids table
\copy bids FROM 'bids.csv' WITH HEADER CSV;
```

**Discussion**

The first steps are things we have done before, create a database of a certain name, and then create some database tables that follow certain specifications. The next part requires that we use the `COPY` PostgreSQL statement or the meta command `\copy`.

We opt for `\copy` because it offers a nice benefit compared with `COPY`: you can use a relative path to the file you wish to import. However, when using `COPY`, we have to use the absolute path, which can be tedious.

We use three copy commands, one for each table data we wish to import. It's important to remember to use the `HEADER` and `CSV` options: `HEADER` tells PostgreSQL to expect headers on the first line of each file, while the `CSV` tells PostgreSQL that we are importing a CSV file. Without this second option, the `\copy` meta-command would not work.

Once these files are imported, we should be all done. After each copy operation, look for something like `COPY N`, where `N` is the number of rows copied into a table. This should tell you if the operation was successful.

**Review**
- For sales price, we can have a `CHECK` that value is between `0.00` and `1000.00` even when the field can hold a `NULL` value. This mean that if a field has a NULL value, it is not checked against a `CHECK` constraint.
- `COPY` PostgreSQL statement and `\copy` differ in that the former can only use
an absolute file path while the latter can use a relative path
- For the `FORMAT` option, We write one of `CSV`, `TEXT` or `BINARY`, rather than  `FORMAT { CSV | TEXT | BINARY }`.
- We also write `HEADER` instead of `HEADER TRUE` as option.
