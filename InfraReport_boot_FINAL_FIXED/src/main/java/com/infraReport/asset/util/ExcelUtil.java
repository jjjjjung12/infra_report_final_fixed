package com.infraReport.asset.util;

import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.util.Map;

/**
 * 엑셀 다운로드 유틸리티
 */
public class ExcelUtil {
    
    /**
     * 자산 목록 엑셀 다운로드
     */
    public static void downloadAssetListExcel(
            List<Map<String, Object>> list,
            HttpServletResponse response) throws IOException {
        
        // 워크북 생성
        Workbook workbook = new XSSFWorkbook();
        Sheet sheet = workbook.createSheet("자산목록");
        
        // 스타일 생성
        CellStyle headerStyle = createHeaderStyle(workbook);
        CellStyle dataStyle = createDataStyle(workbook);
        
        // 헤더 생성
        Row headerRow = sheet.createRow(0);
        String[] headers = {
            "서비스명", "서비스 자산번호",
            "HW-구분", "HW-제조사", "HW-제품명", "HW-버전", "HW-개수", "HW-자산번호",
            "SW-구분", "SW-제조사", "SW-제품명", "SW-버전", "SW-개수", "SW-자산번호"
        };
        
        for (int i = 0; i < headers.length; i++) {
            Cell cell = headerRow.createCell(i);
            cell.setCellValue(headers[i]);
            cell.setCellStyle(headerStyle);
            sheet.setColumnWidth(i, 4000); // 너비 설정
        }
        
        // 데이터 생성
        int rowNum = 1;
        for (Map<String, Object> data : list) {
            Row row = sheet.createRow(rowNum++);
            
            createCell(row, 0, getString(data, "SERVICE_NAME"), dataStyle);
            createCell(row, 1, getString(data, "SERVICE_ASSET_NO"), dataStyle);
            createCell(row, 2, getString(data, "HARDWARE_TYPE"), dataStyle);
            createCell(row, 3, getString(data, "HARDWARE_MANUFACTURER"), dataStyle);
            createCell(row, 4, getString(data, "HARDWARE_PRODUCT_NAME"), dataStyle);
            createCell(row, 5, getString(data, "HARDWARE_VERSION"), dataStyle);
            createCell(row, 6, getString(data, "HARDWARE_QUANTITY"), dataStyle);
            createCell(row, 7, getString(data, "HARDWARE_ASSET_NO"), dataStyle);
            createCell(row, 8, getString(data, "SOFTWARE_TYPE"), dataStyle);
            createCell(row, 9, getString(data, "SOFTWARE_MANUFACTURER"), dataStyle);
            createCell(row, 10, getString(data, "SOFTWARE_PRODUCT_NAME"), dataStyle);
            createCell(row, 11, getString(data, "SOFTWARE_VERSION"), dataStyle);
            createCell(row, 12, getString(data, "SOFTWARE_QUANTITY"), dataStyle);
            createCell(row, 13, getString(data, "SOFTWARE_ASSET_NO"), dataStyle);
        }
        
        // 파일 다운로드 설정
        String fileName = "asset_list_" + System.currentTimeMillis() + ".xlsx";
        response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
        response.setHeader("Content-Disposition", "attachment; filename=\"" + fileName + "\"");
        
        // 다운로드
        workbook.write(response.getOutputStream());
        workbook.close();
    }
    
    /**
     * 헤더 스타일 생성
     */
    private static CellStyle createHeaderStyle(Workbook workbook) {
        CellStyle style = workbook.createCellStyle();
        
        // 배경색
        style.setFillForegroundColor(IndexedColors.GREY_25_PERCENT.getIndex());
        style.setFillPattern(FillPatternType.SOLID_FOREGROUND);
        
        // 테두리
        style.setBorderTop(BorderStyle.THIN);
        style.setBorderBottom(BorderStyle.THIN);
        style.setBorderLeft(BorderStyle.THIN);
        style.setBorderRight(BorderStyle.THIN);
        
        // 정렬
        style.setAlignment(HorizontalAlignment.CENTER);
        style.setVerticalAlignment(VerticalAlignment.CENTER);
        
        // 폰트
        Font font = workbook.createFont();
        font.setBold(true);
        font.setFontHeightInPoints((short) 11);
        style.setFont(font);
        
        return style;
    }
    
    /**
     * 데이터 스타일 생성
     */
    private static CellStyle createDataStyle(Workbook workbook) {
        CellStyle style = workbook.createCellStyle();
        
        // 테두리
        style.setBorderTop(BorderStyle.THIN);
        style.setBorderBottom(BorderStyle.THIN);
        style.setBorderLeft(BorderStyle.THIN);
        style.setBorderRight(BorderStyle.THIN);
        
        // 정렬
        style.setAlignment(HorizontalAlignment.LEFT);
        style.setVerticalAlignment(VerticalAlignment.CENTER);
        
        return style;
    }
    
    /**
     * 셀 생성
     */
    private static void createCell(Row row, int column, String value, CellStyle style) {
        Cell cell = row.createCell(column);
        cell.setCellValue(value != null ? value : "");
        cell.setCellStyle(style);
    }
    
    /**
     * Map에서 String 값 가져오기
     */
    private static String getString(Map<String, Object> map, String key) {
        Object value = map.get(key);
        return value != null ? value.toString() : "";
    }
}
