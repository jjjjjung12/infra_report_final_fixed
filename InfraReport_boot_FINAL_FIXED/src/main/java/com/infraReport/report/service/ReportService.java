package com.infraReport.report.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.springframework.web.multipart.MultipartFile;

import com.infraReport.report.dto.CommonCodeDTO;
import com.infraReport.report.dto.DailyReportStatDTO;

public interface ReportService {
	
	/*
	 * 업무 유형 별 통계 조회
	 * */
    DailyReportStatDTO getDailyReportStats();
    
    /*
     * 공통 코드 조회
     * */
    List<CommonCodeDTO> getCodeListByType(String cdType);
    
    /*
     * 엑셀 내보내기
     * */
    void exportExcel(HashMap<String, Object> requestMap, HttpServletResponse response) throws Exception;

    /*
     * 엑셀 업로드
     * */
    Map<String, Object> uploadExcel(String uploadType, MultipartFile file);
}
