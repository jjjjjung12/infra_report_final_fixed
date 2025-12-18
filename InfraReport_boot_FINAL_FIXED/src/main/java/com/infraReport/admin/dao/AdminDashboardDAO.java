package com.infraReport.admin.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.infraReport.admin.dto.AdminDashboardDTO;

/**
 * 관리자 대시보드 DAO
 */
@Mapper
public interface AdminDashboardDAO {
    
    /**
     * 전체 담당자 목록 조회
     */
    List<String> getAllManagers(@Param("reportDate") String reportDate);
    
    /**
     * 담당자별 일일 작업 진행률
     */
    AdminDashboardDTO getDailyProgressByManager(
            @Param("manager") String manager,
            @Param("reportDate") String reportDate);
    
    /**
     * 담당자별 비정기 작업 현황 (기한별)
     */
    AdminDashboardDTO getIrregularTasksByManager(
            @Param("manager") String manager,
            @Param("reportDate") String reportDate);
    
    /**
     * 특정 담당자의 작업 상세 목록
     */
    List<AdminDashboardDTO> getManagerTaskDetails(
            @Param("manager") String manager,
            @Param("reportDate") String reportDate);
    
    /**
     * 전체 팀원 일일 진행률 통계
     */
    List<AdminDashboardDTO> getAllDailyProgress(@Param("reportDate") String reportDate);
    
    /**
     * 전체 팀원 비정기 작업 통계
     */
    List<AdminDashboardDTO> getAllIrregularTasks(@Param("reportDate") String reportDate);
}
