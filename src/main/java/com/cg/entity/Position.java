package com.cg.entity;

import lombok.Data;

import java.util.Date;

@Data
public class Position {
    private String positionName;
    private Integer positionId;
    private String code;
    private Date createTime;
    private Integer status;
}
