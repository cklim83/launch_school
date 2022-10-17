Does the following statement use the DDL or DML component of SQL?

```sql
DROP DATABASE xyzzy;
```

My answer:
DDL. `DROP DATABASE` is used to remove an entire database, including all its constituent tables/relations. It does not manipulate rows of data and is part of DDL.


Solution

DDL

Discussion

This one is a bit ambiguous. Depending on how you look at DROP DATABASE, you might think it is part of the DML, part of the DDL, or both.

`DROP DATABASE` removes all data from the database, including any and all tables in the database. In this respect, it manipulates data, so some people think of it as part of DML. However, `DROP DATABASE` also deletes everything about the structure of the database and its tables. Furthermore, all variants of the `DROP` statement are generally treated as DDL. In these respects, `DROP DATABASE` manipulates how the data is structured, so it is considered part of the DDL sublanguage.

For our purposes at Launch School, `DROP DATABASE` is DDL since its main purpose is to operate on data definitions; the deletion of data is merely a side-effect.

