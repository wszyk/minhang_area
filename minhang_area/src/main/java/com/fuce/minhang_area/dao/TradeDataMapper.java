package com.fuce.minhang_area.dao;

import com.fuce.minhang_area.DTO.TradeDataDTO;
import com.fuce.minhang_area.pojo.TradeData;
import com.github.pagehelper.Page;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface TradeDataMapper {
    int deleteByPrimaryKey(@Param("id") Integer id);

    int insert(TradeData record);

    int insertSelective(TradeData record);

    TradeData selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(TradeData record);

    int updateByPrimaryKey(TradeData record);

    List<TradeDataDTO> getAll();

    Page<TradeDataDTO> selectWithPage();
}