package com.cg.common;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class Result<T>{
    //响应码（1表示成功，0表示失败）
    private int code;
    //响应消息
    private String message;
    //响应数据内容
    private T data;

    public Result() {

    }
}