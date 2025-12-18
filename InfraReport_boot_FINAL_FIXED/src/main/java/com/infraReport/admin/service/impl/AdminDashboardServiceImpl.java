package com.infraReport.admin.service.impl;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.infraReport.admin.dao.AdminDashboardDAO;
import com.infraReport.admin.dto.AdminDashboardDTO;
import com.infraReport.admin.service.AdminDashboardService;

/**
 * 관리자 대시보드 서비스 구현체
 */
@Service
public class AdminDashboardServiceImpl implements AdminDashboardService {
    
    @Autowired
    private AdminDashboardDAO adminDashboardDAO;
    
    @Override
    public Map<String, Object> getAllManagerWorkStatus(String reportDate) {
        Map<String, Object> result = new HashMap<>();
        
        try {
            // 날짜가 없으면 오늘 날짜 사용
            if (reportDate == null || reportDate.isEmpty()) {
                reportDate = LocalDate.now().format(DateTimeFormatter.ISO_DATE);
            }
            
            // 일일 진행 현황
            List<AdminDashboardDTO> dailyProgress = adminDashboardDAO.getAllDailyProgress(reportDate);
            result.put("dailyProgress", dailyProgress);
            
            // 비정기 작업 현황
            List<AdminDashboardDTO> irregularTasks = adminDashboardDAO.getAllIrregularTasks(reportDate);
            result.put("irregularTasks", irregularTasks);
            
            result.put("reportDate", reportDate);
            result.put("success", true);
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", "데이터 조회 중 오류 발생: " + e.getMessage());
        }
        
        return result;
    }
    
    @Override
    public Map<String, Object> getManagerDetailStatus(String manager, String reportDate) {
        Map<String, Object> result = new HashMap<>();
        
        try {
            if (reportDate == null || reportDate.isEmpty()) {
                reportDate = LocalDate.now().format(DateTimeFormatter.ISO_DATE);
            }
            
            // 담당자별 작업 상세 목록
            List<AdminDashboardDTO> taskDetails = adminDashboardDAO.getManagerTaskDetails(manager, reportDate);
            result.put("taskDetails", taskDetails);
            
            // 담당자별 통계
            AdminDashboardDTO dailyProgress = adminDashboardDAO.getDailyProgressByManager(manager, reportDate);
            AdminDashboardDTO irregularTasks = adminDashboardDAO.getIrregularTasksByManager(manager, reportDate);
            
            result.put("dailyProgress", dailyProgress);
            result.put("irregularTasks", irregularTasks);
            result.put("manager", manager);
            result.put("reportDate", reportDate);
            result.put("success", true);
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", "데이터 조회 중 오류 발생: " + e.getMessage());
        }
        
        return result;
    }
    
    @Override
    public Map<String, Object> getDailyProgress(String reportDate) {
        Map<String, Object> result = new HashMap<>();
        
        try {
            if (reportDate == null || reportDate.isEmpty()) {
                reportDate = LocalDate.now().format(DateTimeFormatter.ISO_DATE);
            }
            
            List<AdminDashboardDTO> dailyProgress = adminDashboardDAO.getAllDailyProgress(reportDate);
            result.put("dailyProgress", dailyProgress);
            result.put("reportDate", reportDate);
            result.put("success", true);
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", "데이터 조회 중 오류 발생: " + e.getMessage());
        }
        
        return result;
    }
    
    @Override
    public Map<String, Object> getIrregularTasks(String reportDate) {
        Map<String, Object> result = new HashMap<>();
        
        try {
            if (reportDate == null || reportDate.isEmpty()) {
                reportDate = LocalDate.now().format(DateTimeFormatter.ISO_DATE);
            }
            
            List<AdminDashboardDTO> irregularTasks = adminDashboardDAO.getAllIrregularTasks(reportDate);
            result.put("irregularTasks", irregularTasks);
            result.put("reportDate", reportDate);
            result.put("success", true);
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", "데이터 조회 중 오류 발생: " + e.getMessage());
        }
        
        return result;
    }
}
