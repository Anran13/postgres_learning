# RDBMS (Relational Database Management System) 

## merge two tables **students** and **enrollments** with a common column
```sql
DROP TABLE IF EXISTS students, enrollments CASCADE;

CREATE TABLE IF NOT EXISTS students (
    student_id SERIAL,
    name VARCHAR(10),
    age SMALLINT,
    PRIMARY KEY(student_id)
);


CREATE TABLE IF NOT EXISTS enrollments (
    enrollment_id INT GENERATED ALWAYS AS IDENTITY, -- primary key
    student_id smallint REFERENCES students(student_id),
    course_name VARCHAR(20),
    grade VARCHAR(5)
);

-- Insert data into students table
INSERT INTO students(name, age) VALUES
    ('A', 20),
    ('B', 19),
    ('CC', 21),
    ('D', 20),
    ('EEE', 22);

-- Insert data into enrollments table
INSERT INTO enrollments (student_id, course_name, grade) VALUES
    (1, 'course1', 'A'),
    (1, 'course4', 'B+'),
    (2, 'course6', 'A-'),
    (2, 'course3', 'A'),
    (3, 'course18', 'B'),
    (3, 'course21', 'B+'),
    (4, 'course11', 'A+'),
    (4, 'course2', 'A-'),
    (5, 'course21', 'B+'),
    (5, 'course5', 'A-');

--merge tables using student_id
SELECT *
FROM students s
JOIN enrollments e ON s.student_id = e.student_id
ORDER BY s.name, e.course_name;
```

## merge 4 tables, **employee**, **branch**, **client**, and **works_with**
Note that:
  1. the **FOREIGN KEY** should be counstructed after the **PRIMARY KEY** is set up!
  2. **FOREIGN KEY** constraint need be set **NULL** if the **PRIMARY KEY** is deleted
  3. **FOREIGN KEY** can be altered if it is constructed.

```sql
-- create table employee (emp_id: primary key; branch_id: foreign key; sup_id: foreign key)
CREATE TABLE employee(
	emp_id SERIAL,
	name VARCHAR(20),
	birth_date DATE,
	sex VARCHAR(1),
	salary INT,
	branch_id INT,
	sup_id INT,
 	PRIMARY KEY(emp_id)
);

-- create table branch *(branch_id: primary key; emp_id: foreign key)
CREATE TABLE branch(
	branch_id INT,
	branch_name VARCHAR(20),
	manager_id INT,
	PRIMARY KEY(branch_id),
	FOREIGN KEY(manager_id)
	REFERENCES employee(emp_id) ON DELETE SET NULL
);

ALTER TABLE employee
ADD FOREIGN KEY(branch_id) REFERENCES branch(branch_id) ON DELETE SET NULL;

ALTER TABLE employee
ADD FOREIGN KEY(sup_id) REFERENCES employee(emp_id)
ON DELETE SET NULL;
```
