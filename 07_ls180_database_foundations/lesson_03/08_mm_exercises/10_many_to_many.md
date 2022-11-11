## Deleting Rows

Write the necessary SQL statements to delete the "Bulk Email" service and customer "Chen Ke-Hua" from the database.

My answer
```sql
DELETE FROM customers WHERE name = 'Chen Ke-Hua';

DELETE FROM services WHERE description = 'Bulk Email';

DELETE FROM customers_services 
  WHERE service_id = (SELECT id FROM services WHERE description = 'Bulk Email');
```

**Solution**

```sql
DELETE FROM customers_services
WHERE service_id = 7;

DELETE FROM services
WHERE description = 'Bulk Email';

DELETE FROM customers
WHERE name = 'Chen Ke-Hua';
```

**Discussion**

Assuming that the `service_id` for "Bulk Email" is `7`, we must first delete all records from the join table, `customers_services`, where the `service_id` is `7`. If we don't do this, the next command will fail due to a foreign key constraint.

Once we've deleted the join table entries for the service, we can now delete the actual service record from the `services` table.

Finally, we delete Chen Ke-Hua's customer row. This time, though, we don't need to explicitly delete her entries in the `customers_services` join table. Take a moment to ponder this -- can you tell why we don't need to do this?

The reason why we don't need to delete anything from the join table is that we defined `customer_id` in the join table to be a foreign key that included the `ON DELETE CASCADE` clause. This clause arranges for PostgreSQL to automatically delete the appropriate join table rows when a row is deleted from the table that that foreign key references (in this case `customers`). So, when we delete Chen's row, the corresponding entries from the join table are also deleted. 


**Review**
- We cannot just delete an entry that is being referenced without deleting the referencing entry first. In this example, we need to delete rows with `service_id` = `7` i.e. 'Bulk Email' before we can delete the entry in `services` table since we do not have the `ON DELETE CASCADE` clause to automate the update. 
