package com.cg.controller;

import com.cg.entity.*;
import com.cg.service.DepartmentService;
import com.cg.service.EmployeeService;
import com.cg.service.LeaveService;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
@RequestMapping("/leave")
public class LeaveController {
    @Autowired
    LeaveService leaveService;

    @Autowired
    EmployeeService employeeService;
    @RequestMapping(value = "/List")
    public String leave(HttpServletRequest request, Model model){
        User user = (User) request.getSession().getAttribute("user");
        Integer departmentId=user.getDepartmentId();
        List<Leave> leaveList= leaveService.leaveList(null,null,null,departmentId);
        request.getSession().setAttribute("leaveList", leaveList);
        List<Employee> employeeList= employeeService.employeeList("","",null,departmentId);
        request.getSession().setAttribute("employeeList", employeeList);
        return "leave";
    }

    @RequestMapping(value = "/updateLeave")
    public String updateLeave(HttpServletRequest request,
                              @RequestParam("leaveId") Integer leaveId,
                              @RequestParam("status") Integer status){

        User user = (User) request.getSession().getAttribute("user");
        leaveService.editLeave(leaveId,status,user.getUsername());
        return "redirect:/leave/List";
    }

    @RequestMapping("/searchLeave")
    public String searchLeave(@RequestParam(value = "leaveType", required = false) Integer leaveType,
                               @RequestParam(value = "status", required = false) Integer status, HttpServletRequest request) {
        User user = (User) request.getSession().getAttribute("user");
        Integer departmentId=user.getDepartmentId();
        List<Leave> leavaeList = leaveService.leaveList(leaveType,status,null,departmentId);
        request.getSession().setAttribute("leaveList", leavaeList);
        return "leave";
    }
    @RequestMapping("/detailLeave")
    public String detailLeave(HttpServletRequest request,@RequestParam("leaveId") Integer leaveId) {
        Leave leave = leaveService.findLeaveById(leaveId);
        request.getSession().setAttribute("leave", leave);
        return "detailLeave";
    }
    @RequestMapping("/employeeLeave")
    public String employeeLeave(HttpServletRequest request) {
        User user = (User) request.getSession().getAttribute("user");
        Integer userId = user.getId();
     Employee employee =  employeeService.findEmployeeByUserId(userId);
        request.getSession().setAttribute("employee", employee);
        return "employeeLeave";
    }
    @RequestMapping("/addLeave")
    public String addLeave(HttpServletRequest request) {
        User user = (User) request.getSession().getAttribute("user");
        Integer userId = user.getId();
        Employee employee =  employeeService.findEmployeeByUserId(userId);
        request.getSession().setAttribute("employee", employee);
        return "addLeave";
    }
    @RequestMapping("/doAddLeave")
    public String doAddLeave(HttpServletRequest request,@RequestParam("employeeId") Integer employeeId
            ,@RequestParam("leaveType") Integer leaveType
            ,@RequestParam("startDate") String startDate
            ,@RequestParam("endDate") String endDate
            ,@RequestParam("reason") String reason)
     {
         Integer status = 0;
         User user = (User) request.getSession().getAttribute("user");
         Integer userId = user.getId();
         Employee employee =  employeeService.findEmployeeByUserId(userId);
         Integer departmentId = employee.getDepartmentId();
         leaveService.addLeave(employeeId,leaveType,startDate,endDate,reason,status,departmentId);
        return "employeeLeave";
    }
    @RequestMapping("/History")
    public String History(HttpServletRequest request) {
        User user = (User) request.getSession().getAttribute("user");
        Integer userId = user.getId();
        Integer departmentId=user.getDepartmentId();
        Employee employee =  employeeService.findEmployeeByUserId(userId);
        Integer employeeId= employee.getEmployeeId();
        List<Leave> leaveList= leaveService.leaveList(null,null,employeeId,departmentId);

        request.getSession().setAttribute("leaveList", leaveList);
        return "HistoryLeave";
    }
    @RequestMapping(value = "/delete")
    public String deleteDepartment(@RequestParam("leaveId") Integer leaveId) {
        leaveService.deleteLeave(leaveId);
        return "redirect:/leave/employeeLeave";
    }
}
