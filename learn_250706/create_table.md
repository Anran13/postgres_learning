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

# Application
We first import data from [URL](https://github.com/Anran13/postgres_learning/blob/main/new_table/world.csv).

### Copy column and rename it
```sql
ALTER TABLE world 
ADD COLUMN data_new DATE;
UPDATE world SET data_new = 日期;
```

### Change **datatype**
```sql
ALTER TABLE world
ALTER COLUMN data_new TYPE DATE
USING data_new::DATE;
```

## Questions
Based on the following statement, solve the questions! (Can ask using **Perplexity**)
```sql
SELECT 洲名,國家,日期,總確診數,總死亡數,新增死亡數,總人口數 FROM world WHERE
```

1. 查詢亞洲總共有多少人死亡
* Solve Q1:
```sql
SELECT 
--DATE_TRUNC('year', 日期) AS death_year,
EXTRACT(YEAR FROM 日期) AS death_year,
SUM(總死亡數) AS death_total
FROM world
--GROUP BY ROLLUP (DATE_TRUNC('year', 日期))
GROUP BY ROLLUP (EXTRACT(YEAR FROM 日期))
ORDER BY death_year NULLS LAST;
```
where **EXTRACT(YEAR FROM 日期)** will find only **year** information, and
**DATE_TRUNC('year', 日期)** will find the first day of the year (full date) information (e.g. **2020-01-01 00:00:00**).

2. 查詢全世界2020年的總確診數
3. 查國家名有"阿"字,總死亡數大於10000
4. 查詢哪個國家總確診數最多
5. 查詢亞洲台灣 2020-06-25 的總確診數
6. 總死亡數最高的國家
7. 台灣有多少人在2020確診?
8. 排序各國確診數
9. 查詢每百萬確診人數
10. 台灣哪個月死亡人數最多人
11. 在哪個年度及月分，死亡數達到高峰
12. 多明尼加確診數有多少?
13. 查各國總死亡數佔確診數比例
14. 查詢哪個國家總確診數最少
15. 台灣每個月的死亡率
16. 查那個國家的死亡人數最低的前10名的國家
17. 哪一日死亡人數最多
18. 2021年各州總死亡數
19. 查詢歐洲 2020-06-15 的總死亡數
20. 查詢總確認數單日大於5筆
21. 查詢各洲死亡佔確診數佔比