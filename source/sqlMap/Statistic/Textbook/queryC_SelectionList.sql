SELECT R.YEAR,R.TERM,R.STUDENTNO,S.NAME,C3.CLASSNAME,C.COURSENAME,C.COURSENO+R.[GROUP] COURSENO,C2.[VALUE] COURSETYPE
	FROM R32 R INNER JOIN COURSES C ON R.COURSENO = C.COURSENO 
		INNER JOIN STUDENTS S ON R.STUDENTNO = S.STUDENTNO 
		INNER JOIN COURSEAPPROACHES C2 ON R.COURSETYPE=C2.NAME 
		INNER JOIN CLASSES C3 ON C3.CLASSNO=S.CLASSNO 
	WHERE R.YEAR = :YEAR AND R.TERM = :TERM AND R.COURSENO+R.[GROUP] LIKE :COURSENO AND S.CLASSNO LIKE :CLASSNO  
	ORDER BY COURSENO,R.STUDENTNO 