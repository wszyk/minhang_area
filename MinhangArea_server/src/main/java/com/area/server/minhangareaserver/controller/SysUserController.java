package com.area.server.minhangareaserver.controller;

import com.area.server.minhangareaserver.pojo.Area;
import com.area.server.minhangareaserver.pojo.User;
import com.area.server.minhangareaserver.service.SysAreaService;
import com.area.server.minhangareaserver.service.SysUserService;
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
@RequestMapping("/sys/user")
public class SysUserController {

    @Autowired
    private SysUserService sysUserService;

    @Autowired
    private SysAreaService sysAreaService;

    @GetMapping("/list")
    public String list(){
        return "sysUser";
    }

    /**
     * 获得系统用户的数据
     * @param page
     * @param model
     * @return
     */
    @GetMapping("/getList")
    @ResponseBody
    public Map<String, Object> getList(String page, Model model) {
        Map<String, Object> result = new HashMap<String, Object>();
        Integer _page = Integer.parseInt(page);
        List<Map<String, Object>> roleList = sysUserService.getDataList(_page, 10);
        //todo SQL Exception
        result.put("data", roleList);
        result.put("currentPage", page);
        result.put("pages", sysUserService.getDataCount());
        return result;
    }

    /**
     * 跳转到添加页面
     * @param model
     * @return
     */
    @GetMapping("/addView")
    public String addView(Model model){
        List<Area> areaList = sysAreaService.getAllDataList();
        model.addAttribute("areList",areaList);
        return "sysUserAdd";
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
        String loginName = req.getParameter("loginName");
        String password = req.getParameter("password");
        String role = req.getParameter("role");
        String areaId = req.getParameter("areaId");
        String description = req.getParameter("description");
        User user = new User();
        user.setLoginname(loginName);
        user.setPassword(password);
        user.setRole(Integer.parseInt(role));
        user.setAreaid(Integer.parseInt(areaId));
        user.setDescription(description);
        // 保存
        if (StringUtil.isEmpty(id)) {
            sysUserService.saveData(user);
        }
        // 编辑
        else {
            user.setId(Integer.parseInt(id));
            sysUserService.editData(user);
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
            List<Area> areaList = sysAreaService.getAllDataList();
            User user = sysUserService.getDataById(dataId);
            model.addAttribute("user", user);
            model.addAttribute("areaList", areaList);
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
            sysUserService.deleteDataById(Integer.parseInt(id));
        }
        result.put("code", 0);
        result.put("msg", "删除成功！");
        return result;
    }
    /**-------------------------------登陆---------------------**/
    @GetMapping(value = "/loginView")
    public String loginView(Model model, HttpServletRequest req, HttpServletResponse rep) {
        String serviceName = req.getServerName();
        // 闵行地区
        if (serviceName.contains("minhang")) {
            return "loginMinHang";
        }
        // 静安区
        if (serviceName.contains("jingan")) {
            return "loginJingAn";
        }
        // 宝山区
        if (serviceName.contains("baoshan")) {
            return "loginBaoshan";
        }
        return "login";
    }

    /**
     * 登陆
     * @param req
     * @param rep
     * @return
     */
    @PostMapping(value = "/login")
    @ResponseBody
    public Map<String , Object> login(HttpServletRequest req, HttpServletResponse rep) {
        Map<String, Object> result = new HashMap<String, Object>();
        String loginName = req.getParameter("loginName");
        String password = req.getParameter("password");
        if (StringUtil.isEmpty(loginName)) {
            result.put("code", 1);
            result.put("msg", "请输入登录名！");
            return result;
        }
        if (StringUtil.isEmpty(password)) {
            result.put("code", 1);
            result.put("msg", "请输入密码！");
            return result;
        }
        User user = sysUserService.getUserByName(loginName);
        // 验证用户存在性
        if (user == null) {
            result.put("code", 1);
            result.put("msg", "用户没有注册！");
            return result;
        }
        // 验证密码正确性
        if (password.equals(user.getPassword()) == false) {
            result.put("code", 1);
            result.put("msg", "密码不正确，请重新输入！");
            return result;
        }
        // 保存到缓存中
        req.getSession().setAttribute("loginUser", user);
        // 获得区域的信息
        Area area = sysAreaService.getDataById(user.getAreaid());
        req.getSession().setAttribute("loginArea", area);

        result.put("code", 0);
        result.put("msg", "登录成功！");
        return result;
    }

    /**
     * 注销
     * @param model
     * @param req
     * @param rep
     * @return
     */
    @GetMapping("/loginOut")
    public String loginOut(Model model, HttpServletRequest req, HttpServletResponse rep) {
        req.getSession().removeAttribute("loginUser");
        req.getSession().removeAttribute("loginArea");
        String serviceName = req.getServerName();
        // 闵行地区
        if (serviceName.contains("minhang")) {
            return "loginMinHang";
        }
        // 静安区
        if (serviceName.contains("jingan")) {
            return "loginJingAn";
        }
        // 宝山区
        if (serviceName.contains("baoshan")) {
            return "loginBaoshan";
        }
        return "login";
    }

}
