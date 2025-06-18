package com.cg.service;

import com.cg.dto.request.SalaryRequestDTO;
import com.cg.entity.Salary;
import java.util.List;

public interface SalaryService {
    List<Salary> getSalariesByPositionAndDepartment(Integer positionId, Integer departmentId);
    Salary updateSalary(Integer salaryId, SalaryRequestDTO salaryDTO);
    /**
     * 添加薪资记录（使用DTO作为参数）
     * @param salaryDTO 薪资请求DTO对象
     * @return 保存后的薪资实体对象
     */
    Salary addSalary(SalaryRequestDTO salaryDTO);

    /**
     * 删除薪资记录
     * @param salaryId 薪资ID
     */
    void deleteSalary(Integer salaryId);


    Salary getSalaryById(Integer salaryId);

    /**
     * 根据岗位和部门查询薪资记录
     * @param positionId 岗位ID
     * @param departmentId 部门ID
     * @return 薪资列表
     */


    /**
     * 获取所有薪资记录
     * @return 薪资列表
     */
    List<Salary> getAllSalaries();

    /**
     * 检查指定岗位和部门是否已存在薪资记录
     * @param positionId 岗位ID
     * @param departmentId 部门ID
     * @return 是否存在
     */
    boolean existsByPositionAndDepartment(Integer positionId, Integer departmentId);

    /**
     * 检查是否存在其他相同岗位和部门的薪资记录（排除指定ID）
     * @param salaryId 要排除的薪资ID
     * @param positionId 岗位ID
     * @param departmentId 部门ID
     * @return 是否存在
     */
    boolean existsOtherSalary(Integer salaryId, Integer positionId, Integer departmentId);

    /**
     * 搜索薪资记录
     * @param positionId 岗位ID（可选）
     * @param departmentId 部门ID（可选）
     * @return 薪资列表
     */
    List<Salary> searchSalaries(Integer positionId, Integer departmentId);
}