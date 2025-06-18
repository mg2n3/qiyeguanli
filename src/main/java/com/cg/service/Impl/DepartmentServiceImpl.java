package com.cg.service.Impl;

import com.cg.entity.Department;
import com.cg.mapper.DepartmentMapper;
import com.cg.service.DepartmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class DepartmentServiceImpl implements DepartmentService {
    @Autowired
    DepartmentMapper departmentMapper;

    @Override
    public List<Department> departmentList(String departmentName, String departmentCode) {
        return departmentMapper.departmentList(departmentName, departmentCode);
    }

    @Override
    public Department findDepartmentByName(String departmentName) {
        return departmentMapper.findDepartmentByName(departmentName);
    }

    @Override
    public void addDepartment(String departmentName, String departmentCode) {
        departmentMapper.addDepartment(departmentName, departmentCode);
    }

    @Override
    public Department findDepartmentById(Integer departmentId) {

        return departmentMapper.findDepartmentById(departmentId);
    }

    @Override
    public int findByName(String departmentName, Integer departmentId) {
        return departmentMapper.findByName(departmentName, departmentId);
    }

    @Override
    public void editDepartment(String departmentName, String departmentCode, Integer departmentId) {
        departmentMapper.editDepartment(departmentName, departmentCode, departmentId);
    }

    @Override
    public void deleteDepartment(Integer departmentId) {
        departmentMapper.deleteDepartment(departmentId);
    }


    @Override
    public List<Department> getAllDepartments() {

        return  departmentMapper.departmentList("","");
    }
}
