package com.area.server.minhangareaserver.controller;

import com.area.server.minhangareaserver.pojo.Area;
import com.area.server.minhangareaserver.pojo.User;
import com.area.server.minhangareaserver.service.SysAreaService;
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
@RequestMapping("/sys/area")
public class SysAreaController {

    @Autowired
    private SysAreaService sysAreaService;

    @GetMapping("/list")
    public String list(Model model){
        return "sysArea";
    }

    @GetMapping("/getList")
    public Map<String,Object> getList(String page, Model model){
        Map<String,Object> result = new HashMap<String,Object>();
        int _page = Integer.parseInt(page);
        List<Area> roleList = sysAreaService.getDataList(_page, 10);
        result.put("data", roleList);
        result.put("currentPage", page);
        result.put("pages", sysAreaService.getDataCount());
        return result;
    }

    /**
     * 跳转到添加页面
     * @param model
     * @return
     */
    @GetMapping("/addView")
    public String addView(Model model){
        return "sysAreaAdd";
    }

    /**
     * 保存
     * @param req
     * @param rep
     * @return
     */
    @PostMapping("/addSave")
    @ResponseBody
    public Map<String,Object> addSave(HttpServletRequest req, HttpServletResponse rep){
        Map<String, Object> result = new HashMap<String, Object>();
        String id = req.getParameter("id");
        String code = req.getParameter("code");
        String areaName = req.getParameter("areaName");
        Area area = new Area();
        area.setCode(code);
        area.setAreaname(areaName);
        // 保存
        if (StringUtil.isEmpty(id)) {
            sysAreaService.saveData(area);
        }
        // 编辑
        else {
            area.setId(Integer.parseInt(id));
            sysAreaService.editData(area);
        }
        result.put("code", 0);
        result.put("msg", "添加成功！");
        return result;
    }

    /**
     *编辑
     * @param dataId
     * @param model
     * @return
     */
    @GetMapping(value = "/editView/{dataId}")
    public String editView(@PathVariable int dataId, Model model) {
        Area area = sysAreaService.getDataById(dataId);
        model.addAttribute("area", area);
        return "sysUserAdd";
    }

    /**
     * 删除
     * @param req
     * @param rep
     * @return
     */
    @PostMapping("/delete")
    public Map<String,Object> delete (HttpServletRequest req,HttpServletResponse rep){
        Map<String, Object> result = new HashMap<String, Object>();
        String id = req.getParameter("id");
        if (StringUtil.isEmpty(id) == false) {
            // 2、删除
            sysAreaService.deleteDataById(Integer.parseInt(id));
        }
        result.put("code", 0);
        result.put("msg", "删除成功！");
        return result;
    }
}
