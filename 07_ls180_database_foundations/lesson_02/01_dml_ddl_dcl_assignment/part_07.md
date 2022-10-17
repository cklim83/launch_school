Does the following statement use the DDL, DML, or DCL component of SQL?

```plaintext
\d things
```

My answer:
The above statement is not SQL. `\d` is a `psql` meta-command.


Solution

None of these. `\d` is a psql meta-command

Discussion

This is a trick question. `\d` is a psql console command, otherwise known as a meta-command, not part of SQL. As such, it is not part of any SQL sublanguage.

