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

namespace app\base\controller;


use app\common\access\MyAccess;
use app\common\access\MyController;
use app\common\access\MyException;
use app\common\vendor\PHPExcel;
use app\common\service\Student;

class Classes extends MyController {
    /**获取班级列表
     * @param int $page
     * @param int $rows
     * @param string $classno
     * @param string $classname
     * @param string $school
     * @return \think\response\Json
     */
    public function classlist($page=1,$rows=20,$classno='%',$classname='%',$school='')
    {
        try {
            $class=new \app\common\service\Classes();
            $result =  $class->getList($page,$rows,$classno,$classname,$school);
            return json($result);
        } catch (\Exception $e) {
            MyAccess::throwException($e->getCode(),$e->getMessage());
        }
    }

    /**
     * 更新班级信息
     */
    public function classupdate(){
        try {
            $class=new \app\common\service\Classes();
            $result =  $class->update($_POST);
            return json($result);
        } catch (\Exception $e) {
             MyAccess::throwException($e->getCode(),$e->getMessage());
        }
    }

    public function export($classno='%',$classname='%',$school='')
    {
        try{
            $class=new \app\common\service\Classes();
            $result =  $class->getList(1,10000,$classno,$classname,$school);
            $classrows=$result['rows'];
            if(count($classrows)>255){
                throw new \think\Exception('classes amount to export is more than 255',MyException::PARAM_NOT_CORRECT);
            }
            $file="班级学生名单";
            $student=new Student();

            foreach($classrows as $one){
                if($one['amount']>0) { //仅导出有学生的班级
                    $result = $student->getList(1, 10000, '%', '%', $one['classno'], '', '','');
                    $class = new \app\common\service\Classes();
                    $classname = $class->getClassInfo($one['classno'])['classname'];
                    $data = $result['rows'];
                    $sheet = str_replace("*", "", $classname);
                    $title = $classname . '学生名单';
                    $template = array("studentno" => "学号", "name" => "姓名", "sexname" => "性别", "statusname" => "学籍状态", 'rem' => '备注');
                    $string = array("studentno");
                    $array[] = array("sheet" => $sheet, "title" => $title, "template" => $template, "data" => $data, "string" => $string);
                }
            }
            PHPExcel::export2Excel($file,$array);
        }
        catch (\Exception $e) {
            MyAccess::throwException($e->getCode(),$e->getMessage());
        }

    }
} 