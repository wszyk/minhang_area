package com.area.server.minhangareaserver.service;import java.util.List;import java.util.Map;public interface SysTradeDataService {	public List<Map<String, Object>> getDataList(final int page,                                                 final int pageSize, final Map<String, String> map);	public List<String> getAllIndustry(final int areaId);}