package com.area.server.minhangareaserver.dao;

import com.area.server.minhangareaserver.pojo.TradeData;

import java.util.List;
import java.util.Map;

public interface TradeDataMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(TradeData record);

    int insertSelective(TradeData record);

    TradeData selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(TradeData record);

    int updateByPrimaryKey(TradeData record);

    List<String> getAllIndustry(int areaId);

    List<Map<String, Object>> getDataList(int page, int pageSize, Map<String, String> map);
}