package com.usx.util;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.UUID;

import org.apache.commons.lang.StringUtils;

public class StringUtil {
	
	private static String defaultDatePattern = "yyyy-MM-dd"; 
	
	/**
	 * 生成UUID
	 * @return
	 */
	public static String getUUID() {
        return UUID.randomUUID().toString().replace("-", "");  
    }
	
	public static Map<?, ?> objectToMap(Object obj) {
        if (obj == null) {
            return null;
        }
        return new org.apache.commons.beanutils.BeanMap(obj);
    }
	
	public static int getTotalPageCount(int count) {
		if (count == 0) {
			return 0;
		}
		else {
			if (count % 10 == 0) {
				return count / 10;
			}
			else {
				return count / 10 + 1;
			}
		}
	}
	
	public static boolean isEmpty(String str) {
		boolean isEmpty = false;
		if (str == null || str.isEmpty()) {
			isEmpty = true;
		}
		return isEmpty;
	}
	
	 
	  
    /** 
     * 获得默认的 date pattern 
     */  
    public static String getDatePattern()  
    {  
        return defaultDatePattern;  
    }  
  
    /** 
     * 返回预设Format的当前日期字符串 
     */  
    public static String getToday()  
    {  
        Date today = new Date();  
        return format(today);  
    }  
  
    /** 
     * 使用预设Format格式化Date成字符串 
     */  
    public static String format(Date date)  
    {  
        return date == null ? " " : format(date, getDatePattern());  
    }  
  
    /** 
     * 使用参数Format格式化Date成字符串 
     */  
    public static String format(Date date, String pattern)  
    {  
        return date == null ? " " : new SimpleDateFormat(pattern).format(date);  
    }  
  
    /** 
     * 使用预设格式将字符串转为Date 
     */  
    public static Date parse(String strDate) throws ParseException  
    {  
        return StringUtils.isBlank(strDate) ? null : parse(strDate,  
                getDatePattern());  
    }  
  
    /** 
     * 使用参数Format将字符串转为Date 
     */  
    public static Date parse(String strDate, String pattern)  
            throws ParseException  
    {  
        return StringUtils.isBlank(strDate) ? null : new SimpleDateFormat(  
                pattern).parse(strDate);  
    }  
  
    /** 
     * 在日期上增加数个整月 
     */  
    public static Date addMonth(Date date, int n)  
    {  
        Calendar cal = Calendar.getInstance();  
        cal.setTime(date);  
        cal.add(Calendar.MONTH, n);  
        return cal.getTime();  
    }  
  
    public static String getLastDayOfMonth(String year, String month)  
    {  
        Calendar cal = Calendar.getInstance();  
        // 年  
        cal.set(Calendar.YEAR, Integer.parseInt(year));  
        // 月，因为Calendar里的月是从0开始，所以要-1  
        // cal.set(Calendar.MONTH, Integer.parseInt(month) - 1);  
        // 日，设为一号  
        cal.set(Calendar.DATE, 1);  
        // 月份加一，得到下个月的一号  
        cal.add(Calendar.MONTH, 1);  
        // 下一个月减一为本月最后一天  
        cal.add(Calendar.DATE, -1);  
        return String.valueOf(cal.get(Calendar.DAY_OF_MONTH));// 获得月末是几号  
    }  
  
    public static Date getDate(String year, String month, String day)  
            throws ParseException  
    {  
        String result = year + "- "  
                + (month.length() == 1 ? ("0 " + month) : month) + "- "  
                + (day.length() == 1 ? ("0 " + day) : day);  
        return parse(result);  
    }
    
    public static String getFormatSelectTime(String selectTime) {
    	String result = "%Y-%m";
    	if (selectTime.equals("month")) {
    		result = "%Y-%m";
    	}
    	else if (selectTime.equals("quarter")) {
    		result = "%Y-";
    	}
    	else if (selectTime.equals("year")) {
    		result = "%Y年";
    	}
    	return result;
    }
    
    public static String formatQuarterTime(String formatTime) {
    	String result = formatTime;
    	String[] formatTimeArr = formatTime.split("-");
    	if (formatTimeArr.length >= 2) {
    		result = formatTimeArr[0] + "年" + formatTimeArr[1] + "季度";
    	}
    	return result;
    }


}
