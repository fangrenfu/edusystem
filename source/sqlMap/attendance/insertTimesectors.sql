INSERT INTO [学生考勤表](year,term,周数,上课时间,studentno,节次,courseno,学时,请假理由,备注,date) 
VALUES(:YEAR,:TERM,:WEEK,cast(:DATETIME as datetime),:STUDENTNO,:TIMENO,:COURSENO,:TIMENUM,:REASON,:BREAKTHERULE,getdate())