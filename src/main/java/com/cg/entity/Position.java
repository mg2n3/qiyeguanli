package com.cg.entity;

import lombok.Data;

import java.math.BigDecimal;
import java.util.Date;

@Data
public class Position {
    private Integer id;
    private String positionName;
    private Integer positionId;
    private String code;
    private Date createTime;
    private Integer status;
    private BigDecimal positionSalary;
}
