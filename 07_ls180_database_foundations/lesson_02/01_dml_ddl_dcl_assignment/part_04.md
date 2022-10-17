Does the following statement use the DDL or DML component of SQL?

```sql
ALTER TABLE things
DROP CONSTRAINT things_item_key;
```

My answer:
DDL. `ALTER TABLE` changes the schema of a table. In this example, we are removing a constraint for column `things_item_key`.


Solution

DDL
Discussion

`ALTER TABLE` modifies the characteristics and attributes of a table. It does not actually manipulate any data, but instead manipulates the data definitions. As such, `ALTER TABLE` statements are part of the DDL sublanguage.

