SELECT EXAMAPPLIES.STUDENTNO,
STUDENTS.NAME AS STUDENTNAME,
SCHOOLS.NAME AS SCHOOLNAME,
CLASSES.CLASSNAME,
YEAR(STUDENTS.ENTERDATE) AS ENTERYEAR,
CAST(EXAMAPPLIES.FEE AS INT) AS FEE,
EXAMAPPLIES.RECNO 
FROM EXAMAPPLIES INNER JOIN STUDENTS
ON EXAMAPPLIES.STUDENTNO=STUDENTS.STUDENTNO
LEFT OUTER JOIN SCHOOLS
ON STUDENTS.SCHOOL=SCHOOLS.SCHOOL
LEFT OUTER JOIN CLASSES ON STUDENTS.CLASSNO=CLASSES.CLASSNO
WHERE EXAMAPPLIES.MAP=:RECNO
AND EXAMAPPLIES.STUDENTNO LIKE :STUDENTNO
ORDER BY SCHOOLNAME,EXAMAPPLIES.STUDENTNO
