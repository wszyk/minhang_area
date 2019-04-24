package com.fuce.minhang_area.service;

import com.fuce.minhang_area.DTO.TradeDataDTO;
import com.github.pagehelper.Page;

import java.util.List;

public interface SysTradeDataService {
    List<TradeDataDTO> getAll();

    Page<TradeDataDTO> getWithPage(Integer pageNum);
}
