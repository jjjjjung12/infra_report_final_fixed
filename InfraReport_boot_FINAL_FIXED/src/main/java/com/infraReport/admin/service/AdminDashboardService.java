package com.infraReport.admin.service;

import java.util.Map;

/**
 * 관리자 대시보드 서비스
 */
public interface AdminDashboardService {
    
    /**
     * 전체 담당자 작업 현황 조회
     */
    Map<String, Object> getAllManagerWorkStatus(String reportDate);
    
    /**
     * 특정 담당자의 상세 작업 현황
     */
    Map<String, Object> getManagerDetailStatus(String manager, String reportDate);
    
    /**
     * 일일 진행 현황
     */
    Map<String, Object> getDailyProgress(String reportDate);
    
    /**
     * 비정기 작업 현황
     */
    Map<String, Object> getIrregularTasks(String reportDate);
}
