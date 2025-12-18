package com.infraReport.dashboard.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.infraReport.dashboard.service.DashboardService;

/**
 * TV용 대시보드 컨트롤러
 * 아침 회의용 실시간 모니터링 대시보드
 */
@Controller
@RequestMapping("/dashboard")
public class DashboardController {
    
    @Autowired
    private DashboardService dashboardService;
    
    /**
     * TV 대시보드 메인 페이지
     */
    @GetMapping("/tv")
    public String tvDashboard(Model model) {
        return "dashboard/tvDashboard";
    }
    
    /**
     * 대시보드 데이터 실시간 조회 (AJAX)
     */
    @GetMapping("/data")
    @ResponseBody
    public Map<String, Object> getDashboardData() {
        return dashboardService.getDashboardData();
    }
    
    /**
     * 실시간 장애 대응 데이터
     */
    @GetMapping("/realtime")
    @ResponseBody
    public Map<String, Object> getRealtimeStatus() {
        return dashboardService.getRealtimeStatus();
    }
    
    /**
     * 금일 업무 (To-Do)
     */
    @GetMapping("/today-tasks")
    @ResponseBody
    public Map<String, Object> getTodayTasks() {
        return dashboardService.getTodayTasks();
    }
    
    /**
     * 티켓 현황
     */
    @GetMapping("/tickets")
    @ResponseBody
    public Map<String, Object> getTicketStatus() {
        return dashboardService.getTicketStatus();
    }
    
    /**
     * 팀/커뮤니케이션
     */
    @GetMapping("/team-info")
    @ResponseBody
    public Map<String, Object> getTeamInfo() {
        return dashboardService.getTeamInfo();
    }
    
    /**
     * 예정된 작업
     */
    @GetMapping("/scheduled-tasks")
    @ResponseBody
    public Map<String, Object> getScheduledTasks() {
        return dashboardService.getScheduledTasks();
    }
    
    /**
     * 예방 및 점검
     */
    @GetMapping("/prevention")
    @ResponseBody
    public Map<String, Object> getPreventionStatus() {
        return dashboardService.getPreventionStatus();
    }
}
