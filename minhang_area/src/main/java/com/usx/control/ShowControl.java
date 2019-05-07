package com.usx.control;import java.text.ParseException;import java.text.SimpleDateFormat;import java.util.ArrayList;import java.util.Calendar;import java.util.HashMap;import java.util.List;import java.util.Map;import javax.servlet.http.HttpServletRequest;import javax.servlet.http.HttpServletResponse;import org.springframework.beans.factory.annotation.Autowired;import org.springframework.stereotype.Controller;import org.springframework.ui.Model;import org.springframework.web.bind.annotation.RequestMapping;import org.springframework.web.bind.annotation.RequestMethod;import org.springframework.web.bind.annotation.ResponseBody;import com.usx.model.Trade;import com.usx.service.SysTradeDataService;import com.usx.service.SysTradeService;import com.usx.util.StringUtil;/** *  * @author ok *  */@Controller@RequestMapping("/app")public class ShowControl {		@Autowired	private SysTradeService sysTradeService;	@Autowired	private SysTradeDataService sysTradeDataService;		@SuppressWarnings("unchecked")	@RequestMapping(value = "/show", method = RequestMethod.GET)      public String list(Model model, HttpServletRequest req, HttpServletResponse rep) {		// 1、获得登录用户的数据		Object loginUser = req.getSession().getAttribute("loginUser");		Map<String, Object> user = (Map<String, Object>) StringUtil.objectToMap(loginUser);		int areaId = (Integer) user.get("areaId");		// 获得所有的行业		List<String> industryList = sysTradeDataService.getAllIndustry(areaId);		model.addAttribute("industryList", industryList);		int nowYear = Integer.parseInt(new SimpleDateFormat("yyyy").format(Calendar.getInstance().getTime()));		int startYear = nowYear-1;		String startMonth = "01";		int endYear = nowYear;		String endMonth = "12";		model.addAttribute("nowYear", nowYear);		model.addAttribute("startYear", startYear);		model.addAttribute("startMonth", startMonth);		model.addAttribute("endYear", endYear);		model.addAttribute("endMonth", endMonth);		return "app/show";    }		/**	 * 获得登录用户所在区域的所有商圈和商业体	 * @param req	 * @param rep	 * @return	 */	@SuppressWarnings("unchecked")	@RequestMapping(value = "/getTradeList.do", method = RequestMethod.GET)  	@ResponseBody	public Map<String, Object> getTradeList(HttpServletRequest req, HttpServletResponse rep) {		Map<String, Object> result = new HashMap<String, Object>();		// 1、获得登录用户的数据		Object loginUser = req.getSession().getAttribute("loginUser");		Map<String, Object> user = (Map<String, Object>) StringUtil.objectToMap(loginUser);		int areaId = (Integer) user.get("areaId");		// 2、获得所在区域的商圈		List<Trade> resultList = sysTradeService.getAllTradesByAreaId(areaId);		List<Trade> tradeList = new ArrayList<Trade>();		List<Trade> businessList = new ArrayList<Trade>();		// 3、获得所在区域商业体的数据		for (Trade trade : resultList) {			if (trade.getFlg() == 0) {				tradeList.add(trade);			}			else if (trade.getFlg() == 1) {				businessList.add(trade);			}		}		result.put("tradeList", tradeList);		result.put("businessList", businessList);		result.put("code", 0);		result.put("msg", "操作成功！");		return result;	}		/**	 * 检索	 * @param req	 * @param rep	 * @return	 */	@SuppressWarnings("unchecked")	@RequestMapping(value = "/search.do", method = RequestMethod.POST)  	@ResponseBody	public Map<String, Object> search(HttpServletRequest req, HttpServletResponse rep) {		Map<String, Object> result = new HashMap<String, Object>();		// 1、获得登录用户的数据		Object loginUser = req.getSession().getAttribute("loginUser");		Map<String, Object> user = (Map<String, Object>) StringUtil.objectToMap(loginUser);		int areaId = (Integer) user.get("areaId");		String key = req.getParameter("key");		if (StringUtil.isEmpty(key)) {			result.put("code", 1);			result.put("msg", "请输入检索内容！");			return result;		}		List<Trade> resultList = sysTradeService.getTradesByKey(key, areaId);		result.put("data", resultList);		result.put("code", 0);		result.put("msg", "操作成功！");		return result;	}		/**	 * 总量分析	 * @param req	 * @param rep	 * @return	 * @throws ParseException 	 */	@SuppressWarnings("unchecked")	@RequestMapping(value = "/loadTotalAnalysis.do", method = RequestMethod.POST)  	@ResponseBody	public Map<String, Object> loadTotalAnalysis(HttpServletRequest req, HttpServletResponse rep) throws ParseException {		Map<String, Object> result = new HashMap<String, Object>();		String selectNodes = req.getParameter("selectNodes");		String selectTime = req.getParameter("selectTime");		String selectContent = req.getParameter("selectContent");		if (StringUtil.isEmpty(selectNodes)) {			result.put("code", 1);			result.put("msg", "请选择商圈或商业体！");			return result;		}		// 1、获得登录用户的数据		Object loginUser = req.getSession().getAttribute("loginUser");		Map<String, Object> user = (Map<String, Object>) StringUtil.objectToMap(loginUser);		int areaId = (Integer) user.get("areaId");		// 1、获得最新的时间//		Date maxDate = sysTradeDataService.getMaxDateByTradeIds(selectNodes);		String formatTime = StringUtil.getFormatSelectTime(selectTime);		// 2、商圈内行业的占比信息		List<Map<String, Object>> dataList = sysTradeDataService				.loadTotalAnalysis(formatTime, selectContent, selectNodes, areaId);		// 3、获得该商圈或者商业体的信息//		List<Trade> tradeList = sysTradeService.getTradesByIds(selectNodes);		// 4、获得该商圈的相关业绩		List<Map<String, Object>> tradeDataList = sysTradeDataService				.loadTradeTotalAnalysis(formatTime, selectContent, selectNodes, areaId);		// 5、整合相关的数据//		Map<String, Object> tradeMap = sysTradeService.formatTradeData(tradeList, tradeDataList);		result.put("tradeDataList", tradeDataList);		result.put("dataList", dataList);		result.put("code", 0);		result.put("msg", "操作成功！");		return result;	}		/**	 * 加载趋势的数据	 * @param req	 * @param rep	 * @return	 * @throws ParseException	 */	@SuppressWarnings("unchecked")	@RequestMapping(value = "/loadTrendAnalysis.do", method = RequestMethod.POST)  	@ResponseBody	public Map<String, Object> loadTrendAnalysis(HttpServletRequest req, HttpServletResponse rep) throws ParseException {		Map<String, Object> result = new HashMap<String, Object>();		String selectNodes = req.getParameter("selectNodes");		String selectTime = req.getParameter("selectTime");		String selectContent = req.getParameter("selectContent");		if (StringUtil.isEmpty(selectNodes)) {			result.put("code", 1);			result.put("msg", "请选择商圈或商业体！");			return result;		}		// 1、获得登录用户的数据		Object loginUser = req.getSession().getAttribute("loginUser");		Map<String, Object> user = (Map<String, Object>) StringUtil.objectToMap(loginUser);		int areaId = (Integer) user.get("areaId");		// 1、获得最新的时间//		Date maxDate = sysTradeDataService.getMaxDateByTradeIds(selectNodes);		String formatTime = StringUtil.getFormatSelectTime(selectTime);		List<Map<String, Object>> dataList = sysTradeDataService				.loadTrendAnalysis(formatTime, selectContent, selectNodes, areaId);		result.put("data", dataList);		result.put("code", 0);		result.put("msg", "操作成功！");		return result;	}		/**	 * 加载关系数据	 * 	 * @param req	 * @param rep	 * @return	 * @throws ParseException	 */	@SuppressWarnings("unchecked")	@RequestMapping(value = "/loadCompareAnalysis.do", method = RequestMethod.POST)  	@ResponseBody	public Map<String, Object> loadCompareAnalysis(HttpServletRequest req, HttpServletResponse rep) throws ParseException {		Map<String, Object> result = new HashMap<String, Object>();		String selectNodes = req.getParameter("selectNodes");		String selectTime = req.getParameter("selectTime");		String selectContent = req.getParameter("selectContent");		if (StringUtil.isEmpty(selectNodes)) {			result.put("code", 1);			result.put("msg", "请选择商圈或商业体！");			return result;		}		// 1、获得登录用户的数据		Object loginUser = req.getSession().getAttribute("loginUser");		Map<String, Object> user = (Map<String, Object>) StringUtil.objectToMap(loginUser);		int areaId = (Integer) user.get("areaId");		// 1、获得最新的时间//		Date maxDate = sysTradeDataService.getMaxDateByTradeIds(selectNodes);//		String formatTime = StringUtil.getFormatSelectTime(selectTime);		List<Map<String, Object>> dataList = sysTradeDataService				.loadCompareAnalysis(selectTime, selectContent, selectNodes, areaId);		// 获得交易额，商户数，交易笔数三者之间的关系数据		List<Map<String, Object>> dataSalesList = sysTradeDataService				.loadTradeCompareAnalysis(selectTime, selectContent, selectNodes, areaId);		result.put("data", dataList);		result.put("tradeData", dataSalesList);		result.put("code", 0);		result.put("msg", "操作成功！");		return result;	}}