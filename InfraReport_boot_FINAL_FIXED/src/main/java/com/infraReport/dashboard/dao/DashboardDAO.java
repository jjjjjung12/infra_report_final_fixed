package com.infraReport.dashboard.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.infraReport.dashboard.dto.DashboardDTO;

/**
 * 대시보드 DAO
 */
@Mapper
public interface DashboardDAO {
    
    /**
     * 일일 업무 통계 조회
     */
    DashboardDTO getTodayTaskStats();
    
    /**
     * 서비스별 상태 조회
     */
    List<DashboardDTO> getServiceStatus();
    
    /**
     * 금일 장애 건수 조회
     */
    DashboardDTO getIssueCount();
    
    /**
     * HW/SW 점검 현황
     */
    DashboardDTO getCheckStatus();
    
    /**
     * 자원 사용률 평균
     */
    List<DashboardDTO> getResourceUsage();
    
    /**
     * 백업 현황
     */
    DashboardDTO getBackupStatus();
    
    /**
     * 보안 활동 현황
     */
    DashboardDTO getSecurityActivity();
    
    /**
     * 금일 업무 목록
     */
    List<DashboardDTO> getTodayTasks();
    
    /**
     * 티켓 통계 (가상 데이터 - 실제 티켓 테이블이 있다면 수정 필요)
     */
    Map<String, Integer> getTicketStats();
    
    /**
     * 당직자 정보 (가상 데이터)
     */
    DashboardDTO getTodayManager();
    
    /**
     * 주간 예정 작업
     */
    List<DashboardDTO> getWeeklySchedule();
    
    /**
     * 자원 임계치 근접 항목
     */
    List<DashboardDTO> getCriticalResources();
}
