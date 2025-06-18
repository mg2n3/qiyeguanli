package com.cg.dto.request;

import jakarta.validation.constraints.DecimalMin;
import lombok.Data;

import java.math.BigDecimal;

@Data
public class SalaryRequestDTO {
    private Integer salaryId;
    private Integer positionId;
    private Integer departmentId;

    @DecimalMin(value = "0.0", message = "加班工资不能小于0")
    private BigDecimal overtimeSalary;  // 改为BigDecimal

    @DecimalMin(value = "0.0", message = "出勤工资不能小于0")
    private BigDecimal attendanceSalary;  // 改为BigDecimal

    @DecimalMin(value = "0.0", message = "基本工资不能小于0")
    private BigDecimal baseSalary;  // 改为BigDecimal

    @DecimalMin(value = "0.0", message = "奖金不能小于0")
    private BigDecimal bonus;  // 改为BigDecimal


}