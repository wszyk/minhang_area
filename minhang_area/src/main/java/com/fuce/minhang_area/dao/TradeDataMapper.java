package com.fuce.minhang_area.dao;

import com.fuce.minhang_area.pojo.TradeData;

public interface TradeDataMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(TradeData record);

    int insertSelective(TradeData record);

    TradeData selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(TradeData record);

    int updateByPrimaryKey(TradeData record);
}