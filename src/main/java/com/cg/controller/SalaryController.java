package com.cg.controller;

import com.cg.dto.request.SalaryRequestDTO;
import com.cg.entity.Position;
import com.cg.entity.Salary;
import com.cg.service.DepartmentService;
import com.cg.service.PositionService;
import com.cg.service.SalaryService;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;

@Controller

@RequestMapping("/salary")
public class SalaryController {
    private final PositionService positionService;
    private final DepartmentService departmentService;
    private final SalaryService salaryService;

    @Autowired
    public SalaryController(
            SalaryService salaryService,
            PositionService positionService,
            DepartmentService departmentService
    ) {
        this.salaryService = salaryService;
        this.positionService = positionService;
        this.departmentService = departmentService;
    }

    @GetMapping("/list")
    public String listSalaries(Model model) {
        model.addAttribute("salaryList", salaryService.getAllSalaries());
        model.addAttribute("positionList", positionService.getAllPositions());
        model.addAttribute("departmentList", departmentService.getAllDepartments());
        return "salary";
    }

    @GetMapping("/add")
    public String showAddForm(Model model) {
        if (!model.containsAttribute("salaryDTO")) {
            model.addAttribute("salaryDTO", new SalaryRequestDTO());
        }
        model.addAttribute("positionList",  positionService.getAllPositions());
        model.addAttribute("departmentList", departmentService.getAllDepartments());

        return "addSalary";
    }

    // 处理添加薪资表单提交
    @PostMapping("/add")
    public String addSalary(
            @Valid @ModelAttribute("salaryDTO") SalaryRequestDTO salaryDTO,
            BindingResult bindingResult,
            RedirectAttributes redirectAttributes) {

        if (bindingResult.hasErrors()) {
            redirectAttributes.addFlashAttribute("org.springframework.validation.BindingResult.salaryDTO", bindingResult);
            redirectAttributes.addFlashAttribute("salaryDTO", salaryDTO);
            return "redirect:/salary/add";
        }

        try {
            // 检查是否已为该岗位和部门设置薪资
            if (salaryService.existsByPositionAndDepartment(salaryDTO.getPositionId(), salaryDTO.getDepartmentId())) {
                redirectAttributes.addFlashAttribute("error", "该岗位和部门已设置薪资");
                redirectAttributes.addFlashAttribute("salaryDTO", salaryDTO);
                return "redirect:/salary/add";
            }

            // 添加薪资
            Salary salary = salaryService.addSalary(salaryDTO);
            redirectAttributes.addFlashAttribute("success", "薪资添加成功！ID: " + salary.getSalaryId());
            return "redirect:/salary/list";

        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "添加薪资时发生错误: " + e.getMessage());
            redirectAttributes.addFlashAttribute("salaryDTO", salaryDTO);
            return "redirect:/salary/add";
        }
    }

    @GetMapping("/edit/{salaryId}")
    public String showEditForm(@PathVariable("salaryId") Integer salaryId, Model model) {
        try {
            Salary salary = salaryService.getSalaryById(salaryId);
            SalaryRequestDTO salaryDTO = convertToDTO(salary);
            salaryDTO.setSalaryId(salaryId); // 确保设置 salaryId

            model.addAttribute("salaryDTO", salaryDTO);
            model.addAttribute("positionList", positionService.getAllPositions());
            model.addAttribute("departmentList", departmentService.getAllDepartments());

            return "editSalary";
        } catch (Exception e) {
            model.addAttribute("error", "获取薪资信息失败: " + e.getMessage());
            return "redirect:/salary/list";
        }
    }

    // 处理编辑薪资表单提交

    @PostMapping("/update/{salaryId}")
    public String updateSalary(
            @PathVariable("salaryId") Integer salaryId,
            @Valid @ModelAttribute("salaryDTO") SalaryRequestDTO salaryDTO,
            BindingResult bindingResult,
            RedirectAttributes redirectAttributes) {

        if (bindingResult.hasErrors()) {
            redirectAttributes.addFlashAttribute("org.springframework.validation.BindingResult.salaryDTO", bindingResult);
            redirectAttributes.addFlashAttribute("salaryDTO", salaryDTO);
            return "redirect:/salary/edit/" + salaryId;
        }

        try {
            // 检查是否已存在其他相同岗位和部门的薪资记录
            if (salaryService.existsOtherSalary(salaryId, salaryDTO.getPositionId(), salaryDTO.getDepartmentId())) {
                redirectAttributes.addFlashAttribute("error", "该岗位和部门已有其他薪资记录");
                redirectAttributes.addFlashAttribute("salaryDTO", salaryDTO);
                return "redirect:/salary/edit/" + salaryId;
            }

            // 更新薪资
            salaryService.updateSalary(salaryId, salaryDTO);
            redirectAttributes.addFlashAttribute("success", "薪资更新成功！");
            return "redirect:/salary/list";

        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "更新薪资时发生错误: " + e.getMessage());
            redirectAttributes.addFlashAttribute("salaryDTO", salaryDTO);
            return "redirect:/salary/edit/" + salaryId;
        }
    }

    // 删除薪资信息
    @PostMapping("/delete/{salaryId}")
    public String deleteSalary(
            @PathVariable("salaryId") Integer salaryId,
            RedirectAttributes redirectAttributes) {

        try {
            salaryService.deleteSalary(salaryId);
            redirectAttributes.addFlashAttribute("success", "薪资删除成功！ID: " + salaryId);
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "删除薪资时发生错误: " + e.getMessage());
        }
        return "redirect:/salary/list";
    }

    // 搜索薪资信息
    @GetMapping("/search")
    public String searchSalaries(
            @RequestParam(value = "positionId", required = false) Integer positionId,
            @RequestParam(value = "departmentId", required = false) Integer departmentId,
            Model model) {

        try {
            List<Salary> salaryList = salaryService.getSalariesByPositionAndDepartment(positionId, departmentId);
            model.addAttribute("salaryList", salaryList);

            // 保留搜索条件用于页面显示
            model.addAttribute("positionList", positionService.getAllPositions());
            model.addAttribute("departmentList", departmentService.getAllDepartments());

            if (positionId != null) model.addAttribute("positionId", positionId);
            if (departmentId != null) model.addAttribute("departmentId", departmentId);

        } catch (Exception e) {
            model.addAttribute("error", "搜索薪资时发生错误: " + e.getMessage());
        }

        return "salary";
    }

    // 转换实体为DTO
    private SalaryRequestDTO convertToDTO(Salary salary) {
        SalaryRequestDTO dto = new SalaryRequestDTO();
        dto.setSalaryId(salary.getSalaryId());
        dto.setPositionId(salary.getPositionId());
        dto.setDepartmentId(salary.getDepartmentId());
        dto.setOvertimeSalary(salary.getOvertimeSalary());
        dto.setAttendanceSalary(salary.getAttendanceSalary());
        return dto;
    }
}