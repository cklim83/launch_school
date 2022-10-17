Does the following statement use the DDL or DML component of SQL?
```sql
CREATE TABLE things (
  id serial PRIMARY KEY,
  item text NOT NULL UNIQUE,
  material text NOT NULL
);
```

My answer:
The statement above is part of DDL. `CREATE` involves the definition of a table schema and so is part of DDL.



Solution

DDL
Discussion

`CREATE TABLE` defines the type of information stored in a database table by describing the data and its attributes. It does not actually manipulate any data, but instead manipulates the data definitions. As such, `CREATE TABLE` statements are part of the DDL sublanguage.

