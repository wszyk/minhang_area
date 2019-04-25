package com.fuce.minhang_area.service.impl;

import com.fuce.minhang_area.DTO.TradeDataDTO;
import com.fuce.minhang_area.dao.TradeDataMapper;
import com.fuce.minhang_area.pojo.TradeData;
import com.fuce.minhang_area.service.SysTradeDataService;
import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Transactional
@Service
public class SysTradeDataServiceImpl implements SysTradeDataService {

    @Autowired
    private TradeDataMapper tradeDataMapper;
    @Value("${user.pageSize}")
    private Integer tradedataPageSize;
    @Override
    public List<TradeDataDTO> getAll() {
        return tradeDataMapper.getAll();
    }

    @Override
    public Page<TradeDataDTO> getWithPage(Integer pageNum) {
        PageHelper.startPage(pageNum,tradedataPageSize);
        Page<TradeDataDTO> tradeDatas =  tradeDataMapper.selectWithPage();
        return tradeDatas;
    }

    @Override
    public void delete(Integer id) {
        tradeDataMapper.deleteByPrimaryKey(id);
    }

    @Override
    public void insert(TradeData tradeData) {
        tradeDataMapper.insert(tradeData);
    }

    @Override
    public void update(TradeData tradeData) {
        tradeDataMapper.updateByPrimaryKey(tradeData);
    }

}
