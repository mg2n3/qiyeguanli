package com.cg.service;

import com.cg.entity.Position;

import java.util.List;

public interface PositionService {
    List<Position> positionList(String code, String positionName, Integer status);

    Position findPositionByName(String positionName);

    void addposition(String positionName, String code);

    Position findPositionById(Integer positionId);

    int findByName(String positionName, Integer positionId);

    void editPosition(String positionName, Integer status, String code, Integer positionId);

    void deleteposition(Integer positionId);

    List<Position> getAllPositions();

    Position getPositionById(Integer id);

}
