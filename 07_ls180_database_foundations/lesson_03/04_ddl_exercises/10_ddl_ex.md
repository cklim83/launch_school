## Delete the Database

Delete the extrasolar database. Use the psql console -- don't use the terminal level commands.

Note: you may want to make a backup of your database before you drop it (also called a database dump). You can make a backup like this from the terminal:

```terminal
$ pg_dump --inserts extrasolar > extrasolar.dump.sql
```

My answer:
```sql
DROP DATABASE extrasolar;
```


**Solution**
```sql
\c other_database
DROP DATABASE extrasolar;
```

**Description**

To delete a database, you can use the `DROP DATABASE` statement; this will delete the entire database, including any tables and other objects associated with the database, and the data associated with these tables and objects. However, before you can do this, you must first make sure the database you want to delete isn't open: to do this, you must use the `\c` console command to connect to another database.

Note that `DROP DATABASE` is extremely destructive: there is no confirmation prompt, and no backups are made of the database. Use this statement with extreme care. In particular, it's a good idea to make a backup.
