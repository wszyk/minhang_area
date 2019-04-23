package com.area.server.minhangareaserver.dao;

import com.area.server.minhangareaserver.pojo.Trade;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

public interface TradeMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Trade record);

    int insertSelective(Trade record);

    Trade selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Trade record);

    int updateByPrimaryKey(Trade record);

    List<Map<String, Object>> getDataList(@Param("page") int page,@Param("pageSize") int pageSize);

    Integer getDataCount();

    void saveData(Trade trade);

    void editData(Trade trade);

    Trade getDataById(int dataId);

    void deleteDataById(int id);

    List<Trade> getAllTradesByAreaId(int areaId);
}