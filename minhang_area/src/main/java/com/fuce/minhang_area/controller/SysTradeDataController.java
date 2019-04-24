package com.fuce.minhang_area.controller;

import com.fuce.minhang_area.DTO.TradeDataDTO;
import com.fuce.minhang_area.pojo.Area;
import com.fuce.minhang_area.pojo.TradeData;
import com.fuce.minhang_area.service.SysAreaService;
import com.fuce.minhang_area.service.SysTradeDataService;
import com.github.pagehelper.Page;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/sys/tradedata")
public class SysTradeDataController {
    @Autowired
    private SysTradeDataService sysTradeDataService;
    @Autowired
    private SysAreaService sysAreaService;

    /**
     * 查询所有商圈数据
     * @return
     */

    @GetMapping("/getAll")
    public List<TradeDataDTO> getAll(){
        List<TradeDataDTO> tradeDataDTO = sysTradeDataService.getAll();
        return tradeDataDTO;
    }
    @GetMapping("/getWithPage")
    public PageInfo getWithPage(@RequestParam(required = false,defaultValue = "1")Integer pageNum){
        Page<TradeDataDTO> page = sysTradeDataService.getWithPage(pageNum);
        PageInfo<TradeDataDTO> pageInfo = page.toPageInfo();
        return pageInfo;
    }
    @PostMapping("/delete")
    public void delete(@RequestParam Integer id){
        sysTradeDataService.delete(id);
    }
    @PostMapping("/add")
    public void add(@RequestBody TradeData tradeData,@RequestParam String[] ids){
        sysTradeDataService.insert(tradeData);
        Area area = new Area();
        for(String s:ids){
            area.setId(tradeData.getId());
            sysAreaService.insert(area);
        }
    }


}
