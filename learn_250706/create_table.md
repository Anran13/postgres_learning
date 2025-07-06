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
   major VARCHAR(20) UNIQUE,
   created_at TIMESTAMP NOT NULL
);
```

If we'd like to remove the table **student**, we can follow:

```sql
DROP TABLE IF EXISTS student CASCADE;
```

where **CASCADE** will delete all objects depending on the table **student**.