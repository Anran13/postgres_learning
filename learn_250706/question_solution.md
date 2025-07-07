1. Solve Q1: 查詢亞洲總共有多少人死亡
   ```sql
   SELECT 
   --DATE_TRUNC('year', 日期) AS death_year,
   EXTRACT(YEAR FROM 日期) AS death_year,
   SUM(總死亡數) AS death_total
   FROM world
   WHERE 洲名 = '亞洲'
   --GROUP BY ROLLUP (DATE_TRUNC('year', 日期))
   GROUP BY ROLLUP (EXTRACT(YEAR FROM 日期))
   ORDER BY death_year NULLS LAST;
   ```

   where **EXTRACT(YEAR FROM 日期)** will find only **year** information, and **DATE_TRUNC('year', 日期)** will find the first day of the year (full date) information (e.g. **2020-01-01 00:00:00**).
   
   However, the column **總死亡數** is the cummulative number of deaths for each country. So, we have to find the maximun **總死亡數** for countries in "亞洲", and sum up these number.

   ```sql
   WITH question1 AS (
      SELECT 
      EXTRACT(YEAR FROM 日期) AS 年份, 國家, MAX(總死亡數) AS 國家總死亡人數
      FROM world
      WHERE 洲名 = '亞洲'
      GROUP BY EXTRACT(YEAR FROM 日期), 國家
   )
   SELECT 年份, SUM(國家總死亡人數) AS 年累計死亡人數
   FROM question1
   GROUP BY 年份
   ORDER BY 年份;
   ```

   | 年份 | 年累計死亡人數 |
   | --- | --- |
   | 2020 | 337995 |
   | 2021 | 1259667 |
   | 2022 | 1445625 |