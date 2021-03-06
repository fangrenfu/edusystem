UPDATE WORKLOADCALC SET REPEATCOEFF=(
SELECT 
CASE WHEN WORKTYPE='M1' THEN
	CASE WHEN (SELECT COUNT(*) FROM WORKLOADCALC WHERE WORKLOADCALC.COURSENO=W.COURSENO AND WORKLOADCALC.[YEAR]=W.[YEAR] AND WORKLOADCALC.TERM=W.TERM AND WORKLOADCALC.REPEATCOEFF IS NOT NULL) = 0 THEN 1 ELSE 0.85 END 
ELSE 1 END REPEATCOEFF
FROM WORKLOADCALC W WHERE WORKLOADCALC.ID=W.ID
)
WHERE ID=:ID