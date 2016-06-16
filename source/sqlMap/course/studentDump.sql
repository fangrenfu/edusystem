SELECT R32DUMP.STUDENTNO,STUDENTS.NAME AS STUDENTNAME,R32DUMP.COURSENO+R32DUMP.[GROUP] AS COURSENOGROUP,
COURSES.COURSENAME,COURSES.CREDITS, R32DUMP.REASON,CAST(R32DUMP.INPROGRAM AS CHAR) AS INPROGRAM,COURSEAPPROACHES.VALUE AS COURSETYPE
FROM R32DUMP JOIN COURSES ON R32DUMP.COURSENO=COURSES.COURSENO
JOIN STUDENTS ON R32DUMP.STUDENTNO=STUDENTS.STUDENTNO
JOIN COURSEAPPROACHES ON R32DUMP.COURSETYPE=COURSEAPPROACHES.NAME
WHERE R32DUMP.YEAR=:YEAR
AND R32DUMP.TERM=:TERM
AND R32DUMP.STUDENTNO=:STUDENTNO
ORDER BY R32DUMP.STUDENTNO