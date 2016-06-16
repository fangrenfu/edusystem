SELECT COUNT(*) AS ROWS
FROM STUDENTS JOIN SCHOOLS ON STUDENTS.SCHOOL=SCHOOLS.SCHOOL
JOIN CLASSES ON STUDENTS.CLASSNO=CLASSES.CLASSNO
WHERE STUDENTS.STUDENTNO LIKE :STUDENTNO
AND STUDENTS.NAME LIKE :NAME
AND STUDENTS.CLASSNO LIKE :CLASSNO
AND CLASSES.CLASSNAME LIKE :CLASSNAME
AND STUDENTS.SCHOOL LIKE :SCHOOL