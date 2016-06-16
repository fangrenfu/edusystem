SELECT COURSENO FROM 排课统计 T
WHERE YEAR=:YEAR AND TERM=:TERM AND COURSENO LIKE :COURSENO AND [GROUP] LIKE :GROUP AND SCHOOL LIKE :SCHOOL AND TYPE LIKE :TYPE 
	AND SCHEDULED LIKE :SCHEDULED 
	AND ROOMTYPE LIKE :ROOMTYPE AND (LOCK=:BLOCK OR LOCK=:LOCK) AND (ESTIMATE <= :BESTIMATE AND ESTIMATE >= :ESTIMATE)
  AND (ATTENDENTS <= :BATTENDENTS AND ATTENDENTS >= :ATTENDENTS) AND EXAM LIKE :EXAM AND DAYS LIKE :DAYS AND CLASSNO LIKE :CLASSNO 
GROUP BY COURSENO,[GROUP]