package com.cg.controller;

import com.cg.entity.Department;
import com.cg.entity.Employee;
import com.cg.entity.Position;
import com.cg.service.DepartmentService;
import com.cg.service.EmployeeService;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
@RequestMapping("/department")
public class DepartmentController {
    @Autowired
    DepartmentService departmentService;
    @Autowired
    EmployeeService employeeService;
    @RequestMapping(value = "/List")
    public String department(HttpServletRequest request, Model model){
        List<Department> departmentList= departmentService.departmentList("","");
        request.getSession().setAttribute("departmentList", departmentList);
        return "department";
    }

    @RequestMapping(value = "/add")
    public String add(HttpServletRequest request, Model model){
        return "addDepartment";
    }

    @RequestMapping(value = "/addDepartment")
    public String addPosition(@RequestParam("departmentName") String departmentName, @RequestParam("departmentCode") String departmentCode, Model model){
        Department one=departmentService.findDepartmentByName(departmentName);
        if(one==null){
            departmentService.addDepartment(departmentName,departmentCode);
            return "redirect:/department/List";
        }else {
            model.addAttribute("departmentError", "部门已存在");
            return "department";
        }
    }

    @RequestMapping(value = "/updateDepartment")
    public String editDepartment(@RequestParam("departmentId") Integer departmentId,HttpServletRequest request) {
        Department department  =  departmentService.findDepartmentById(departmentId);
        request.getSession().setAttribute("department", department);
        return "editDepartment";
    }
    @RequestMapping(value = "/doUpdateDepartment")
    public String editdepartment(HttpServletRequest request,@RequestParam("departmentName") String departmentName,
                               @RequestParam("departmentCode") String departmentCode,
                               @RequestParam("departmentId") Integer departmentId,Model model){
        int one = departmentService.findByName(departmentName,departmentId);
        System.out.println("一共找到："+one);
        if (one==0){
            departmentService.editDepartment(departmentName,departmentCode,departmentId);
            return "redirect:/department/List";
        }else{
            model.addAttribute("departmentError", "该部门已存在");
            return "department";
        }
    }

    @RequestMapping(value = "/deleteDepartment")
    public String deleteDepartment(@RequestParam("departmentId") Integer departmentId, Model model) {

        int one = employeeService.findEmployeeByDepartment(departmentId);
        if(one==0){
            departmentService.deleteDepartment(departmentId);
            // 重定向到分类列表页面
            return "redirect:/department/List";
        }else{
            model.addAttribute("departmentError", "该部门下有员工！！！");
            return "department";
        }


    }


    @RequestMapping("/searchDepartment")
    public String searchDepartment(@RequestParam(value = "departmentName", required = false) String departmentName,
                               @RequestParam(value = "departmentCode", required = false) String departmentCode, HttpServletRequest request) {
        List<Department> departmentList =departmentService.departmentList(departmentName,departmentCode);
        request.getSession().setAttribute("departmentList", departmentList);
        return "department";
    }
}
