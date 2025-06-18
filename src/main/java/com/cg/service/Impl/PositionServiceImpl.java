package com.cg.service.Impl;

import com.cg.entity.Position;
import com.cg.mapper.PositionMapper;
import com.cg.service.PositionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class PositionServiceImpl implements PositionService {
    @Autowired
    PositionMapper positionMapper;
    @Override
    public List<Position> positionList(String code, String positionName, Integer status) {
        return positionMapper.positionList(code,positionName,status);
    }

    @Override
    public Position findPositionByName(String positionName) {
        return positionMapper.findPositionByName(positionName);
    }

    @Override
    public void addposition(String positionName, String code) {
        positionMapper.addposition(positionName,code);
    }

    @Override
    public Position findPositionById(Integer positionId) {
        return positionMapper.findPositionById(positionId);
    }

    @Override
    public int findByName(String positionName,Integer positionId) {
        return positionMapper.findByName(positionName,positionId);
    }

    @Override
    public void editPosition(String positionName, Integer status, String code, Integer positionId) {
        positionMapper.editPosition(positionName,status,code,positionId);
    }

    @Override
    public void deleteposition(Integer positionId) {
        positionMapper.deleteposition(positionId);
    }
    @Override
    public List<Position> getAllPositions() {
        // 实现方法逻辑
        return positionMapper.positionList(null,null,null);
    }
    @Override
    public Position getPositionById(Integer id) {
        return positionMapper.getPositionById(id);
    }
}
