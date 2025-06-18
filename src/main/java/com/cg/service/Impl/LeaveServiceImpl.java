package com.cg.service.Impl;

import com.cg.entity.Leave;
import com.cg.mapper.LeaveMapper;
import com.cg.service.LeaveService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class LeaveServiceImpl implements LeaveService {
    @Autowired
    LeaveMapper leaveMapper;
    @Override
    public List<Leave> leaveList(Integer leaveType, Integer status,Integer employeeId,Integer departmentId) {
        return leaveMapper.leaveList(leaveType,status,employeeId,departmentId);
    }

    @Override
    public void editLeave(Integer leaveId, Integer status, String username) {
        leaveMapper.editLeave(leaveId,status,username);
    }

    @Override
    public Leave findLeaveById(Integer leaveId) {
        return leaveMapper.findLeaveById(leaveId);
    }

    @Override
    public void addLeave(Integer employeeId, Integer leaveType, String startDate, String endDate, String reason, Integer status,Integer departmentId) {
        leaveMapper.addLeave(employeeId,leaveType,startDate,endDate,reason,status,departmentId);
    }

    @Override
    public void deleteLeave(Integer leaveId) {
        leaveMapper.deleteLeave(leaveId);
    }
}
