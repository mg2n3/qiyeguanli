package com.cg.service;

import com.cg.entity.Employee;

import java.util.List;

public interface EmployeeService {

    String findByEmployeeId(String no);

    List<Employee> employeeList(String employeeName, String phone, Integer status,Integer departmentId);

    Employee findEmployeeByName(String employeeName);

    void addEmployee(String employeeName, String phone, Integer departmentId, String hireDate, Integer status, Integer positionId, String email, Integer userId);

    Employee findEmployeeById(Integer employeeId);

    int findByName(String employeeName);

    void editEmployee(String employeeName, String phone, Integer departmentId, String hireDate, Integer status, Integer positionId, String email,Integer employeeId);

    void deleteEmployee(Integer employeeId);

    Employee findEmployeeByUserId(Integer userId);

    int findEmployeeByPosition(Integer positionId);

    int findEmployeeByDepartment(Integer departmentId);
}
