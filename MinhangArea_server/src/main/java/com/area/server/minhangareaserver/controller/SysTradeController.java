package com.area.server.minhangareaserver.controller;

import com.area.server.minhangareaserver.pojo.Area;
import com.area.server.minhangareaserver.pojo.Trade;
import com.area.server.minhangareaserver.service.SysAreaService;
import com.area.server.minhangareaserver.service.SysTradeService;
import com.github.pagehelper.util.StringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/sys/trade")
public class SysTradeController {

    @Autowired
    private SysTradeService sysTradeService;
    @Autowired
    private SysAreaService sysAreaService;

    @GetMapping("/list")
    public String list(Model model){
        return "sysTrade";
    }

    /**
     * 获得商圈的数据
     *
     * @param page
     * @param model
     * @return
     */
    @GetMapping("/getList")
    @ResponseBody
    public Map<String,Object> getList(String page, Model model){
        Map<String,Object> result = new HashMap<String,Object>();
        int _page = Integer.parseInt(page);
        List<Map<String, Object>> roleList = sysTradeService.getDataList(_page, 10);
        result.put("data", roleList);
        result.put("currentPage", page);
        result.put("pages", sysTradeService.getDataCount());
        return result;
    }
    /**
     * 跳转到添加页面
     * @param model
     * @return
     */
    @GetMapping(value = "/addView")
    public String addView(Model model) {
        List<Area> areaList = sysAreaService.getAllDataList();
        model.addAttribute("areaList", areaList);
        return "sysTradeAdd";
    }

    /**
     * 保存
     * @return
     */
    @PostMapping(value = "/addSave.do")
    @ResponseBody
    public Map<String , Object> addSave(HttpServletRequest req, HttpServletResponse rep) {
        Map<String, Object> result = new HashMap<String, Object>();
        String id = req.getParameter("id");
        String tradeCode = req.getParameter("tradeCode");
        String tradeName = req.getParameter("tradeName");
        String areaId = req.getParameter("areaId");
        String lng = req.getParameter("lng");
        String lat = req.getParameter("lat");
        String flg = req.getParameter("flg");
        Trade trade = new Trade();
        trade.setTradecode(tradeCode);
        trade.setTradename(tradeName);
        trade.setAreaid(Integer.parseInt(areaId));
        trade.setLng(Double.parseDouble(lng));
        trade.setLat(Double.parseDouble(lat));
        trade.setFlg(Integer.parseInt(flg));
        // 保存
        if (StringUtil.isEmpty(id)) {
            sysTradeService.saveData(trade);
        }
        // 编辑
        else {
            trade.setId(Integer.parseInt(id));
            sysTradeService.editData(trade);
        }
        result.put("code", 0);
        result.put("msg", "添加成功！");
        return result;
    }

    /**
     * 编辑页面
     * @param dataId
     * @param model
     * @return
     */
    @GetMapping(value = "/editView/{dataId}")
    public String editView(@PathVariable int dataId, Model model) {
        List<Area> areaList = sysAreaService.getAllDataList();
        Trade trade = sysTradeService.getDataById(dataId);
        model.addAttribute("trade", trade);
        model.addAttribute("areaList", areaList);
        return "sysTradeAdd";
    }

    /**
     * 删除
     * @param req
     * @param rep
     * @return
     */
    @PostMapping(value = "/delete.do")
    @ResponseBody
    public Map<String , Object> delete(HttpServletRequest req, HttpServletResponse rep) {
        Map<String, Object> result = new HashMap<String, Object>();
        String id = req.getParameter("id");
        if (StringUtil.isEmpty(id) == false) {
            // 2、删除
            sysTradeService.deleteDataById(Integer.parseInt(id));
        }
        result.put("code", 0);
        result.put("msg", "删除成功！");
        return result;
    }

}
