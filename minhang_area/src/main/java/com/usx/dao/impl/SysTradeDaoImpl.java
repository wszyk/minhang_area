package com.usx.dao.impl;import java.util.ArrayList;import java.util.HashMap;import java.util.List;import java.util.Map;import org.springframework.beans.factory.annotation.Autowired;import org.springframework.stereotype.Repository;import com.usx.dao.SysTradeDao;import com.usx.model.Trade;import com.usx.util.HibernateUtil;import com.usx.util.StringUtil;@Repositorypublic class SysTradeDaoImpl implements SysTradeDao {	@Autowired	private HibernateUtil hibernateUtil;		@SuppressWarnings("unchecked")	@Override	public List<Map<String, Object>> getDataList(int page, int pageSize) {		String query = "SELECT t.id, t.areaId, a.areaName, t.tradeCode, t.tradeName, t.lng, t.lat, t.flg  FROM trade t, area a WHERE t.areaId = a.id limit "				+ (page - 1) * pageSize + ", " + pageSize;		List<Object[]> objects = hibernateUtil.fetchAll(query);		List<Map<String, Object>> resultList = new ArrayList<Map<String, Object>>();		for (Object[] object : objects) {			int id = (Integer) object[0];			int areaId = (Integer) object[1];			String areaName = (String) object[2];			String tradeCode = (String) object[3];			String tradeName = (String) object[4];			double lng = (Double) object[5];			double lat = (Double) object[6];			int flg = (Integer) object[7];						Map<String, Object> map = new HashMap<String, Object>();			map.put("id", id);			map.put("areaId", areaId);			map.put("areaName", areaName);			map.put("tradeCode", tradeCode);			map.put("tradeName", tradeName);			map.put("lng", lng);			map.put("lat", lat);			map.put("flg", flg);			resultList.add(map);		}		return resultList;	}	@SuppressWarnings("unchecked")	@Override	public int getDataCount() {		String query = "SELECT count(id) from trade";		List<Object> objects = hibernateUtil.fetchAll(query);		Object _count = objects.get(0);		return Integer.parseInt(_count.toString());	}		public void saveData(Trade trade) {		hibernateUtil.create(trade);	}	public void editData(Trade trade) {		hibernateUtil.update(trade);	}		public Trade getDataById(final int dataId) {		return hibernateUtil.fetchById(dataId, Trade.class);	}		public void deleteDataById(final int id) {		hibernateUtil.delete(id, Trade.class);	}		@SuppressWarnings("unchecked")	public List<Trade> getAllTradesByAreaId(final int areaId) {		String query = "SELECT t.id, t.areaId, t.tradeCode, t.tradeName, t.lng, t.lat, t.flg  FROM trade t WHERE 1=1";		if (areaId > 0) {			query += " and t.areaId = " + areaId;		}		List<Object[]> objects = hibernateUtil.fetchAll(query);		List<Trade> resultList = new ArrayList<Trade>();		for (Object[] object : objects) {			int id = (Integer) object[0];			int _areaId = (Integer) object[1];			String tradeCode = (String) object[2];			String tradeName = (String) object[3];			double lng = (Double) object[4];			double lat = (Double) object[5];			int flg = (Integer) object[6];						Trade trade = new Trade();			trade.setId(id);			trade.setAreaId(_areaId);			trade.setTradeCode(tradeCode);			trade.setTradeName(tradeName);			trade.setLng(lng);			trade.setLat(lat);			trade.setFlg(flg);			resultList.add(trade);		}		return resultList;	}		@SuppressWarnings("unchecked")	public List<Trade> getTradesByKey(final String key, final int areaId) {		String query = "SELECT t.id, t.areaId, t.tradeCode, t.tradeName, t.lng, t.lat, t.flg  FROM trade t WHERE t.areaId = "						+ areaId + " AND t.tradeName LIKE '%"						+ key +"%'";		List<Object[]> objects = hibernateUtil.fetchAll(query);		List<Trade> resultList = new ArrayList<Trade>();		for (Object[] object : objects) {			int id = (Integer) object[0];			int _areaId = (Integer) object[1];			String tradeCode = (String) object[2];			String tradeName = (String) object[3];			double lng = (Double) object[4];			double lat = (Double) object[5];			int flg = (Integer) object[6];						Trade trade = new Trade();			trade.setId(id);			trade.setAreaId(_areaId);			trade.setTradeCode(tradeCode);			trade.setTradeName(tradeName);			trade.setLng(lng);			trade.setLat(lat);			trade.setFlg(flg);			resultList.add(trade);		}		return resultList;	}		@SuppressWarnings("unchecked")	public List<Trade> getTradesByIds(final String tradeIds) {		String query = "SELECT t.id, t.areaId, t.tradeCode, t.tradeName, t.lng, t.lat, t.flg  FROM trade t WHERE t.id in ("				+ tradeIds + ")";		List<Object[]> objects = hibernateUtil.fetchAll(query);		List<Trade> resultList = new ArrayList<Trade>();		for (Object[] object : objects) {			int id = (Integer) object[0];			int _areaId = (Integer) object[1];			String tradeCode = (String) object[2];			String tradeName = (String) object[3];			double lng = (Double) object[4];			double lat = (Double) object[5];			int flg = (Integer) object[6];						Trade trade = new Trade();			trade.setId(id);			trade.setAreaId(_areaId);			trade.setTradeCode(tradeCode);			trade.setTradeName(tradeName);			trade.setLng(lng);			trade.setLat(lat);			trade.setFlg(flg);			resultList.add(trade);		}		return resultList;	}	}