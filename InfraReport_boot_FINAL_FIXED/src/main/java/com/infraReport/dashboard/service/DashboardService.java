package com.infraReport.dashboard.service;

import java.util.Map;

/**
 * 대시보드 서비스
 */
public interface DashboardService {
    
    /**
     * 통합 대시보드 데이터 조회
     */
    Map<String, Object> getDashboardData();
    
    /**
     * 실시간 장애 대응 데이터
     */
    Map<String, Object> getRealtimeStatus();
    
    /**
     * 금일 업무 (To-Do)
     */
    Map<String, Object> getTodayTasks();
    
    /**
     * 티켓 현황
     */
    Map<String, Object> getTicketStatus();
    
    /**
     * 팀/커뮤니케이션
     */
    Map<String, Object> getTeamInfo();
    
    /**
     * 예정된 작업
     */
    Map<String, Object> getScheduledTasks();
    
    /**
     * 예방 및 점검
     */
    Map<String, Object> getPreventionStatus();
}
