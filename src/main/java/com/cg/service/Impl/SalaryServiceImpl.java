package com.cg.service.Impl;

import com.cg.dto.request.SalaryRequestDTO;
import com.cg.entity.Salary;
import com.cg.mapper.SalaryMapper;
import com.cg.service.SalaryService;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;

@Service
@Transactional
public class SalaryServiceImpl implements SalaryService {
    private final SalaryMapper salaryMapper;
    private final ModelMapper modelMapper;

    @Autowired
    public SalaryServiceImpl(SalaryMapper salaryMapper, ModelMapper modelMapper) {
        this.salaryMapper = salaryMapper;
        this.modelMapper = modelMapper;
    }

    @Override
    public Salary addSalary(SalaryRequestDTO salaryDTO) {
        Salary salary = modelMapper.map(salaryDTO, Salary.class);
        salary.setCreateTime(LocalDateTime.now());
        salaryMapper.addSalary(salary);
        return salary;
    }

    @Override
    public boolean existsByPositionAndDepartment(Integer positionId, Integer departmentId) {
        return salaryMapper.countByPositionAndDepartment(positionId, departmentId) > 0;
    }

    @Override
    public boolean existsOtherSalary(Integer salaryId, Integer positionId, Integer departmentId) {
        return salaryMapper.countOtherByPositionAndDepartment(salaryId, positionId, departmentId) > 0;
    }

    @Override
    public List<Salary> getSalariesByPositionAndDepartment(Integer positionId, Integer departmentId) {
        return salaryMapper.getSalariesByPositionAndDepartment(positionId, departmentId);
    }

    // 添加缺失的方法实现
    @Override
    public List<Salary> searchSalaries(Integer positionId, Integer departmentId) {
        // 直接复用现有查询方法
        return getSalariesByPositionAndDepartment(positionId, departmentId);
    }

    @Override
    public List<Salary> getAllSalaries() {
        return salaryMapper.getAllSalaries();
    }

    @Override
    public void deleteSalary(Integer salaryId) {
        salaryMapper.deleteSalary(salaryId);
    }

    @Override
    public Salary getSalaryById(Integer salaryId) {
        return salaryMapper.getSalaryById(salaryId);
    }

    // SalaryServiceImpl.java
    @Override
    public Salary updateSalary(Integer salaryId, SalaryRequestDTO salaryDTO) {
        // 先从数据库获取现有记录
        Salary existingSalary = salaryMapper.getSalaryById(salaryId);

        if (existingSalary == null) {
            throw new RuntimeException("薪资记录不存在，ID: " + salaryId);
        }

        // 只更新允许修改的字段
        existingSalary.setPositionId(salaryDTO.getPositionId());
        existingSalary.setDepartmentId(salaryDTO.getDepartmentId());
        existingSalary.setOvertimeSalary(salaryDTO.getOvertimeSalary());
        existingSalary.setAttendanceSalary(salaryDTO.getAttendanceSalary());

        // 执行更新
        salaryMapper.updateSalary(existingSalary); // 确保传递完整对象
        return existingSalary;
    }
}