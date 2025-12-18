package com.infraReport.work.domain;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

/**
 * 작업 프로젝트 도메인
 */
public class WorkProject {
    
    private static final DateTimeFormatter DATE_TIME_FORMATTER = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");
    private static final DateTimeFormatter DATE_FORMATTER = DateTimeFormatter.ofPattern("yyyy-MM-dd");
    
    private Long projectId;
    private String userId;
    private String projectName;
    private String workContent;
    private String workLocation;
    private LocalDate startDate;
    private LocalDate endDate;
    private String currentStage;
    private String projectStatus;
    private LocalDateTime createdDate;
    private LocalDateTime updatedDate;
    
    // 조인용 필드
    private String userName;
    private String companyName;
    
    // Getters and Setters
    public Long getProjectId() {
        return projectId;
    }
    
    public void setProjectId(Long projectId) {
        this.projectId = projectId;
    }
    
    public String getUserId() {
        return userId;
    }
    
    public void setUserId(String userId) {
        this.userId = userId;
    }
    
    public String getProjectName() {
        return projectName;
    }
    
    public void setProjectName(String projectName) {
        this.projectName = projectName;
    }
    
    public String getWorkContent() {
        return workContent;
    }
    
    public void setWorkContent(String workContent) {
        this.workContent = workContent;
    }
    
    public String getWorkLocation() {
        return workLocation;
    }
    
    public void setWorkLocation(String workLocation) {
        this.workLocation = workLocation;
    }
    
    public LocalDate getStartDate() {
        return startDate;
    }
    
    public void setStartDate(LocalDate startDate) {
        this.startDate = startDate;
    }
    
    public LocalDate getEndDate() {
        return endDate;
    }
    
    public void setEndDate(LocalDate endDate) {
        this.endDate = endDate;
    }
    
    public String getCurrentStage() {
        return currentStage;
    }
    
    public void setCurrentStage(String currentStage) {
        this.currentStage = currentStage;
    }
    
    public String getProjectStatus() {
        return projectStatus;
    }
    
    public void setProjectStatus(String projectStatus) {
        this.projectStatus = projectStatus;
    }
    
    public LocalDateTime getCreatedDate() {
        return createdDate;
    }
    
    public void setCreatedDate(LocalDateTime createdDate) {
        this.createdDate = createdDate;
    }
    
    public LocalDateTime getUpdatedDate() {
        return updatedDate;
    }
    
    public void setUpdatedDate(LocalDateTime updatedDate) {
        this.updatedDate = updatedDate;
    }
    
    public String getUserName() {
        return userName;
    }
    
    public void setUserName(String userName) {
        this.userName = userName;
    }
    
    public String getCompanyName() {
        return companyName;
    }
    
    public void setCompanyName(String companyName) {
        this.companyName = companyName;
    }
    
    // 유틸리티 메서드
    public String getStageName() {
        if (currentStage == null) return "";
        switch (currentStage) {
            case "INITIATION": return "착수 단계";
            case "CONSTRUCTION": return "구축 단계";
            case "COMPLETION": return "완료 단계";
            default: return currentStage;
        }
    }
    
    public String getStatusName() {
        if (projectStatus == null) return "";
        switch (projectStatus) {
            case "IN_PROGRESS": return "진행중";
            case "COMPLETED": return "완료";
            case "CANCELLED": return "취소";
            default: return projectStatus;
        }
    }
    
    public String getFormattedCreatedDate() {
        return createdDate != null ? createdDate.format(DATE_TIME_FORMATTER) : "";
    }
    
    public String getFormattedUpdatedDate() {
        return updatedDate != null ? updatedDate.format(DATE_TIME_FORMATTER) : "";
    }
    
    public String getFormattedStartDate() {
        return startDate != null ? startDate.format(DATE_FORMATTER) : "";
    }
    
    public String getFormattedEndDate() {
        return endDate != null ? endDate.format(DATE_FORMATTER) : "";
    }
    
    public String getNextStage() {
        if (currentStage == null) return "INITIATION";
        switch (currentStage) {
            case "INITIATION": return "CONSTRUCTION";
            case "CONSTRUCTION": return "COMPLETION";
            case "COMPLETION": return null;
            default: return null;
        }
    }
    
    public int getStageProgress() {
        if (currentStage == null) return 0;
        switch (currentStage) {
            case "INITIATION": return 33;
            case "CONSTRUCTION": return 66;
            case "COMPLETION": return 100;
            default: return 0;
        }
    }
}
