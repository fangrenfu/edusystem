INSERT INTO VIEWSCHEDULETABLE
SELECT VIEWSCHEDULE.*,newid() AS ROWID
FROM VIEWSCHEDULE
WHERE VIEWSCHEDULE.YEAR=:YEAR
AND VIEWSCHEDULE.TERM=:TERM
