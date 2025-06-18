package com.cg.entity;

import lombok.Data;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Date;

@Data
public class Salary {
    private Integer salaryId;       // 映射 salary_id
    private Integer positionId;     // 映射 position_id
    private Integer departmentId;   // 映射 department_id
    private BigDecimal overtimeSalary;  // 映射 overtime_salary
    private BigDecimal attendanceSalary; // 映射 attendance_salary
    private LocalDateTime createTime;   // 映射 create_time

    // 添加 Date 类型转换方法（用于 JSP 格式化）
    public Date getCreateTimeAsDate() {
        return createTime != null ?
                Date.from(createTime.atZone(ZoneId.systemDefault()).toInstant()) :
                null;
    }

    // 添加格式化字符串方法（替代方案）
    public String getFormattedCreateTime() {
        return createTime != null ?
                createTime.toString().replace('T', ' ') :
                "";
    }
}