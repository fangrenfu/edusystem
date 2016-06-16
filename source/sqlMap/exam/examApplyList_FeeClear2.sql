SELECT EXAMAPPLIES.STUDENTNO,
STUDENTS.NAME AS STUDENTNAME,
CLASSES.CLASSNAME AS CLASSNAME,
SCHOOLS.NAME AS SCHOOLNAME,
STUDENTS.YEARS AS YEARS,
PERSONAL.SEX AS SEX,
SEXCODE.NAME AS SNAME,
RTRIM(CAST(YEAR(PERSONAL.BIRTHDAY) AS CHAR))+'-'+LTRIM(CAST(MONTH(PERSONAL.BIRTHDAY) AS CHAR)) AS BIRTHDAY,
PERSONAL.id as ID,
STUDENTS.CLASSNO,
YEAR(STUDENTS.ENTERDATE) AS ENTERYEAR,isnull(CET.SCORE,0) as SCORE,isnull(CET2.SCORE2,0) as SCORE2,
isnull(CET3.SCORE,0) AS SCORE3,ISNULL(CET4.SCORE,0) AS SCORE4
FROM EXAMAPPLIES INNER JOIN STUDENTS
ON EXAMAPPLIES.STUDENTNO=STUDENTS.STUDENTNO
INNER JOIN PERSONAL ON EXAMAPPLIES.STUDENTNO=PERSONAL.STUDENTNO
INNER JOIN SEXCODE ON SEXCODE.CODE=PERSONAL.SEX
INNER JOIN CLASSES ON CLASSES.CLASSNO=STUDENTS.CLASSNO
INNER JOIN SCHOOLS ON SCHOOLS.SCHOOL=CLASSES.SCHOOL
LEFT OUTER JOIN (SELECT MAX(成绩) AS SCORE ,学号 AS STUDENTNO FROM 英语cet4统考成绩 GROUP BY 学号) AS CET ON CET.STUDENTNO=STUDENTS.STUDENTNO LEFT OUTER JOIN (SELECT MAX(成绩) AS SCORE2 ,学号 AS STUDENTNO FROM 英语cet3统考成绩 GROUP BY 学号) AS CET2 ON CET2.STUDENTNO=STUDENTS.STUDENTNO
LEFT OUTER JOIN (SELECT MAX(成绩) AS SCORE ,学号 AS STUDENTNO FROM 英语A级统考成绩 GROUP BY 学号) AS CET3 ON CET3.STUDENTNO=STUDENTS.STUDENTNO 
LEFT OUTER JOIN (SELECT MAX(成绩) AS SCORE ,学号 AS STUDENTNO FROM 英语B级统考成绩 GROUP BY 学号) AS CET4 ON CET4.STUDENTNO=STUDENTS.STUDENTNO
WHERE EXAMAPPLIES.MAP=:RECNO
AND CLASSES.SCHOOL LIKE :SCHOOL
AND EXAMAPPLIES.FEE=1
ORDER BY SCHOOLNAME,CLASSNO,STUDENTNO