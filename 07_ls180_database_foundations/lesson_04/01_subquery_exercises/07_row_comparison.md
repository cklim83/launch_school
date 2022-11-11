## Row Comparison

We want to check that a given item is in our database. There is one problem though: we have all of the data for the item, but we don't know the `id` number. Write an SQL query that will display the `id` for the item that matches all of the data that we know, but does not use the `AND` keyword. Here is the data we know:

'Painting', 100.00, 250.00

My answer:
```sql
SELECT id
FROM items
WHERE ROW(name,initial_price, sales_price) = ROW('Painting', 100.00, 250.00);
```

**Approach/Algorithm**
The following links should be of use for solving this exercise:
- [Row Constructors](https://www.postgresql.org/docs/9.5/sql-expressions.html#SQL-SYNTAX-ROW-CONSTRUCTORS)
- [Row-wise Comparison](https://www.postgresql.org/docs/9.5/functions-comparisons.html#ROW-WISE-COMPARISON)

You don't need to use a subquery to solve this problem.

**Solution**
```sql
SELECT id FROM items
WHERE ROW('Painting', 100.00, 250.00) =
  ROW(name, initial_price, sales_price);
```

**Discussion**

Since we aren't allowed to use `AND` in our solution, we can't do something like this:
```sql
SELECT id FROM items
WHERE name = 'Painting' AND
      initial_price = 100.00 AND
      sales_price = 250.00;
```

Instead, we need to use `ROW` to construct two virtual rows: one that contains the data we want, and one that represents the data for each row in the table. We then compare these two virtual rows to find the row that matches our data and extract its `id`.

The two calls to `ROW` construct the two rows of values we need. We then use them as part of `WHERE` clause to find the appropriate rows from the `items` table. The output from our solution gives us:

```plaintext
 id
----
  3
(1 row)
```

Just to clarify, let's go over how row comparison works. Each field in the first row is compared to the corresponding field in the second row, from left to right. In our case, we are using the operator, `=`, so we compare each field from left to right and see if those fields are equal to the ones listed on the right side of the equals sign. If we encounter a value in one of our rows that isn't equal to its counterpart, then that row isn't considered, and we move onto the next row in our table `items`.

The comparison behavior between rows is a tad bit different when using other operators like `<` or `>`, but we'll leave that for another day.

For a small example like this, this solution may seem to be inordinately complex. However, the more columns that need to be inspected, the more likely you will find it easier to do a `ROW` operation.
