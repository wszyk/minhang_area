package com.area.server.minhangareaserver.service;

import com.area.server.minhangareaserver.pojo.Area;

import java.util.List;

public interface SysAreaService {
    List<Area> getAllDataList();

    Area getDataById(Integer areaid);

    Integer getDataCount();
    List<Area> getDataList(int page, int pageSize);

    void saveData(Area area);

    void editData(Area area);

    void deleteDataById(int id);
}
