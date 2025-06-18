package com.cg.controller;

import com.cg.common.Result;
import com.cg.entity.*;
import com.cg.service.*;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Controller
@RequestMapping("/data")
public class DataController {
    @Autowired
    EmployeeService employeeService;
    @Autowired
    PositionService positionService;
    @Autowired
    DepartmentService departmentService;
    @Autowired
    UserService userService;
    @Autowired
    AttendanceService attendanceService ;

    @Autowired
    LeaveService leaveService;

    @RequestMapping("/List")
    public String dataList(HttpServletRequest request) {
        List<Employee> employeeList = employeeService.employeeList("", "", null, null);
        ObjectMapper objectMapper = new ObjectMapper();
        String employeeListJson = "";
        try {
            employeeListJson = objectMapper.writeValueAsString(employeeList);
        } catch (JsonProcessingException e) {
            e.printStackTrace();
        }
        request.setAttribute("employeeListJson", employeeListJson);

        List<Leave> leaveList = leaveService.leaveList(null, null, null, null);
        String leaveListJson = "";
        try {
            leaveListJson = objectMapper.writeValueAsString(leaveList);
        } catch (JsonProcessingException e) {
            e.printStackTrace();
        }
        request.setAttribute("leaveListJson", leaveListJson);

        List<Department> departmentList = departmentService.departmentList(null, null );
        String departmentListJson = "";
        try {
            departmentListJson = objectMapper.writeValueAsString(departmentList);
        } catch (JsonProcessingException e) {
            e.printStackTrace();
        }
        request.setAttribute("departmentListJson", departmentListJson);

        List<Attendance> attendanceList = attendanceService.attendanceList(null,null,null);
        String attendanceListJson = "";
        try {
            attendanceListJson = objectMapper.writeValueAsString(attendanceList);
        } catch (JsonProcessingException e) {
            e.printStackTrace();
        }
        request.setAttribute("attendanceListJson", attendanceListJson);
        return "dataList";
    }

    @RequestMapping("/manageData")
    public String manageData(HttpServletRequest request) {
        User user = (User) request.getSession().getAttribute("user");
        Integer departmentId  = user.getDepartmentId();
        List<Employee> employeeList = employeeService.employeeList("", "", null, departmentId);
        ObjectMapper objectMapper = new ObjectMapper();
        String employeeListJson = "";
        try {
            employeeListJson = objectMapper.writeValueAsString(employeeList);
        } catch (JsonProcessingException e) {
            e.printStackTrace();
        }
        request.setAttribute("employeeListJson", employeeListJson);

        List<Leave> leaveList = leaveService.leaveList(null, null, null, departmentId);
        String leaveListJson = "";
        try {
            leaveListJson = objectMapper.writeValueAsString(leaveList);
        } catch (JsonProcessingException e) {
            e.printStackTrace();
        }
        request.setAttribute("leaveListJson", leaveListJson);

        List<Department> departmentList = departmentService.departmentList(null, null );
        String departmentListJson = "";
        try {
            departmentListJson = objectMapper.writeValueAsString(departmentList);
        } catch (JsonProcessingException e) {
            e.printStackTrace();
        }
        request.setAttribute("departmentListJson", departmentListJson);

        List<Attendance> attendanceList = attendanceService.attendanceList(null,null,departmentId);
        String attendanceListJson = "";
        try {
            attendanceListJson = objectMapper.writeValueAsString(attendanceList);
        } catch (JsonProcessingException e) {
            e.printStackTrace();
        }
        request.setAttribute("attendanceListJson", attendanceListJson);
        return "manageData";
    }
//    @RequestMapping("/departmentData")
//    @ResponseBody
//    public  Result<List<Department>> departmentData(Model model) {
//        return new Result<List<Department>>(1, "操作成功", departmentService.departmentList("", ""));
//    }
    //        List<Employee> employeeList = employeeService.employeeList("", "", null, null);
//        model.addAttribute("employeeList", employeeList);
//        List<Leave> leaveList = leaveService.leaveList(null, null, null, null);
//        model.addAttribute("leaveList", leaveList);
//        List<Position> positionList = positionService.positionList("", "", null);
//        model.addAttribute("positionList", positionList);
//        List<Attendance> attendanceList = attendanceService.attendanceList();
//        model.addAttribute("attendanceList", attendanceList);


}