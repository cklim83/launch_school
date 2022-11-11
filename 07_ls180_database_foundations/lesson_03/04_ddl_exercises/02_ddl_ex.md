
Relating Stars and Planets

You may have noticed that, when we created the stars and planets tables, we did not do anything to establish a relationship between the two tables. They are simply standalone tables that are related only by the fact that they both belong to the extrasolar database. However, there is no relationship between the rows of each table.

To correct this problem, add a star_id column to the planets table; this column will be used to relate each planet in the planets table to its home star in the stars table. Make sure the column is defined in such a way that it is required and must have a value that is present as an id in the stars table.


My answer:
```sql
ALTER TABLE planets ADD COLUMN star_id INTEGER NOT NULL REFERENCES stars(id);
```


Solution
```sql
ALTER TABLE planets
ADD COLUMN star_id integer NOT NULL REFERENCES stars (id);
```

Discussion

This problem is about adding a column to an existing table, and in particular, about using that column to establish a relationship between two tables. Thus, the column must be defined as a foreign key.

Everything you do to modify the schema of a table, whether it is adding or deleting a column or modifying the characteristics of a column will involve the `ALTER TABLE` command, so we will of course need to use `ALTER TABLE` in our solution. In this case, we are adding a new column to the planets table, so use `ALTER TABLE` planets `ADD COLUMN` star_id. We also need to specify the data type of the column, and specify that the column is a foreign key. The data type is integer, and a foreign key is defined with the `REFERENCES` clause.

Note that we must also designate `NOT NULL` for the new column; foreign keys don't receive the `NOT NULL` constraint automatically.
