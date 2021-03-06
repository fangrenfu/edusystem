<?php
// +----------------------------------------------------------------------
// |  [ MAKE YOUR WORK EASIER]
// +----------------------------------------------------------------------
// | Copyright (c) 2003-2016 http://www.nbcc.cn All rights reserved.
// +----------------------------------------------------------------------
// | Licensed ( http://www.apache.org/licenses/LICENSE-2.0 )
// +----------------------------------------------------------------------
// | Author: fangrenfu <fangrenfu@126.com> 
// +----------------------------------------------------------------------
// | Created:2016/6/20 13:12
// +----------------------------------------------------------------------

namespace app\common\service;


use app\common\access\MyService;
use think\Db;

/**学生公选课、创新技能学分获得情况
 * Class Selective
 * @package app\common\service
 */
class Selective extends MyService
{

    //更新创新技能获得情况表
    public function  update($year, $term, $studentno = '%')
    {
        $this->query->startTrans();
        try {
            $condition = null;
            $condition['year'] = $year;
            $condition['term'] = $term;
            $condition['studentno'] = array('like', $studentno);
            $this->query->table('selective')->where($condition)->delete();
            $condition = null;
            $condition['r32.year'] = $year;
            $condition['r32.term'] = $term;
            $condition['r32.studentno'] = array('like', $studentno);
            $subsqlt = Db::table('r32')->join('courses ', ' courses.courseno=r32.courseno')
                ->where($condition)->field('r32.year,r32.term,studentno,sum(credits) credit,count(*) amount')->group('r32.year,r32.term,studentno')->buildSql();
            $condition = null;
            $condition['r32.year'] = $year;
            $condition['r32.term'] = $term;
            $condition['r32.studentno'] = array('like', $studentno);
            $condition['r32.courseno'] = array('like', '08%');
            $subsqlp = Db::table('r32')->join('courses ', ' courses.courseno=r32.courseno')
                ->where($condition)->field('studentno,sum(credits) termcredit,count(*) termamount')->group('studentno')->buildSql();
            $condition = null;
            $condition['scores.courseno'] = array('like', '08%');
            $condition['scores.studentno'] = array('like', $studentno);
            $subsqls = Db::table('scores')->join('courses ', ' courses.courseno=scores.courseno')
                ->field('studentno,sum(credits) publiccredit')->where($condition)->where("examscore>0 or testscore in ('合格','及格','优秀','中等','良好')")
                ->group('studentno')->buildSql();
            $condition = null;
            $condition['studentno'] = array('like', $studentno);
            $subsqlc = Db::table('addcredit')->field('studentno,sum(credit) creativecredit')->where($condition)->group('studentno')->buildSql();

            $this->query->table($subsqlt . ' t')
                ->join($subsqlp . '  p', ' p.studentno=t.studentno', 'LEFT')
                ->join($subsqls . '  s', ' s.studentno=t.studentno', 'LEFT')
                ->join($subsqlc . '  c', ' c.studentno=t.studentno', 'LEFT')
                ->field('t.year,t.term ,t.studentno,t.credit,t.amount,isnull(p.termcredit,0) termcredit,isnull(p.termamount,0) termamount,
             isnull(publiccredit,0) publiccredit,isnull(creativecredit,0) creativecredit')
                ->selectInsert('year,term,studentno,credit,amount,termcredit,termamount,publiccredit,creativecredit', 'selective');
        } catch (\Exception $e) {
            $this->query->rollback();
            throw $e;
        }
        $this->query->commit();
        return ['status' => "1", 'info' => "更新成功"];
    }
    //获取选课情况
    public function getList($page=1,$rows=20,$year,$term,$studentno='%',$name='%',$classno='%',$school='',$amount=0){
        $result=['total'=>0,'rows'=>[]];
        $condition=null;
        $condition['selective.year']=$year;
        $condition['selective.term']=$term;
        $subsql = Db::table('selective')
            ->field('studentno,credit,amount,termcredit,termamount')
            ->where($condition)->buildSql();
        $condition=null;
        if($studentno!='%') $condition['students.studentno']=array('like',$studentno);
        if($name!='%') $condition['students.name']=array('like',$name);
        if($classno!='%') $condition['students.classno']=array('like',$classno);
        if($school!='') $condition['classes.school']=$school;
        $data=$this->query->table('students')
            ->join('classes','classes.classno=students.classno')
            ->join('schools','schools.school=classes.school')
            ->join($subsql.' t','t.studentno=students.studentno','left')
            ->field('students.studentno,students.name,students.classno,rtrim(classes.classname) classname,schools.school,rtrim(schools.name) schoolname,credit,amount,termcredit,termamount')
            ->page($page,$rows)
            ->where($condition)
            ->select();
        $count= $this->query->table('students')
            ->join('classes','classes.classno=students.classno')
            ->where($condition)->count();
        if(is_array($data)&&count($data)>0)
            $result=array('total'=>$count,'rows'=>$data);
        return $result;
    }

    //获取选课情况
    public function getOverList($page=1,$rows=20,$year,$term,$studentno='%',$amount=0){
        $result=['total'=>0,'rows'=>[]];
        $condition=null;
        $condition['selective.year']=$year;
        $condition['selective.term']=$term;
        if($studentno!='%') $condition['students.studentno']=array('like',$studentno);
        if($amount!=0) $condition['selective.termamount']=array('gt',$amount);
        $data=$this->query->table('students')
            ->join('classes','classes.classno=students.classno')
            ->join('schools','schools.school=classes.school')
            ->join('selective','selective.studentno=students.studentno')
            ->field('students.studentno,students.name,students.classno,rtrim(classes.classname) classname,schools.school,rtrim(schools.name) schoolname,credit,amount,termcredit,termamount')
            ->page($page,$rows)
            ->order('termamount desc')
            ->where($condition)
            ->select();
        $count= $this->query->table('students')
            ->join('classes','classes.classno=students.classno')
            ->join('selective','selective.studentno=students.studentno')
            ->where($condition)->count();
        if(is_array($data)&&count($data)>0)
            $result=array('total'=>$count,'rows'=>$data);
        return $result;
    }


}