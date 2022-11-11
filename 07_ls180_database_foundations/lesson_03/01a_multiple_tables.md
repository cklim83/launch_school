# Working with Multiple Tables 

1. Import this [file](https://raw.githubusercontent.com/launchschool/sql_course_data/master/sql-and-relational-databases/relational-data-and-joins/working-with-multiple-tables/theater_full.sql) into an empty PostgreSQL database. Note: the file contains a lot of data and may take a while to run; your terminal should return to the command prompt once the import is complete.

  My answer:
  ```terminal
  createdb multiple_tables
  psql -d multiple_tables < theater_full.sql
  ```


2. Write a query that determines how many tickets have been sold.

  **Expected Output**
  ```plaintext  
  count
  -------
  3783
  (1 row)
  ```

  My answer:
  ```sql
  SELECT count(id) FROM tickets;
  ```

  Solution:
  ```sql
  SELECT COUNT(*) FROM tickets;
  ```


3. Write a query that determines how many different customers purchased tickets to at least one event.

  **Expected Output**
  ```plaintext
    count
  -------
    1652
  (1 row)
  ```

  My answer:
  ```sql
  SELECT COUNT(DISTINCT customer_id) FROM tickets;
  ```

  Solution:
  ```sql
  SELECT COUNT(DISTINCT customer_id) FROM tickets;
  ```


4. Write a query that determines what percentage of the customers in the database have purchased a ticket to one or more of the events.

  **Expected Output**
  ```plaintext
    percent
  ----------
      16.52
  (1 row)
  ```

  My answer:
  ```sql
  SELECT 
    ROUND(COUNT(DISTINCT t.customer_id) / COUNT(DISTINCT c.id)::NUMERIC * 100, 2) AS percent
  FROM customers AS c
  LEFT OUTER JOIN tickets AS t
  ON c.id = t.customer_id;
  ```

  Solution:
  ```sql
  SELECT round( COUNT(DISTINCT tickets.customer_id)
              / COUNT(DISTINCT customers.id)::decimal * 100,
              2)
         AS percent
    FROM customers
    LEFT OUTER JOIN tickets
      ON tickets.customer_id = customers.id;
  ```

  To understand this code, lets first ignore the counting part:

  ```sql
  SELECT customers.id, tickets.customer_id
    FROM customers
    LEFT OUTER JOIN tickets
      ON tickets.customer_id = customers.id;
  ```

  That query will produce output that looks like this:

  ```plaintext
    id   | customer_id
  -------+-------------
    8528 |        8528
    8528 |        8528
    9571 |        9571
    7662 |        7662
    7662 |        7662
    7662 |        7662
    7662 |        7662
    6979 |        6979
    6979 |        6979
    5456 |        5456
        ....
    3762 |
    7983 |
    7345 |
    2283 |
    7555 |
    7042 |
    8154 |
  (12131 rows)
  ```

  Note that we use a `LEFT OUTER JOIN` so that we get all of the customer IDs, even those that don't have any tickets.

  To compute the percentage of customers that have bought tickets, we need to determine how many different customers have bought tickets and divide that by the number of customers. The first number is the number of customer IDs in the second column of the above output, e.g., `COUNT(DISTINCT tickets.customer_id)`. The second number is the number of distinct IDs in the first column, e.g., `COUNT(DISTINCT customers.id)`.

  Given that, all that we must do is compute and format the percentage of customers with tickets, as seen in the solution.


5. Write a query that returns the name of each event and how many tickets were sold for it, in order from most popular to least popular.

  **Expected Output**
  ```plaintext
              name            | popularity
  ----------------------------+------------
   A-Bomb                     |        555
   Captain Deadshot Wolf      |        541
   Illustrious Firestorm      |        521
   Siren I                    |        457
   Kool-Aid Man               |        439
   Green Husk Strange         |        414
   Ultra Archangel IX         |        359
   Red Hope Summers the Fated |        307
   Magnificent Stardust       |        134
   Red Magus                  |         56
  (10 rows)
  ```

  My answer:
  ```sql
  SELECT name, COUNT(t.id) AS popularity
  FROM tickets AS t
  INNER JOIN events AS e
  ON t.event_id = e.id
  GROUP BY name
  ORDER BY popularity DESC;
  ```

  Solution:
  ```sql
  SELECT e.name, COUNT(t.id) AS popularity
    FROM events AS e
    LEFT OUTER JOIN tickets AS t
      ON t.event_id = e.id
    GROUP BY e.id
    ORDER BY popularity DESC;
  ```

  Once again, we're using a LEFT OUTER JOIN. That way, we get all of the events rows even if we haven't sold any tickets for that event.

  In this code, we're using AS e and AS t to assign aliases to the events and tickets tables to save ourselves some typing. Without the aliasing, our command would look like this:

  ```sql
  SELECT events.name, COUNT(tickets.id) AS popularity
    FROM events
    LEFT OUTER JOIN tickets
      ON tickets.event_id = events.id
    GROUP BY events.id
    ORDER BY popularity DESC;
  ```
  
  Let's back up a bit and take a look at the data we're working with:

  ```sql
  SELECT e.name, t.id
    FROM events AS e
    LEFT OUTER JOIN tickets AS t
      ON t.event_id = e.id;
  ```
  
  That produces output that looks like this:
  ```plaintext
        name           |  id
  ---------------------+------
   Kool-Aid Man        |    1
   Kool-Aid Man        |    2
   Kool-Aid Man        |    3
     ...
   Kool-Aid Man        |  438
   Kool-Aid Man        |  439
   Siren I             |  440
   Siren I             |  441
   Siren I             |  442
     ...
   Ultra Archangel IX  | 3781
   Ultra Archangel IX  | 3782
   Ultra Archangel IX  | 3783
  (3783 rows)
  ```

  Instead of listing all of the ID numbers, though, we just want to count them. Let's try:
  ```sql
  SELECT e.name, COUNT(t.id) AS popularity
    FROM events AS e
    LEFT OUTER JOIN tickets AS t
      ON t.event_id = e.id;
  ```

  Unfortunately, that produces an error message:
  ```sql
  ERROR:  column "e.name" must appear in the GROUP BY clause or be used in an aggregate function
  LINE 1: SELECT e.name, COUNT(t.id) AS popularity
                 ^
  ```
  The error message tells us that, if we want to use COUNT, then e.name must be either in a GROUP BY clause or be used in an aggregate function (e.g., COUNT or SUM). What we want to do here is to group our event names together so we can produce a count for each event:

  ```sql
  SELECT events.name, COUNT(tickets.id) AS popularity
    FROM events
    LEFT OUTER JOIN tickets
      ON tickets.event_id = events.id
    GROUP BY events.id;
  ```

  The output now looks like this:
  ```plaintext
       name                   | popularity
  ----------------------------+------------
   Illustrious Firestorm      |        521
   Ultra Archangel IX         |        359
   Red Magus                  |         56
   Green Husk Strange         |        414
   Kool-Aid Man               |        439
   Red Hope Summers the Fated |        307
   A-Bomb                     |        555
   Siren I                    |        457
   Captain Deadshot Wolf      |        541
   Magnificent Stardust       |        134
  (10 rows)
  ```
  
  At this point, all that remains is to sort the output by popularity. See the solution code.

  REVIEW:
  My solution assumed all events have tickets sold. Should have use events LEFT OUTER JOIN tickets to ensure even events without tickets sold are retained.


6. Write a query that returns the user id, email address, and number of events for all customers that have purchased tickets to three events.

  **Expected Output**
  ```plaintext
    id   |                email                 | count
  -------+--------------------------------------+-------
    141  | isac.hayes@herzog.net                |     3
    326  | tatum.mraz@schinner.org              |     3
    624  | adelbert.yost@kleinwisozk.io         |     3
    1719 | lionel.feeney@metzquitzon.biz        |     3
    2058 | angela.ruecker@reichert.co           |     3
    3173 | audra.moore@beierlowe.biz            |     3
    4365 | ephraim.rath@rosenbaum.org           |     3
    6193 | gennaro.rath@mcdermott.co            |     3
    7175 | yolanda.hintz@binskshlerin.com       |     3
    7344 | amaya.goldner@stoltenberg.org        |     3
    7975 | ellen.swaniawski@schultzemmerich.net |     3
    9978 | dayana.kessler@dickinson.io          |     3
  (12 rows)
  ```

  My answer:
  ```sql
  SELECT c.id, c.email, COUNT(t.event_id) 
    FROM customers AS c
    LEFT OUTER JOIN tickets AS t
    ON c.id = t.customer_id
    GROUP BY c.id, t.event_id
    HAVING COUNT(t.event_id) = 3
    ORDER BY c.id;
  ```

  Solution:
  ```sql
  SELECT customers.id, customers.email, COUNT(DISTINCT tickets.event_id)
    FROM customers
    INNER JOIN tickets
      on tickets.customer_id = customers.id
    GROUP BY customers.id
    HAVING COUNT(DISTINCT tickets.event_id) = 3;
  ```

  This problem is similar to the previous problem: We need to provide output that shows customer IDs and counts. Thus, we should use `GROUP BY` to group the results by the customer ID. The main difference is that we want to limit the output to just the rows for customers who bought tickets to exactly 3 events. For that, we use the `HAVING` clause.

  We previously stated that `GROUP BY` must specify all columns when using an aggregate function such as `COUNT`. However, you can ignore this requirement if you apply `GROUP BY` to the table's primary key.

  We use an `INNER JOIN` here since we're only interested in customers that have tickets. We could also use a `LEFT OUTER JOIN` or even a `RIGHT OUTER JOIN`. However, `INNER JOIN` is the better choice since it more clearly shows that we're not interested in non-matching customers or tickets.

  REVIEW:
  My answer is wrong. It will select all customers that has bought 3 tickets to an event.

  ```plaintext
    id  |                  email                   | count 
  ------+------------------------------------------+-------
   8954 | lelah.nikolaus@wehnerkshlerin.net        |     3
   9828 | travis.fay@hoppe.info                    |     3
   7806 | dana.parker@borer.net                    |     3
   8419 | gladyce.rosenbaum@halvorson.biz          |     3
    497 | katheryn.schowalter@schmidtrempel.name   |     3
   6193 | gennaro.rath@mcdermott.co                |     3
   1382 | margret.treutel@stamm.info               |     3
               ...
  ```

  Take customer id 497 for example, viewing the join results
  ```sql
  SELECT *
    FROM customers AS c
    LEFT OUTER JOIN tickets AS t
      ON c.id = t.customer_id
    WHERE c.id = 497;
  ```
  
  We get
  ```plaintext
   id  | first_name | last_name  |   phone    |                 email                  | id  | event_id | seat_id | customer_id 
  -----+------------+------------+------------+----------------------------------------+-----+----------+---------+-------------
   497 | Katheryn   | Schowalter | 8720895925 | katheryn.schowalter@schmidtrempel.name | 682 |        2 |     378 |         497
   497 | Katheryn   | Schowalter | 8720895925 | katheryn.schowalter@schmidtrempel.name | 683 |        2 |     379 |         497
   497 | Katheryn   | Schowalter | 8720895925 | katheryn.schowalter@schmidtrempel.name | 684 |        2 |     380 |         497
  (3 rows)
  ```

  This shows that even if we group by `customer_id` and `event_id`, we will get more than 1 row if multiple tickets were purchased for the same event due to the presence of other columns in the virtual table. In customer 497's case, we can see that she bought 3 tickets to the same event. 
  
  ```sql
  SELECT c.id, c.email, COUNT(t.event_id)
    FROM customers AS c
    LEFT OUTER JOIN tickets AS t
      ON c.id = t.customer_id
    WHERE c.id = 497
    GROUP BY c.id, t.event_id;
  ```

  ```plaintext
   id  |                 email                  | count 
  -----+----------------------------------------+-------
   497 | katheryn.schowalter@schmidtrempel.name |     3 
  ```

  If we count the number of distinct event_ids instead,
  ```sql
    SELECT c.id, c.email, COUNT(DISTINCT t.event_id)
    FROM customers AS c
    LEFT OUTER JOIN tickets AS t
      ON c.id = t.customer_id
    WHERE c.id = 497
    GROUP BY c.id, t.event_id;
  ```
  
  We will get the right distinct event at both customer id and event_id level, meaning each customer will only have a count value of 0(never purchased any tickets) or 1 (purchased one or more tickets to an event).
  ```plaintext
   id  |                 email                  | count                                                 
  -----+----------------------------------------+-------
   497 | katheryn.schowalter@schmidtrempel.name |     1                                           
  ```

  Since customer_id and event_id is the wrong grouping, we cannot simply use `COUNT(DISTINCT t.event_id) = 3` to the `HAVING` clause which filters at group rather than row level. Grouping both customer id and event_id, it is impossible for a group to have >1 distinct event_id. Hence result will be zero.

  ```sql
  SELECT c.id, c.email, COUNT(DISTINCT t.event_id)
    FROM customers AS c
    LEFT OUTER JOIN tickets AS t
      ON c.id = t.customer_id
    GROUP BY c.id, t.event_id
    HAVING COUNT(DISTINCT t.event_id) = 3;
  ```

  ```plaintext
   id | email | count 
  ----+-------+-------
  (0 rows)
  ```
  
  Thus, the only way to have distinct event_id count > 1 is to group by
  customer_id only, which will lead to the provided solution.


7. Write a query to print out a report of all tickets purchased by the customer with the email address 'gennaro.rath@mcdermott.co'. The report should include the event name and starts_at and the seat's section name, row, and seat number.

  **Expected Output**
  ```plaintext
         event        |      starts_at      |    section    | row | seat
  --------------------+---------------------+---------------+-----+------
   Kool-Aid Man       | 2016-06-14 20:00:00 | Lower Balcony | H   |   10
   Kool-Aid Man       | 2016-06-14 20:00:00 | Lower Balcony | H   |   11
   Green Husk Strange | 2016-02-28 18:00:00 | Orchestra     | O   |   14
   Green Husk Strange | 2016-02-28 18:00:00 | Orchestra     | O   |   15
   Green Husk Strange | 2016-02-28 18:00:00 | Orchestra     | O   |   16
   Ultra Archangel IX | 2016-05-23 18:00:00 | Upper Balcony | G   |    7
   Ultra Archangel IX | 2016-05-23 18:00:00 | Upper Balcony | G   |    8
  (7 rows)
  ```

  My answer:
  ```sql
  SELECT 
      e.name AS event, e.starts_at, sections.name AS section, seats.row, seats.number AS seat
    FROM customers AS c
    INNER JOIN tickets AS t
      ON c.id = t.customer_id
    INNER JOIN events AS e
      ON t.event_id = e.id
    INNER JOIN seats
      ON t.seat_id = seats.id
    INNER JOIN sections
      ON seats.section_id = sections.id
    WHERE c.email = 'gennaro.rath@mcdermott.co';
  ```

  Solution:
  ```sql
  SELECT events.name AS event,
         events.starts_at,
         sections.name AS section,
         seats.row,
         seats.number AS seat
    FROM tickets
    INNER JOIN events
      ON tickets.event_id = events.id
    INNER JOIN customers
      ON tickets.customer_id = customers.id
    INNER JOIN seats
      ON tickets.seat_id = seats.id
    INNER JOIN sections
      ON seats.section_id = sections.id
    WHERE customers.email = 'gennaro.rath@mcdermott.co';
  ```

  This solution looks complex, but it isn't as bad as it looks. Note that the 4 JOINs are merely grabbing the data that we need from the events, customers, seats, and sections tables. Once we have all that data, we just need to select the rows for the customer with the given email address, and display the columns of interest.
