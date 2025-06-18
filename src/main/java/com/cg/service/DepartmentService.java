package com.cg.service;

import com.cg.entity.Department;


import java.util.List;

public interface DepartmentService {

    List<Department> departmentList(String departmentName, String departmentCode);

    Department findDepartmentByName(String departmentName);

    void addDepartment(String departmentName, String departmentCode);

    Department findDepartmentById(Integer departmentId);

    int findByName(String departmentName,Integer departmentId);

    void editDepartment(String departmentName, String departmentCode, Integer departmentId);

    void deleteDepartment(Integer departmentId);

    List<Department> getAllDepartments();

    Department getDepartmentById(Integer id);

}
