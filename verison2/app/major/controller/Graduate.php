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

namespace app\major\controller;

use app\common\access\MyAccess;
use app\common\access\MyController;
use app\common\service\Instead;
use app\common\service\Majorcode;
use app\common\service\Majordirection;
use app\common\service\Studentplan;
use app\common\vendor\PHPExcel;

class Graduate extends MyController
{
     //课程顶替列表
    public function insteadcourselist($page = 1, $rows = 20,$studentno='%',$courseno='%',$equalcourseno='%',$school='')
    {
        $result = null;
        try {
            $obj=new  Instead();
            $result = $obj->getList($page,$rows,$studentno,$courseno,$equalcourseno,$school);
        } catch (\Exception $e) {
            MyAccess::throwException($e->getCode(), $e->getMessage());
        }
        return json($result);
    }
    //更新课程顶替信息
    public function insteadupdate(){
        $result=null;
        try{
            $instead=new Instead();
            $result=$instead->update($_POST);
        }catch (\Exception $e) {
            MyAccess::throwException($e->getCode(), $e->getMessage());
        }
        return json($result);
    }

    public function insteadexport($studentno='%',$courseno='%',$equalcourseno='%',$school='')
    {
        $result = null;
        try {
            $obj=new  Instead();
            $result = $obj->getList(1,1000,$studentno,$courseno,$equalcourseno,$school);
            $data = $result['rows'];
            $file = "课程顶替列表";
            $sheet = '全部';
            $title = '';
            $template = array("studentno" => "学号", "studentname" => "姓名","classname"=>"班级", "schoolname"=>"学院","courseno" => "原课号", "coursename" => "原课名",
                "credits"=>"原学分","courseschoolname"=>"原课程学院","eqcourseno"=>"等价课号", "eqcoursename"=>"等价课名","eqcredits"=>"等价学分","eqcourseschoolname"=>"等价学院");
            $string = array("studentno,courseno,eqcourseno");
            $array[] = array("sheet" => $sheet, "title" => $title, "template" => $template, "data" => $data, "string" => $string);
            PHPExcel::export2Excel($file, $array);
        } catch (\Exception $e) {
            MyAccess::throwException($e->getCode(), $e->getMessage());
        }
        return json($result);
    }

      //读取
    public function query($page = 1, $rows = 20,$studentno='%',$name='%',$classno='%',$school='',$status='')
    {
        $result = null;
        try {
            $obj=new Studentplan();
            $result = $obj->getGraduate($page,$rows,$studentno,$name,$classno,$school,$status);
        } catch (\Exception $e) {
            MyAccess::throwException($e->getCode(), $e->getMessage());
        }
        return json($result);
    }

    //查看课程
    public function courselist($page = 1, $rows = 20,$studentno='%',$name='%',$classno='%',$courseno='%',$school='',$form='')
    {
        $result = null;
        try {
            $obj=new \app\common\service\Graduate();
            $result = $obj->getCourse($page,$rows,$studentno,$name,$classno,$courseno,$school,$form);
        } catch (\Exception $e) {
            MyAccess::throwException($e->getCode(), $e->getMessage());
        }
        return json($result);
    }
    public function exportcourse($studentno='%',$name='%',$classno='%',$courseno='%',$school='',$form='')
    {
        $result = null;
        try {
            $major=new \app\common\service\Graduate();
            $result = $major->getCourse(1,5000,$studentno,$name,$classno,$courseno,$school,$form);
            $file="未通过课程列表";
            $data = $result['rows'];
            $sheet = '全部';
            $title = '';
            $template = array("studentno" => "学号", "name" => "姓名", "classname" => "班级","statusname"=>'学籍状态', "progname" => "教学计划","courseno"=>"课号",
                "coursename"=>"课名","credits"=>"学分","formname"=>"类型");
            $string = array("studentno");
            $array[] = array("sheet" => $sheet, "title" => $title, "template" => $template, "data" => $data, "string" => $string);
            PHPExcel::export2Excel($file,$array);
        } catch (\Exception $e) {
            MyAccess::throwException($e->getCode(), $e->getMessage());
        }
        return json($result);
    }
} 