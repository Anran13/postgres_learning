## Create New Table
See my [About](https://neon.com/postgresql/postgresql-tutorial/postgresql-create-table) page for details.

```sql
CREATE TABLE [IF NOT EXISTS] table_name (
   column1 datatype(length) column_constraint,
   column2 datatype(length) column_constraint,
   ...
   table_constraints
);
```

Now, we create a table named **student** including 4 columns, student_id, name, major, and created_at.
The following is the corresponding **POSTGRES** code:

```sql
CREATE TABLE IF NOT EXISTS student(
   student_id SERIAL PRIMARY KEY,
   name VARCHAR(20) NOT NULL,
   --major VARCHAR(20) UNIQUE,
   major VARCHAR(20),
   created_at TIMESTAMP NOT NULL
);
```

where **--** is for annotation, and **PRIMARY KEY** is the intersection of **NOT NULL** and **UNIQUE**.

If we'd like to remove the table **student**, we can follow [About](https://neon.com/postgresql/postgresql-tutorial/postgresql-drop-table) page:

```sql
DROP TABLE IF EXISTS student CASCADE;
```

where **CASCADE** will delete all objects depending on the table **student**.

Next, we can finally insert data into the table **student**
(any changes in data can be found in [About](https://neon.com/postgresql/postgresql-tutorial/postgresql-insert) page)
```sql
INSERT INTO table_name (column1, column2) VALUES
(value1a, value2a),
(value1b, value2b),
(value1c, value2c);
```
So, our example is
```sql
INSERT INTO student (name, major) 
VALUES ('A', 'Math'), ('B', 'Society'), ('C', 'Chemistry'), ('D', 'Math'), ('E', 'Society'), ('F', 'Chemistry');
```

## Modification
The following shows some basic statement"

* Modify the column's value:
```sql
UPDATE table_name
SET column1 = value1,
    column2 = value2,
    ...
WHERE condition;
```

We just change some students' major to "History".
```sql
UPDATE student 
SET major = 'History'
WHERE student_id in (2,6);
```

* Remove some row observations:

```sql
DELETE FROM table_name
WHERE condition;
```

If a student quit school, we have:
```sql
DELETE FROM student
WHERE student_id = '1';
```

## Query Data from Table
The tutorial can be found in [Ref](https://neon.com/postgresql/postgresql-tutorial/postgresql-select).

```sql
SELECT _column1_, _column2_, ...
FROM table_name;
WHERE _column_ conditions;
ORDER BY _column_ DESC;
LIMIT 3;
```
where **DESC** will show the descending order according to the **column**, and **LIMIT** will show the number of observations.

Note that the conditions includes the following basic usage:
* "="
* ">"
* "<"
* ">="
* "<="
* "<>" or "!=" 
* "AND"
* "OR"
* "IN"
* "BETWEEN"
* "LIKE"
* "IS NULL"
* "NOT"

The example will be like the following:
```sql
SELECT * FROM student
WHERE student_id > 3 AND major = 'Math'
ORDER BY student_id DESC;
```