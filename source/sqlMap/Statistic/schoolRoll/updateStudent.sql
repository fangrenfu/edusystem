UPDATE STUDENTS SET NAME=:NAME,SEX=:SEX,ENTERDATE=CAST(:ENTERDATE as DATETIME),YEARS=:YEARS,CLASSNO=:CLASSNO,WARN=:WARN,STATUS=:STATUS,CONTACT=:CONTACT,SCHOOL=:SCHOOL WHERE STUDENTNO=:STUDENTNO;
UPDATE PERSONAL SET MAJOR=:MAJOR,CLASS=:CLASS WHERE STUDENTNO =:P_STUDENTNO;