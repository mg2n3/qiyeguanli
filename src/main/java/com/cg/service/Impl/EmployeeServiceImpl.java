package com.cg.service.Impl;

import com.cg.entity.Employee;
import com.cg.mapper.EmployeeMapper;

import com.cg.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class EmployeeServiceImpl implements EmployeeService {
    @Autowired
    private EmployeeMapper employeeMapper;

    @Override
    public String findByEmployeeId(String no) {
        return employeeMapper.findByEmployeeId(no);
    }

    @Override
    public List<Employee> employeeList(String employeeName, String phone, Integer status,Integer departmentId) {
        return employeeMapper.employeeList(employeeName,phone,status,departmentId);
    }

    @Override
    public Employee findEmployeeByName(String employeeName) {
        return employeeMapper.findEmployeeByName(employeeName);
    }

    @Override
    public void addEmployee(String employeeName, String phone, Integer departmentId, String hireDate, Integer status, Integer positionId, String email, Integer userId) {
        employeeMapper.addEmployee(employeeName,phone,departmentId,hireDate,status,positionId,email,userId);
    }

    @Override
    public Employee findEmployeeById(Integer employeeId) {
        return employeeMapper.findEmployeeById(employeeId);
    }

    @Override
    public int findByName(String employeeName) {
        return employeeMapper.findByName(employeeName);
    }

    @Override
    public void editEmployee(String employeeName, String phone, Integer departmentId, String hireDate, Integer status, Integer positionId, String email,Integer employeeId) {
        employeeMapper.editEmployee(employeeName,phone,departmentId,hireDate,status,positionId,email,employeeId);
    }

    @Override
    public void deleteEmployee(Integer employeeId) {
        employeeMapper.deleteEmployee(employeeId);
    }

    @Override
    public Employee findEmployeeByUserId(Integer userId) {
        return employeeMapper.findEmployeeByUserId(userId);
    }

    @Override
    public int findEmployeeByPosition(Integer positionId) {
        return employeeMapper.findEmployeeByPosition(positionId);
    }

    @Override
    public int findEmployeeByDepartment(Integer departmentId) {
        return employeeMapper.findEmployeeByDepartment(departmentId);
    }

}
