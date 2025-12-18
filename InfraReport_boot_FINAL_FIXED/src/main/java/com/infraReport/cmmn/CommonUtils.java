package com.infraReport.cmmn;

import java.text.SimpleDateFormat;
import java.util.Map;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.DateUtil;
import org.apache.poi.ss.usermodel.Row;

/**
 * 공통 유틸리티
 */
public class CommonUtils {
	
	/*
	 * 문자열 빈값 체크
	 * */
    public static boolean isEmpty(String str) {
    	return (str == null || str.isEmpty());
    }
    
    /*
     * request 빈값 체크
     * */
    public static String getString(Map<String, Object> map, String key) {
    	return map.get(key) != null ? map.get(key).toString() : "";
    }
    
    /*
     * 문자열 정수 전환
     * */
    public static int parseIntSafe(String numberStr) {
        if (numberStr == null || numberStr.isEmpty()) return 0;
        try {
            return Integer.parseInt(numberStr);
        } catch (NumberFormatException e) {
            return 0;
        }
    }
    
    /*
     * 엑셀 셀 string 반환
     * */
    public static String getCellString(Row row, int index) {
        Cell cell = row.getCell(index);
        if (cell == null) return "";
        switch (cell.getCellType()) {
            case STRING:
                return cell.getStringCellValue().trim();
            case NUMERIC:
                if (DateUtil.isCellDateFormatted(cell)) {
                    return new SimpleDateFormat("yyyy-MM-dd").format(cell.getDateCellValue());
                } else {
                    double num = cell.getNumericCellValue();
                    if (Math.floor(num) == num) {
                        return String.valueOf((long) num);
                    } else {
                        return String.valueOf(num);
                    }
                }
            case BOOLEAN:
                return String.valueOf(cell.getBooleanCellValue());
            case FORMULA:
                try {
                    return cell.getStringCellValue().trim();
                } catch (Exception e) {
                    try {
                        double num = cell.getNumericCellValue();
                        if (Math.floor(num) == num) {
                            return String.valueOf((long) num);
                        } else {
                            return String.valueOf(num);
                        }
                    } catch (Exception ex) {
                        return cell.toString().trim();
                    }
                }
            default:
                return cell.toString().trim();
        }
    }

    /*
     * 엑셀 셀 double 반환
     * */
    public static double getCellDouble(Row row, int index) {
        Cell cell = row.getCell(index);
        if (cell == null) return 0.0;
        switch (cell.getCellType()) {
            case NUMERIC:
                return cell.getNumericCellValue();
            case STRING:
                String s = cell.getStringCellValue().trim();
                if (s.isEmpty()) return 0.0;
                try {
                    return Double.parseDouble(s);
                } catch (NumberFormatException e) {
                    return 0.0;
                }
            case BOOLEAN:
                return cell.getBooleanCellValue() ? 1.0 : 0.0;
            default:
                return 0.0;
        }
    }
    
    /*
     * Timestamp 형식 별 String 변환
     * */
    public static String getFormattedTimestamp(java.sql.Timestamp ts, java.time.format.DateTimeFormatter fmt) {
        if (ts == null) return "";
        return ts.toLocalDateTime().format(fmt);
    }
}