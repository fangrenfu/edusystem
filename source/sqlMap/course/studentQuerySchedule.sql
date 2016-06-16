SELECT RTRIM(VIEWSCHEDULETABLE.COURSENOGROUP) AS COURSENOGROUP,
    dbo.GETONE(RTRIM(VIEWSCHEDULETABLE.COURSENAME)) AS COURSENAME,
    dbo.GETONE(VIEWSCHEDULETABLE.CREDITS) AS CREDITS,
    dbo.GETONE(VIEWSCHEDULETABLE.WEEKHOURS) AS WEEKHOURS,
    dbo.GETONE(VIEWSCHEDULETABLE.WEEKEXPEHOURS) AS WEEKEXPEHOURS,
    dbo.GETONE(RTRIM(VIEWSCHEDULETABLE.COURSETYPE)) AS COURSETYPE,
    dbo.GETONE(RTRIM(VIEWSCHEDULETABLE.EXAMTYPE)) AS EXAMTYPE,
    dbo.GETONE(RTRIM(VIEWSCHEDULETABLE.EXAM)) AS EXAM,
    dbo.GETONE(SCHEDULEPLAN.ATTENDENTS) AS ATTENDENTS,
    dbo.GETONE(RTRIM(VIEWSCHEDULETABLE.COURSETYPENAME)) AS COURSETYPENAME,
    dbo.GETONE(RTRIM(VIEWSCHEDULETABLE.SCHOOLNAME)) AS SCHOOLNAME,
    dbo.GROUP_CONCAT_MERGE(RTRIM(VIEWSCHEDULETABLE.CLASSNONAME), '; ') AS CLASSNONAME,
    dbo.GETONE(RTRIM(VIEWSCHEDULETABLE.TEACHERNONAME)) AS TEACHERNONAME,
    dbo.GETONE(RTRIM(VIEWSCHEDULETABLE.REM)) AS REM,
    dbo.GROUP_CONCAT_MERGE(RTRIM(VIEWSCHEDULETABLE.DAYNTIME)+', 座位数:'+RTRIM(CAST(VIEWSCHEDULETABLE.SEATS AS char)), '<br />') AS CURRICULUM
FROM VIEWSCHEDULETABLE LEFT OUTER JOIN SCHEDULEPLAN ON VIEWSCHEDULETABLE.RECNO=SCHEDULEPLAN.RECNO
WHERE VIEWSCHEDULETABLE.YEAR= :YEAR
AND VIEWSCHEDULETABLE.TERM= :TERM
AND VIEWSCHEDULETABLE.COURSENOGROUP LIKE :COURSENOGROUP
AND VIEWSCHEDULETABLE.COURSENAME LIKE :COURSENAME
AND (VIEWSCHEDULETABLE.TEACHERNAME LIKE :TEACHERNAME  OR VIEWSCHEDULETABLE.TEACHERNAME IS NULL)
AND VIEWSCHEDULETABLE.TYPE LIKE :COURSETYPE
AND VIEWSCHEDULETABLE.SCHOOL LIKE :SCHOOL
AND VIEWSCHEDULETABLE.CLASSNO LIKE :CLASSNO
AND (VIEWSCHEDULETABLE.DAY LIKE :DAY OR VIEWSCHEDULETABLE.DAY IS NULL)
AND (VIEWSCHEDULETABLE.TIME LIKE :TIME OR VIEWSCHEDULETABLE.TIME IS NULL)
GROUP BY COURSENOGROUP
ORDER BY COURSENOGROUP