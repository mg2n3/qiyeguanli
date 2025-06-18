package com.cg.controller;

import com.cg.entity.*;
import com.cg.service.*;
import com.cg.util.Md5Util;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.math.BigDecimal;
import java.util.List;
import java.util.Optional;

@Controller
@RequestMapping("/employee")
public class EmployeeController {
    @Autowired
    EmployeeService employeeService;
    @Autowired
    PositionService positionService;
    @Autowired
    DepartmentService departmentService;
    @Autowired
    UserService userService;
    @Autowired
    SalaryService  salaryService;

    @RequestMapping(value = "/List")
    public String department(HttpServletRequest request, Model model){
        User user = (User) request.getSession().getAttribute("user");
        Integer departmentId=user.getDepartmentId();
        List<Employee> employeeList= employeeService.employeeList("","",null,departmentId);
        request.getSession().setAttribute("employeeList", employeeList);
        List<Position> positionList= positionService.positionList("","",null);
        request.getSession().setAttribute("positionList", positionList);
        List<Department> departmentList= departmentService.departmentList("","");
        request.getSession().setAttribute("departmentList", departmentList);
        return "employee";
    }

    @RequestMapping(value = "/add")
    public String add(HttpServletRequest request, Model model){
        return "addEmployee";
    }

    @RequestMapping(value = "/addEmployee")
    public String addPosition(@RequestParam("employeeName") String employeeName, @RequestParam("phone") String phone,
                              @RequestParam("departmentId") Integer departmentId,
                              @RequestParam("hireDate") String hireDate,
//                              @RequestParam("status") Integer status,
                              @RequestParam("positionId") Integer positionId,
                              @RequestParam("email") String email,
                              Model model){
        Employee one=employeeService.findEmployeeByName(employeeName);
        if(one==null){
           String password=Md5Util.getMD5String("123456");
           Integer role= 1;
           userService.addUser(employeeName,password,email,role);
           //获取user
            User user = userService.login(employeeName, "123456");

           Integer userId= user.getId();
            employeeService.addEmployee(employeeName,phone,departmentId,hireDate,1,positionId,email,userId);
            return "redirect:/employee/List";
        }else {
            model.addAttribute("employeeError", "该员工已存在");
            return "employee";
        }
    }

    @RequestMapping(value = "/updateEmployee")
    public String editDepartment(@RequestParam("employeeId") Integer employeeId,HttpServletRequest request) {
        Employee employee   =  employeeService.findEmployeeById(employeeId);
        request.getSession().setAttribute("employee", employee);
        return "editEmployee";
    }
    @RequestMapping(value = "/doUpdateEmployee")
    public String editdeEmployee(@RequestParam("employeeName") String employeeName, @RequestParam("phone") String phone,
                                 @RequestParam("departmentId") Integer departmentId,
                                 @RequestParam("hireDate") String hireDate,
//                                 @RequestParam("status") Integer status,
                                 @RequestParam("positionId") Integer positionId,
                                 @RequestParam("email") String email,
                                 @RequestParam("employeeId") Integer employeeId,
                                 Model model){
        int one = employeeService.findByName(employeeName);
        System.out.println("一共找到："+one);
        if (one<=1){
            employeeService.editEmployee(employeeName,phone,departmentId,hireDate,1,positionId,email,employeeId);
            return "redirect:/employee/List";
        }else{
            model.addAttribute("employeeError", "该员工已存在");
            return "employee";
        }
    }
    @RequestMapping(value = "/deleteEmployee")
    public String deleteEmployee(@RequestParam("employeeId") Integer employeeId) {
        Employee employee   =  employeeService.findEmployeeById(employeeId);
        userService.deleteUser(employee.getUserId());
       employeeService.deleteEmployee(employeeId);
        // 重定向到分类列表页面
        return "redirect:/employee/List";
    }
    @RequestMapping("/searchEmployee")
    public String searchDepartment(@RequestParam(value = "employeeName", required = false) String employeeName,
                                   @RequestParam(value = "phone", required = false) String phone,
                                   @RequestParam(value = "status", required = false) Integer status,
                                   HttpServletRequest request) {
        User user = (User) request.getSession().getAttribute("user");
        Integer departmentId=user.getDepartmentId();
        List<Employee> employeetList =employeeService.employeeList(employeeName,phone,status,departmentId);
        request.getSession().setAttribute("employeeList", employeetList);
        return "employee";
    }

    @GetMapping("/salary")
    public String viewMySalary(HttpSession session, Model model) {
        Employee employee = (Employee) session.getAttribute("employee");

        if (employee == null) {
            model.addAttribute("error", "请先登录员工账户");
            return "error"; // 可自定义错误页面
        }

        // 获取薪资构成
        Salary salary = salaryService.getSalaryByPositionAndDepartment(employee.getPositionId(), employee.getDepartmentId());
        Position position = positionService.getPositionById(employee.getPositionId());
        Department department = departmentService.getDepartmentById(employee.getDepartmentId());

        BigDecimal totalSalary = BigDecimal.ZERO;
        if (salary != null) {
            totalSalary = totalSalary
                    .add(Optional.ofNullable(salary.getAttendanceSalary()).orElse(BigDecimal.ZERO))
                    .add(Optional.ofNullable(salary.getOvertimeSalary()).orElse(BigDecimal.ZERO));
        }
        if (position != null) {
            totalSalary = totalSalary.add(Optional.ofNullable(position.getPositionSalary()).orElse(BigDecimal.ZERO));
        }
        if (department != null) {
            totalSalary = totalSalary.add(Optional.ofNullable(department.getDepartmentSalary()).orElse(BigDecimal.ZERO));
        }

        model.addAttribute("employee", employee);
        model.addAttribute("position", position);
        model.addAttribute("department", department);
        model.addAttribute("salary", salary);
        model.addAttribute("totalSalary", totalSalary);

        return "my_salary"; // JSP 页面
    }

}
