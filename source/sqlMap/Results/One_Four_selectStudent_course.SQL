SELECT STUDENTS.STUDENTNO as xh,STUDENTS.NAME AS xm,lsselection.JDH
FROM STUDENTS
LEFT OUTER JOIN
(
  SELECT STUDENTNO,SUM(SCORES.POINT) AS JDH
  FROM SCORES
  WHERE YEAR=:YEAR
  AND TERM=:TERM
  GROUP BY STUDENTNO
)AS lsSELECTION ON STUDENTS.STUDENTNO=lsSELECTION.STUDENTNO
WHERE STUDENTS.CLASSNO=:CLASSNO
ORDER BY STUDENTS.STUDENTNO