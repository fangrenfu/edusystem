select * from(SELECT row_number() over(ORDER BY 英语A级统考成绩.学院, 英语A级统考成绩.年级) as row,
      英语A级统考成绩.学院 xy, 英语A级统考成绩.年级 nj, isnull(ls_ksrs.考试人数,0) ksrs,
      isnull(ls_yxrs.优秀人数,0) yxrs, isnull(ls_hgrs.合格人数,0) hgrs, isnull(ls_bhgrs.不合格人数,0) bhgrs
FROM 英语A级统考成绩 LEFT OUTER JOIN
          (SELECT 英语A级统考成绩.学院, 英语A级统考成绩.年级, COUNT(*)
               AS 考试人数
         FROM 英语A级统考成绩
         WHERE 英语A级统考成绩.年 =:YONE AND 英语A级统考成绩.月份 =:TONE
         GROUP BY 英语A级统考成绩.学院, 英语A级统考成绩.年级) AS Ls_ksrs ON
      ls_ksrs.学院 = 英语A级统考成绩.学院 AND
      ls_ksrs.年级 = 英语A级统考成绩.年级 LEFT OUTER JOIN
          (SELECT 英语A级统考成绩.学院, 英语A级统考成绩.年级, COUNT(*)
               AS 优秀人数
         FROM 英语A级统考成绩
         WHERE 英语A级统考成绩.年 =:YTWO AND 英语A级统考成绩.月份 =:TTWO AND
               英语A级统考成绩.成绩 >= 85
         GROUP BY 英语A级统考成绩.学院, 英语A级统考成绩.年级) AS Ls_yxrs ON
      ls_yxrs.学院 = 英语A级统考成绩.学院 AND
      ls_yxrs.年级 = 英语A级统考成绩.年级 LEFT OUTER JOIN
          (SELECT 英语A级统考成绩.学院, 英语A级统考成绩.年级, COUNT(*)
               AS 合格人数
         FROM 英语A级统考成绩
         WHERE 英语A级统考成绩.年 =:YTHREE AND 英语A级统考成绩.月份 =:TTHREE AND
               英语A级统考成绩.成绩 >= 60
         GROUP BY 英语A级统考成绩.学院, 英语A级统考成绩.年级) AS Ls_hgrs ON
      ls_hgrs.学院 = 英语A级统考成绩.学院 AND
      ls_hgrs.年级 = 英语A级统考成绩.年级 LEFT OUTER JOIN
          (SELECT 英语A级统考成绩.学院, 英语A级统考成绩.年级, COUNT(*)
               AS 不合格人数
         FROM 英语A级统考成绩
         WHERE 英语A级统考成绩.年 =:YFOUR AND 英语A级统考成绩.月份 =:TFOUR AND
               英语A级统考成绩.成绩 < 60
         GROUP BY 英语A级统考成绩.学院, 英语A级统考成绩.年级) AS Ls_bhgrs ON
      ls_bhgrs.学院 = 英语A级统考成绩.学院 AND
      ls_bhgrs.年级 = 英语A级统考成绩.年级
WHERE 英语A级统考成绩.年 =:YFIVE AND 英语A级统考成绩.月份 =:TFIVE
group by 英语A级统考成绩.学院, 英语A级统考成绩.年级,ls_ksrs.考试人数,ls_yxrs.优秀人数,ls_hgrs.合格人数,ls_bhgrs.不合格人数
) as b