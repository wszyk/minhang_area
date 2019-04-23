package com.area.server.minhangareaserver.controller;

import com.area.server.minhangareaserver.pojo.Area;
import com.area.server.minhangareaserver.pojo.Trade;
import com.area.server.minhangareaserver.service.SysAreaService;
import com.area.server.minhangareaserver.service.SysTradeDataService;
import com.area.server.minhangareaserver.service.SysTradeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/sys/")
public class SysTradeDataController {

    @Autowired
    private SysTradeDataService sysTradeDataService;
    @Autowired
    private SysAreaService sysAreaService;
    @Autowired
    private SysTradeService sysTradeService;

    @GetMapping("/list")
    public String list(Model model) {
        // 获得区域的数据
        List<Area> areaList = sysAreaService.getAllDataList();
        model.addAttribute("areaList", areaList);
        // 获得所有的商圈
        List<Trade> tradeList = sysTradeService.getAllTradesByAreaId(-1);
        model.addAttribute("tradeList", tradeList);
        // 获得所有的行业
        List<String> industryList = sysTradeDataService.getAllIndustry(-1);
        model.addAttribute("industryList", industryList);
        return "sysTradeData";
    }

}
