package com.fuce.minhang_area.service.impl;

import com.fuce.minhang_area.dao.AreaMapper;
import com.fuce.minhang_area.pojo.Area;
import com.fuce.minhang_area.service.SysAreaService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class SysAreaServiceImpl implements SysAreaService {
    @Autowired
    private AreaMapper areaMapper;
    @Override
    public void insert(Area area) {
        areaMapper.insert(area);
    }
}
