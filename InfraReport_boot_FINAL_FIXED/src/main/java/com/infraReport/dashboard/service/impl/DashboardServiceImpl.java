package com.infraReport.dashboard.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.infraReport.dashboard.dao.DashboardDAO;
import com.infraReport.dashboard.dto.DashboardDTO;
import com.infraReport.dashboard.service.DashboardService;

/**
 * 대시보드 서비스 구현체
 */
@Service
public class DashboardServiceImpl implements DashboardService {
    
    @Autowired
    private DashboardDAO dashboardDAO;
    
    @Override
    public Map<String, Object> getDashboardData() {
        Map<String, Object> result = new HashMap<>();
        
        try {
            // 각 섹션 데이터 통합 조회
            result.put("realtime", getRealtimeStatus());
            result.put("todayTasks", getTodayTasks());
            result.put("tickets", getTicketStatus());
            result.put("team", getTeamInfo());
            result.put("scheduled", getScheduledTasks());
            result.put("prevention", getPreventionStatus());
            result.put("success", true);
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", "데이터 조회 중 오류 발생: " + e.getMessage());
        }
        
        return result;
    }
    
    @Override
    public Map<String, Object> getRealtimeStatus() {
        Map<String, Object> result = new HashMap<>();
        
        try {
            // 1. 핵심 서비스 상태
            List<DashboardDTO> serviceStatus = dashboardDAO.getServiceStatus();
            result.put("serviceStatus", serviceStatus);
            
            // 2. 진행 중인 장애 복구
            DashboardDTO issueCount = dashboardDAO.getIssueCount();
            result.put("ongoingIssues", issueCount != null ? issueCount.getOngoingIssues() : 0);
            
            // 3. 미확인 Critical 알림
            result.put("criticalCount", issueCount != null ? issueCount.getCriticalCount() : 0);
            result.put("warningCount", issueCount != null ? issueCount.getWarningCount() : 0);
            
            result.put("success", true);
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", e.getMessage());
        }
        
        return result;
    }
    
    @Override
    public Map<String, Object> getTodayTasks() {
        Map<String, Object> result = new HashMap<>();
        
        try {
            // 1. 금일 업무 통계
            DashboardDTO taskStats = dashboardDAO.getTodayTaskStats();
            result.put("taskStats", taskStats);
            
            // 2. 금일 업무 목록
            List<DashboardDTO> taskList = dashboardDAO.getTodayTasks();
            result.put("taskList", taskList);
            
            // 3. HW/SW 점검 현황
            DashboardDTO checkStatus = dashboardDAO.getCheckStatus();
            result.put("checkStatus", checkStatus);
            
            result.put("success", true);
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", e.getMessage());
        }
        
        return result;
    }
    
    @Override
    public Map<String, Object> getTicketStatus() {
        Map<String, Object> result = new HashMap<>();
        
        try {
            // 티켓 통계 (실제 티켓 테이블이 있다면 수정 필요)
            // 현재는 임시 데이터로 반환
            result.put("newTickets", 3);
            result.put("processingTickets", 5);
            result.put("closedTickets", 12);
            result.put("success", true);
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", e.getMessage());
        }
        
        return result;
    }
    
    @Override
    public Map<String, Object> getTeamInfo() {
        Map<String, Object> result = new HashMap<>();
        
        try {
            // 1. 오늘의 당직자
            DashboardDTO manager = dashboardDAO.getTodayManager();
            result.put("manager", manager != null ? manager : new DashboardDTO());
            
            // 2. 주요 공지사항 (임시 데이터)
            result.put("announcements", List.of(
                Map.of("title", "정기 점검 안내", "date", "2024-11-25"),
                Map.of("title", "신규 보안 정책 적용", "date", "2024-11-24")
            ));
            
            result.put("success", true);
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", e.getMessage());
        }
        
        return result;
    }
    
    @Override
    public Map<String, Object> getScheduledTasks() {
        Map<String, Object> result = new HashMap<>();
        
        try {
            // 주간 및 월간 예정 작업
            List<DashboardDTO> weeklySchedule = dashboardDAO.getWeeklySchedule();
            result.put("weeklySchedule", weeklySchedule);
            
            result.put("success", true);
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", e.getMessage());
        }
        
        return result;
    }
    
    @Override
    public Map<String, Object> getPreventionStatus() {
        Map<String, Object> result = new HashMap<>();
        
        try {
            // 1. 자원 임계치 근접 항목
            List<DashboardDTO> criticalResources = dashboardDAO.getCriticalResources();
            result.put("criticalResources", criticalResources);
            
            // 2. 백업 현황
            DashboardDTO backupStatus = dashboardDAO.getBackupStatus();
            result.put("backupStatus", backupStatus);
            
            // 3. 보안 활동
            DashboardDTO securityActivity = dashboardDAO.getSecurityActivity();
            result.put("securityActivity", securityActivity);
            
            result.put("success", true);
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", e.getMessage());
        }
        
        return result;
    }
}
