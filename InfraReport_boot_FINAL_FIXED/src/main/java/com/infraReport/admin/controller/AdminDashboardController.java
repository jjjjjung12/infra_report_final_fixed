package com.infraReport.admin.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.infraReport.admin.service.AdminDashboardService;

/**
 * 관리자용 담당자별 작업 현황 대시보드 컨트롤러
 */
@Controller
@RequestMapping("/admin")
public class AdminDashboardController {
    
    @Autowired
    private AdminDashboardService adminDashboardService;
    
    /**
     * 관리자 대시보드 메인 페이지
     */
    @GetMapping("/dashboard")
    public String adminDashboard(Model model) {
        return "admin/adminDashboard";
    }
    
    /**
     * 전체 담당자 작업 현황 조회 (AJAX)
     */
    @GetMapping("/work-status")
    @ResponseBody
    public Map<String, Object> getWorkStatus(
            @RequestParam(required = false) String reportDate) {
        return adminDashboardService.getAllManagerWorkStatus(reportDate);
    }
    
    /**
     * 특정 담당자의 상세 작업 현황
     */
    @GetMapping("/manager-detail")
    @ResponseBody
    public Map<String, Object> getManagerDetail(
            @RequestParam String manager,
            @RequestParam(required = false) String reportDate) {
        return adminDashboardService.getManagerDetailStatus(manager, reportDate);
    }
    
    /**
     * 일일 진행 현황
     */
    @GetMapping("/daily-progress")
    @ResponseBody
    public Map<String, Object> getDailyProgress(
            @RequestParam(required = false) String reportDate) {
        return adminDashboardService.getDailyProgress(reportDate);
    }
    
    /**
     * 비정기 작업 현황
     */
    @GetMapping("/irregular-tasks")
    @ResponseBody
    public Map<String, Object> getIrregularTasks(
            @RequestParam(required = false) String reportDate) {
        return adminDashboardService.getIrregularTasks(reportDate);
    }
}
