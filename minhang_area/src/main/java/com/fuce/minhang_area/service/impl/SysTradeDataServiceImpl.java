package com.fuce.minhang_area.service.impl;

import com.fuce.minhang_area.DTO.TradeDataDTO;
import com.fuce.minhang_area.dao.TradeDataMapper;
import com.fuce.minhang_area.service.SysTradeDataService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Transactional
@Service
public class SysTradeDataServiceImpl implements SysTradeDataService {

    @Autowired
    private TradeDataMapper tradeDataMapper;

    @Override
    public List<TradeDataDTO> getAll() {
        return tradeDataMapper.getAll();
    }
}
