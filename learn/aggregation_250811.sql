SELECT COUNT(*) AS "count"
FROM station_number;

SELECT COUNT(*) AS "count"
FROM station_info
WHERE "stationAddrTw" LIKE '%臺北%';


SELECT COUNT(*)
FROM station_number LEFT JOIN station_info ON "staCode" = "stationCode"
WHERE "stationName" = '基隆';

ALTER TABLE station_number
ALTER COLUMN "Date" TYPE date
USING TO_DATE("Date", 'YYYY-MM-DD');

/*number of gatein in every station in 2022*/
SELECT si."name", date_part('year', sn."Date") AS "year", COUNT('name'), AVG(sn."gateInComingCnt") AS "avg_gateIn"
FROM station_number AS sn LEFT JOIN station_info AS si ON sn."staCode" = si."stationCode"
WHERE sn."Date" BETWEEN '2022-01-01' AND '2022-12-31'
GROUP BY si."name", "year"
ORDER BY "avg_gateIn" DESC;

/*number of gatein in every station in 2022 where gatein number is greater than 500 million*/
SELECT si."name", date_part('year', sn."Date") AS "year", COUNT('name'), AVG(sn."gateInComingCnt") AS "avg_gateIn"
FROM station_number AS sn LEFT JOIN station_info AS si ON sn."staCode" = si."stationCode"
WHERE DATE_PART('year',sn."Date") = 2022
GROUP BY si."name", "year"
HAVING SUM(sn."gateInComingCnt")>5000000
ORDER BY "avg_gateIn" DESC;

/*基隆 gatein number in 2020-2022*/
SELECT si."name", date_part('year', sn."Date") AS "year", COUNT('name')
FROM station_number AS sn LEFT JOIN station_info AS si ON sn."staCode" = si."stationCode"
WHERE "stationName" = '基隆' AND DATE_PART('year',sn."Date") BETWEEN 2020 AND 2022
GROUP BY si."name", "year"
ORDER BY "year";

/*基隆 and 臺北 gatein number in 2020-2022*/
SELECT si."name", date_part('year', sn."Date") AS "year", COUNT('name')
FROM station_number AS sn LEFT JOIN station_info AS si ON sn."staCode" = si."stationCode"
WHERE ("stationName" = '基隆' OR "stationName" = '臺北') AND DATE_PART('year',sn."Date") BETWEEN 2020 AND 2022
GROUP BY si."name", "year"
ORDER BY "year";

/*Query stations where daily gatein number is over 200000 in 2022*/
SELECT DISTINCT si."name"
FROM station_number AS sn LEFT JOIN station_info AS si ON sn."staCode" = si."stationCode"
WHERE date_part('year', sn."Date") = 2022 AND sn."gateInComingCnt" > 200000
GROUP BY si."name"; 

