package com.area.server.minhangareaserver.service.impl;

import com.area.server.minhangareaserver.dao.AreaMapper;
import com.area.server.minhangareaserver.pojo.Area;
import com.area.server.minhangareaserver.service.SysAreaService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional
public class SysAreaServiceImpl implements SysAreaService {

    @Autowired
    private AreaMapper areaMapper;
    @Override
    public List<Area> getAllDataList() {
        return areaMapper.getAllDataList();
    }

    @Override
    public Area getDataById(Integer areaid) {
        return areaMapper.getDataById(areaid);
    }

    @Override
    public Integer getDataCount() {
        return areaMapper.getDataCount();
    }

    @Override
    public List<Area> getDataList(int page, int pageSize) {
        return areaMapper.getDataList(page,pageSize);
    }

    @Override
    public void saveData(Area area) {
        areaMapper.saveData(area);
    }

    @Override
    public void editData(Area area) {
        areaMapper.editData(area);
    }

    @Override
    public void deleteDataById(int id) {
        areaMapper.deleteDataById(id);
    }
}
