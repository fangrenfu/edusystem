SELECT * FROM V_WORKLOADCALC
WHERE [YEAR]=:YEAR AND TERM=:TERM AND COURSENO LIKE :COURSENO AND COURSENAME LIKE :COURSENAME
AND SCHOOL LIKE :SCHOOL AND WORKTYPE LIKE :TYPE