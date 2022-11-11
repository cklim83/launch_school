## Many-to-Many Practice

The following assignments assume you have imported this [file](https://raw.githubusercontent.com/launchschool/sql_course_data/master/sql-and-relational-databases/relational-data-and-joins/many-to-many-relationships/many_to_many.sql) into a database.


1. The books_categories table from this database was created with foreign keys that don't have the NOT NULL and ON DELETE CASCADE constraints. Go ahead and add them now.

**Hint**
To add `ON DELETE CASCADE` to a foreign key column, you first have to drop the foreign key constraint, then add it back to the column.


My answer:
```sql
ALTER TABLE books_categories 
  DROP CONSTRAINT books_categories_book_id_fkey,
  DROP CONSTRAINT books_categories_category_id_fkey,
  ADD FOREIGN KEY (book_id) REFERENCES books(id) ON DELETE CASCADE,
  ADD FOREIGN KEY (category_id) REFERENCES categories(id) ON DELETE CASCADE,
  ALTER book_id SET NOT NULL,
  ALTER category_id SET NOT NULL;
``` 

**Solution**
```sql
ALTER TABLE books_categories
  ALTER COLUMN book_id SET NOT NULL;

ALTER TABLE books_categories
  ALTER COLUMN category_id SET NOT NULL;

ALTER TABLE books_categories
  DROP CONSTRAINT "books_categories_book_id_fkey",
  ADD CONSTRAINT "books_categories_book_id_fkey"
  FOREIGN KEY ("book_id")
  REFERENCES books(id)
  ON DELETE CASCADE;

ALTER TABLE books_categories
  DROP CONSTRAINT "books_categories_category_id_fkey",
  ADD CONSTRAINT "books_categories_category_id_fkey"
  FOREIGN KEY ("category_id")
  REFERENCES categories(id)
  ON DELETE CASCADE;
```

Review:
- We can combine all the required changes under a single `ALTER TABLE` statement
- The `COLUMN` in `ALTER COLUMN colname SET NOT NULL` is optional
- The `CONSTRAINT constraint_name` in `ADD [CONSTRAINT constraint_name] FOREIGN KEY ...` is optional. In fact, using the default name maybe more expedient for code maintainability reasons by other developers.


2. Write a SQL statement that will return the following result:

```plaintext
 id |     author      |           categories
----+-----------------+--------------------------------
  1 | Charles Dickens | Fiction, Classics
  2 | J. K. Rowling   | Fiction, Fantasy
  3 | Walter Isaacson | Nonfiction, Biography, Physics
(3 rows)
```

My answer:
```sql
SELECT b.id, b.author, string_agg(c.name, ', ') AS categories
  FROM books AS b
  INNER JOIN books_categories AS bc ON b.id = bc.book_id
  INNER JOIN categories AS c ON bc.category_id = c.id
  GROUP BY b.id, b.author
  ORDER BY b.id;
```

**Solution:**
```sql
SELECT books.id, books.author, string_agg(categories.name, ', ') AS categories
  FROM books
    INNER JOIN books_categories ON books.id = books_categories.book_id
    INNER JOIN categories ON books_categories.category_id = categories.id
  GROUP BY books.id ORDER BY books.id;
```

Review:
- We can just `GROUP BY` `books.id` only without including `books.author` as books.aauthor is functionally dependent on books.id, which is the primary key of books. However, the converse is not true and grouping by books.author alone will cause an error as books.id is not functionally dependent on books.author. 

From the PostgresSQL docs,
  ```plaintext
  When GROUP BY is present, or any aggregate functions are present, it is not valid for the SELECT list expressions to refer to ungrouped columns except within aggregate functions or when the ungrouped column is functionally dependent on the grouped columns, since there would otherwise be more than one possible value to return for an ungrouped column. A functional dependency exists if the grouped columns (or a subset thereof) are the primary key of the table containing the ungrouped column.
  ```

  Hence, the presence of the primary key in the `GROUP BY` clause means that we don't need to worry about the book author since each row has a unique id/author combination. 



3. Write SQL statements to insert the following new books into the database. What do you need to do to ensure this data fits in the database?

| Author | Title | Categories |
| --- | --- | --- |
| Lynn Sherr | Sally Ride: America's First Woman in Space | Biography, Nonfiction, Space Exploration |
| Charlotte Brontë | Jane Eyre | Fiction, Classics |
| Meeru Dhalwala and Vikram Vij | Vij's Elegant and Inspired Indian Cuisine | Cookbook, Nonfiction, South Asia |


My answer:
```sql
ALTER TABLE books
  ALTER COLUMN title TYPE text;

INSERT INTO books (title, author)
  VALUES ('Sally Ride: America''s First Woman in Space', 'Lynn Sherr'),
         ('Jane Eyre', 'Charlotte Brontë'),
         ('Vij''s: Elegant and Inspired Indian Cuisine', 'Meeru Dhalwala and Vikram Vik');

INSERT INTO categories (name)
  VALUES ('Space Exploration'),
         ('Cookbook'),
         ('South Asia');

INSERT INTO books_categories (book_id, category_id)
  VALUES (4, 5),
         (4, 1),
         (4, 7),
         (5, 2),
         (5, 4),
         (6, 8),
         (6, 1),
         (6, 9);
```

**Solution**
We have to first change the data type of column title to be type TEXT, otherwise the current character limit for column title will prevent a string such as, "Vij's: Elegant and Inspired Indian Cuisine", from being inserted into books. Once that is done, we can then insert all the necessary data into our various tables.

```sql
ALTER TABLE books ALTER COLUMN title TYPE text;

INSERT INTO books (title, author) VALUES ('Sally Ride: America''s First Woman in Space', 'Lynn Sherr');
INSERT INTO books_categories VALUES (4, 1);
INSERT INTO books_categories VALUES (4, 5);
INSERT INTO categories (name) VALUES ('Space Exploration');
INSERT INTO books_categories VALUES (4, 7);

INSERT INTO books (title, author) VALUES ('Jane Eyre', 'Charlotte Brontë');
INSERT INTO books_categories VALUES (5, 2);
INSERT INTO books_categories VALUES (5, 4);

INSERT INTO books (title, author) VALUES ('Vij''s: Elegant and Inspired Indian Cuisine', 'Meeru Dhalwala and Vikram Vij');
INSERT INTO categories (name) VALUES ('Cookbook');
INSERT INTO categories (name) VALUES ('South Asia');
INSERT INTO books_categories VALUES (6, 1);
INSERT INTO books_categories VALUES (6, 8);
INSERT INTO books_categories VALUES (6, 9);
```


4. Write a SQL statement to add a uniqueness constraint on the combination of columns book_id and category_id of the books_categories table. This constraint should be a table constraint; so, it should check for uniqueness on the combination of book_id and category_id across all rows of the books_categories table.

My answwer:
```sql
ALTER TABLE books_categories
  ADD UNIQUE(book_id, category_id);
```

**Solution**
```sql
ALTER TABLE books_categories ADD UNIQUE (book_id, category_id);
```


5. Write a SQL statement that will return the following result:

```plaintext
      name        | book_count |                                 book_titles
------------------+------------+-----------------------------------------------------------------------------
Biography         |          2 | Einstein: His Life and Universe, Sally Ride: America's First Woman in Space
Classics          |          2 | A Tale of Two Cities, Jane Eyre
Cookbook          |          1 | Vij's: Elegant and Inspired Indian Cuisine
Fantasy           |          1 | Harry Potter
Fiction           |          3 | Jane Eyre, Harry Potter, A Tale of Two Cities
Nonfiction        |          3 | Sally Ride: America's First Woman in Space, Einstein: His Life and Universe, Vij's: Elegant and Inspired Indian Cuisine
Physics           |          1 | Einstein: His Life and Universe
South Asia        |          1 | Vij's: Elegant and Inspired Indian Cuisine
Space Exploration |          1 | Sally Ride: America's First Woman in Space
```

My answer:
```sql
SELECT categories.name,
       COUNT(books.id) AS book_count,
       string_agg(books.title, ', ') AS book_titles
  FROM categories
    INNER JOIN books_categories ON categories.id = books_categories.category_id
    INNER JOIN books ON books_categories.book_id = books.id
  GROUP BY categories.id
  ORDER BY categories.name;
```

**Solution**
```sql
SELECT categories.name, count(books.id) as book_count, string_agg(books.title, ', ') AS book_titles
  FROM books
    INNER JOIN books_categories ON books.id = books_categories.book_id
    INNER JOIN categories ON books_categories.category_id = categories.id
  GROUP BY categories.name ORDER BY categories.name;
```
