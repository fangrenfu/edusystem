SELECT SCHEDULE.TIME+SCHEDULE.DAY+SCHEDULE.OEW AS TIME,
RTRIM(COURSES.COURSENAME)+':'+SCHEDULE.COURSENO+SCHEDULE.[GROUP]+'('+RTRIM(CLASSROOMS.JSN)+')'+TEACHERS.NAME AS COURSE,
SCHEDULE.WEEKS AS WEEKS,
TASKOPTIONS.NAME AS TASK
FROM SCHEDULE JOIN COURSEPLAN
ON SCHEDULE.COURSENO=COURSEPLAN.COURSENO
AND SCHEDULE.[GROUP]=COURSEPLAN.[GROUP]
AND SCHEDULE.YEAR=COURSEPLAN.YEAR
AND SCHEDULE.TERM=COURSEPLAN.TERM
JOIN COURSES
ON SCHEDULE.COURSENO=COURSES.COURSENO
JOIN CLASSROOMS ON SCHEDULE.ROOMNO=CLASSROOMS.ROOMNO
JOIN TEACHERPLAN ON SCHEDULE.MAP=TEACHERPLAN.RECNO
JOIN TEACHERS ON TEACHERPLAN.TEACHERNO=TEACHERS.TEACHERNO
LEFT OUTER JOIN TASKOPTIONS ON TEACHERPLAN.TASK=TASKOPTIONS.CODE
WHERE SCHEDULE.YEAR=:YEAR
AND SCHEDULE.TERM=:TERM
AND COURSEPLAN.CLASSNO=:CLASSNO
ORDER BY TIME