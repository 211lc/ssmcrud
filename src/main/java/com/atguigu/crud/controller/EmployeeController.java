package com.atguigu.crud.controller;

import com.atguigu.crud.bean.Employee;
import com.atguigu.crud.bean.Msg;
import com.atguigu.crud.service.EmployeeService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class EmployeeController {
    @Autowired
    EmployeeService employeeService;

    // 根据id删除员工
    @ResponseBody
    @RequestMapping(value = "/emp/{ids}",method = RequestMethod.DELETE)
    public Msg deleteEmp(@PathVariable("ids") String ids) {
        if(ids.contains("-")){
            List<Integer> del_ids = new ArrayList<Integer>();
            // 如果包含-，那么是多个删除，否则执行单个删除
            String[] str_ids = ids.split("-");
            // 组装id
            for (String string : str_ids) {
                del_ids.add(Integer.parseInt(string));
            }
            employeeService.deleteBatch(del_ids);
        }else{
            Integer id = Integer.parseInt(ids);
            employeeService.deleteEmp(id);
        }
        return Msg.success();
    }

    // 根据id更新员工信息
    @RequestMapping(value = "/emp/{empId}",method = RequestMethod.PUT)
    @ResponseBody
    public Msg saveEmp(Employee employee) {
        employeeService.updateEmp(employee);
        return Msg.success();
    }

    // 查询员工信息
    @RequestMapping(value = "/emp/{id}",method = RequestMethod.GET)
    @ResponseBody
    public Msg getEmp(@PathVariable("id") Integer id) {
        Employee employee = employeeService.getEmp(id);
        return Msg.success().add("emp",employee);
    }

    // 校验用户名是否重复
    @RequestMapping("/checkUser")
    @ResponseBody
    public Msg checkUser(@RequestParam("empName") String empName) {
        // 先判断empName是否符合正则表达式
        String regx = "(^[a-zA-Z0-9_-]{6,16}$)|(^[\\u2E80-\\u9FFF]{2,5})";
        if (!empName.matches(regx)){
            return Msg.fail().add("va_msg","用户名是2-5位或字符串6-16位^-^");
        }
        boolean b = employeeService.checkUser(empName);
        if (b) {
            return Msg.success();
        }else {
            return Msg.fail().add("va_msg","用户名已存在^-^");
        }
    }

    // 定义员工保存
    @RequestMapping(value = "/emp",method = RequestMethod.POST)
    @ResponseBody
    public Msg saveEmp(@Valid Employee employee, BindingResult result) {
        if (result.hasErrors()){
            Map<String, Object> map = new HashMap<String, Object>();
            // 如果校验失败，返回校验失败信息给前端
            List<FieldError> errors = result.getFieldErrors();
            for (FieldError fieldError : errors) {
//                System.out.println(fieldError.getField());
//                System.out.println(fieldError.getDefaultMessage());
                map.put(fieldError.getField(),fieldError.getDefaultMessage());
            }
            return Msg.fail().add("errorFields",map);
        }
        employeeService.saveEmp(employee);
        return Msg.success();
    }

    // 返回json格式的员工数据
    @RequestMapping("/emps")
    @ResponseBody
    public Msg getEmpsWithJson(@RequestParam(value = "pn",defaultValue = "1") Integer pn) throws Exception {
        // 使用pagehelper分页插件分页查询,pn是页码，pageSize是每页查询个数
        PageHelper.startPage(pn, 5);
        List<Employee> emps = employeeService.getAll();
        // 使用pageInfo包装查询
        PageInfo page = new PageInfo(emps,5);
        return Msg.success().add("pageInfo",page);
    }
    // 查询所有员工
//    @RequestMapping("/emps")
    public String getEmps(@RequestParam(value = "pn",defaultValue = "1") Integer pn, Model model) throws Exception {
        // 使用pagehelper分页插件分页查询,pn是页码，pageSize是每页查询个数
        PageHelper.startPage(pn, 5);
        List<Employee> emps = employeeService.getAll();
        // 使用pageInfo包装查询
        PageInfo page = new PageInfo(emps,5);
        // 将数据添加进model域
        model.addAttribute("pageInfo",page);
        return "list";
    }
}
