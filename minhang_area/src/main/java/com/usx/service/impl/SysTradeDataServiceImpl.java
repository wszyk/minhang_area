package com.usx.service.impl;import java.text.ParseException;import java.util.Date;import java.util.List;import java.util.Map;import com.usx.dao.IndustryDao;import com.usx.dao.ShopMallDao;import com.usx.dao.ShopMallSalesDao;import com.usx.model.*;import org.springframework.beans.factory.annotation.Autowired;import org.springframework.stereotype.Service;import org.springframework.transaction.annotation.Transactional;import com.usx.dao.SysTradeDataDao;import com.usx.service.SysTradeDataService;import com.usx.util.StringUtil;@Service@Transactionalpublic class SysTradeDataServiceImpl implements SysTradeDataService {    @Autowired    private SysTradeDataDao sysTradeDataDao;    @Autowired    private ShopMallSalesDao shopMallSalesDao;    @Autowired    private ShopMallDao shopMallDao;    @Autowired    private IndustryDao industryDao;    public List<Map<String, Object>> getDataList(final int page,                                                 final int pageSize, final Map<String, String> map) {        return sysTradeDataDao.getDataList(page, pageSize, map);    }    public int getDataCount(final Map<String, String> _map) {        return sysTradeDataDao.getDataCount(_map);    }    public void saveData(TradeData tradeData) {        sysTradeDataDao.saveData(tradeData);    }    public void editData(TradeData tradeData) {        sysTradeDataDao.editData(tradeData);    }    public TradeData getDataById(final int dataId) {        return sysTradeDataDao.getDataById(dataId);    }    public void deleteDataById(final int id) {        sysTradeDataDao.deleteDataById(id);    }    public void saveImport(List<List<Object>> list, String areaId, List<Trade> tradeList) throws ParseException {        //TODO fix excel init        int i = 0;        for (List<Object> object : list) {            if (i++ == 0)                continue; // 表头不读取            if (object == null || object.size() == 0)                break; // 读取到空结束            // 名称            String shopMallName = object.get(0).toString().trim();            ShopMall shopMall = new ShopMall();            shopMall.setName(shopMallName);            ShopMallSales shopMallSales = new ShopMallSales();            shopMallSales.setShop_mall_id(shopMall.getId());            Industry industry = new Industry();            industry.setName(shopMall.getName());            if (shopMallName == null) {                continue;            }            if (industry == null) {                continue;            }            //月份            String saleTime = object.get(2).toString();            shopMallSales.setSale_time(StringUtil.parse(saleTime));            // 销售额(万元)            String sales = object.get(3).toString();            shopMallSales.setSales(Double.parseDouble(sales));            shopMallSales.setShop_mall_id(shopMall.getId());            // 保存            shopMallSalesDao.saveData(shopMallSales);        }    }    private Trade getTradeIdByName(List<Trade> tradeList, String tradeName) {        Trade result = null;        for (Trade trade : tradeList) {            if (tradeName.equals(trade.getTradeName())) {                result = trade;                break;            }        }        return result;    }    public Date getMaxDateByTradeIds(final String tradeIds) {        return sysTradeDataDao.getMaxDateByTradeIds(tradeIds);    }    public List<Map<String, Object>> loadTotalAnalysis(final String formatTime, final String selectContent, final String tradeIds, final int areaId) {        return sysTradeDataDao.loadTotalAnalysis(formatTime, selectContent, tradeIds, areaId);    }    public List<Map<String, Object>> loadTradeTotalAnalysis(final String formatTime, final String selectContent,                                                            final String tradeIds, final int areaId) {        return sysTradeDataDao.loadTradeTotalAnalysis(formatTime, selectContent, tradeIds, areaId);    }    public List<Map<String, Object>> loadTrendAnalysis(final String formatTime, final String selectContent,                                                       final String tradeIds, final int areaId) {        return sysTradeDataDao.loadTrendAnalysis(formatTime, selectContent, tradeIds, areaId);    }    public List<Map<String, Object>> loadCompareAnalysis(final String formatTime, final String selectContent,                                                         final String tradeIds, final int areaId) {        return sysTradeDataDao.loadCompareAnalysis(formatTime, selectContent, tradeIds, areaId);    }    public List<Map<String, Object>> loadTradeCompareAnalysis(final String formatTime, final String selectContent,                                                              final String tradeIds, final int areaId) {        return sysTradeDataDao.loadTradeCompareAnalysis(formatTime, selectContent, tradeIds, areaId);    }    public List<String> getAllIndustry(final int areaId) {        return sysTradeDataDao.getAllIndustry(areaId);    }    public List<Map<String, Object>> getDataByKeys(final String areaId, final String tradeId, final String industry, final String dateStart, final String dateEnd) {        return sysTradeDataDao.getDataByKeys(areaId, tradeId, industry, dateStart, dateEnd);    }}