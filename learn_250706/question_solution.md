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


2. Solve Q2: 查詢全世界2020年的總確診數
   ```sql
   WITH question2 AS (
      SELECT 
      EXTRACT(YEAR FROM 日期) AS 年份, 國家, MAX(總確診數) AS 國家總確診人數
      FROM world
      GROUP BY EXTRACT(YEAR FROM 日期), 國家
   )
   SELECT 年份, SUM(國家總確診人數) AS 全世界2020年的總確診數
   FROM question2
   WHERE 年份 = 2020
   ORDER BY 年份;
   ```
   | 全世界2020年的總確診數 |
   | --- |
   | 167448225 |


3. Solve Q3: 查國家名有"阿"字，總死亡數大於10000
   ```sql
   SELECT DISTINCT 國家, MAX(總死亡數) AS 最大總死亡數
   FROM world 
   WHERE 國家 LIKE '%阿%' AND 總死亡數 > 10000
   GROUP BY 國家
   ORDER BY 最大總死亡數 DESC;
   ```

   | 國家 | 最大總死亡數 |
   | --- | --- |
   | 阿根廷 | 129109 |

   We would also like to know the yealy cumulative number of deaths.
   ```sql
   WITH question3 AS (
      SELECT EXTRACT(YEAR FROM 日期) AS 年份, 國家, 總死亡數
      FROM world 
      WHERE 總死亡數 > 10000 AND 國家 LIKE '%阿%'
      GROUP BY 年份, 國家, 總死亡數
      ORDER BY 年份, 國家
      )
   SELECT DISTINCT 國家, 年份, MAX(總死亡數) AS 累計總死亡數
   FROM question3
   GROUP BY 國家, 年份;
   ```

   | 國家 | 年份 | 累計總死亡數 |
   | --- | --- |--- |
   | 阿根廷 | 2020 | 43245 |
   | 阿根廷 | 2021 | 117169 |
   | 阿根廷 | 2022 | 129109 |


4. Solve Q4: 查詢哪個國家總確診數最多
   ```sql
   SELECT DISTINCT 國家, MAX(總確診數) AS 最大總確診數
   FROM world 
   GROUP BY 國家
   ORDER BY 最大總確診數 DESC
   LIMIT 2;
   ```
   
   | 國家 | 最大總確診數 |
   | --- | --- |
   | 全球 | 552498044 |
   | 美國 | 88263393 |

5. Solve Q5: 查詢亞洲台灣 2020-06-25 的總確診數
   ```sql
   SELECT 日期, MAX(總確診數) AS 總確診數
   FROM world
   WHERE 國家 = '台灣' AND 日期 = '2020-06-25'
   GROUP BY 日期;
   ```
   | 日期 | 總確診數 |
   | --- | --- |
   | 台灣 | 447 |

6. Solve Q6: 總死亡數最高的國家
   ```sql
   SELECT DISTINCT 國家, MAX(總死亡數) AS 最大總死亡數
   FROM world 
   GROUP BY 國家
   ORDER BY 最大總死亡數 DESC
   LIMIT 2;
   ```
      
   | 國家 | 最大總確診數 |
   | --- | --- |
   | 全球 | 6344729 |
   | 美國 | 1019083 |


7. Solve Q7: 台灣有多少人在2020確診
   ```sql
   SELECT EXTRACT(YEAR FROM 日期) AS 年份, MAX(總確診數) AS 總確診數
   FROM world
   WHERE 國家 = '台灣' AND EXTRACT(YEAR FROM 日期) = 2020
   GROUP BY 年份;
   ```
   | 年份 | 總確診數 |
   | --- | --- |
   | 2020 | 799 |

8. Solve Q8: 排序各國確診數
   ```sql
   SELECT 國家, MAX(總確診數) AS 總確診數
   FROM world
   WHERE EXTRACT(YEAR FROM 日期) = 2022
   GROUP BY 國家
   ORDER BY 總確診數 DESC;
   ```


9. Solve Q9: 查詢每百萬確診人數
   ```sql
   SELECT MAX(總確診數)/1000000 AS 每百萬確診人數
   FROM world
   WHERE EXTRACT(YEAR FROM 日期) = 2022 and 國家 = '全球';
   ```

   | 每百萬確診人數 |
   | --- |
   | 552 | 



10. Solve Q10: 台灣哪個月死亡人數最多人
   ```sql
   WITH monthly_data AS (
      SELECT 
      EXTRACT(YEAR FROM 日期) AS 年份,
      EXTRACT(MONTH FROM 日期) AS 月份,
      MAX(總死亡數) AS 月底總死亡數
      FROM world 
      WHERE 國家 = '台灣'
      GROUP BY EXTRACT(YEAR FROM 日期), EXTRACT(MONTH FROM 日期)
      ),
      monthly_deaths AS (
         SELECT 年份, 月份, 月底總死亡數,
         月底總死亡數 - LAG(月底總死亡數, 1, 0) OVER (ORDER BY 年份, 月份) AS 當月死亡數
         FROM monthly_data
         )

   SELECT 月份, 
   SUM(CASE WHEN 年份 = 2020 THEN 當月死亡數 END) AS Y2020年,
   SUM(CASE WHEN 年份 = 2021 THEN 當月死亡數 END) AS Y2021年,
   SUM(CASE WHEN 年份 = 2022 THEN 當月死亡數 END) AS Y2022年
   FROM monthly_deaths
   GROUP BY 月份
   ORDER BY 月份;
   ```
   where **LAG OVER** statement is illustrate as follows [Ref](https://www.rockdata.net/tutorial/function-lag/):
   
   ```sql
   LAG(column_name, offset, default_value) OVER (OVER BY order_column)
   ```
   The **offset** argument specifies the number of rows that comes before the current row, **default_value** will return a value when **offset** is beyond the scope.
   
   In this case, we need to calculate the number of death in each month by subtracting the cumulative number of death in the previous month from the current cumulative number.



11. Solve Q11: 在哪個年度及月分，死亡數達到高峰
   The solution is similar to that in **Solve Q10**.
