select count(*) as ROWS from(SELECT row_number() over(order by STUDENTS.STUDENTNO) as row,STUDENTS.STUDENTNO,
STUDENTS.NAME AS STUDENTNAME,
STUDENTS.CLASSNO,STUDENTS.SCHOOL,
SCHOOLS.NAME AS SCHOOLNAME,
CLASSES.CLASSNAME,
STUDENTS.POINTS,
0 AS REPEAT
FROM STUDENTS
LEFT OUTER JOIN CLASSES
ON STUDENTS.CLASSNO=CLASSES.CLASSNO
LEFT OUTER JOIN SCHOOLS
ON STUDENTS.SCHOOL=SCHOOLS.SCHOOL
WHERE STUDENTNO LIKE :STUDENTNO
)as b where row<=500