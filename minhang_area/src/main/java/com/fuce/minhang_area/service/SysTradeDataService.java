package com.fuce.minhang_area.service;

import com.fuce.minhang_area.DTO.TradeDataDTO;
import com.fuce.minhang_area.pojo.TradeData;
import com.github.pagehelper.Page;

import java.util.List;

public interface SysTradeDataService {
    List<TradeDataDTO> getAll();

    Page<TradeDataDTO> getWithPage(Integer pageNum);

    void delete(Integer id);

    void insert(TradeData tradeData);

    void update(TradeData tradeData);
}
