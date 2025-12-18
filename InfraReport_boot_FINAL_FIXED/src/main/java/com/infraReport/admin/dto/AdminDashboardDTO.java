package com.infraReport.admin.dto;

import java.util.Date;

/**
 * 관리자 대시보드 데이터 전송 객체
 */
public class AdminDashboardDTO {
    
    // 담당자 정보
    private String manager;
    private String department;
    
    // 일일 진행 현황
    private int totalTasks;
    private int completedTasks;
    private int pendingTasks;
    private Double completionRate;
    
    // 비정기 작업 현황 (기한별)
    private int totalIrregularTasks;
    private int overdueCount;          // 기한초과
    private int within1Day;            // 1D (1일 이내)
    private int within3Days;           // 3D (3일 이내)
    private int within5Days;           // 5D (5일 이내)
    private int within2Weeks;          // 2W (2주 이내)
    private int within4Weeks;          // 4W (4주 이내)
    private int over1Month;            // Over 1M (1개월 초과)
    
    // 작업 상세 정보
    private Date reportDate;
    private String serviceName;
    private String taskDescription;
    private String taskType;
    private String status;
    private Date dueDate;
    private String priority;
    private String remarks;
    
    // Getters and Setters
    public String getManager() {
        return manager;
    }
    
    public void setManager(String manager) {
        this.manager = manager;
    }
    
    public String getDepartment() {
        return department;
    }
    
    public void setDepartment(String department) {
        this.department = department;
    }
    
    public int getTotalTasks() {
        return totalTasks;
    }
    
    public void setTotalTasks(int totalTasks) {
        this.totalTasks = totalTasks;
    }
    
    public int getCompletedTasks() {
        return completedTasks;
    }
    
    public void setCompletedTasks(int completedTasks) {
        this.completedTasks = completedTasks;
    }
    
    public int getPendingTasks() {
        return pendingTasks;
    }
    
    public void setPendingTasks(int pendingTasks) {
        this.pendingTasks = pendingTasks;
    }
    
    public Double getCompletionRate() {
        return completionRate;
    }
    
    public void setCompletionRate(Double completionRate) {
        this.completionRate = completionRate;
    }
    
    public int getTotalIrregularTasks() {
        return totalIrregularTasks;
    }
    
    public void setTotalIrregularTasks(int totalIrregularTasks) {
        this.totalIrregularTasks = totalIrregularTasks;
    }
    
    public int getOverdueCount() {
        return overdueCount;
    }
    
    public void setOverdueCount(int overdueCount) {
        this.overdueCount = overdueCount;
    }
    
    public int getWithin1Day() {
        return within1Day;
    }
    
    public void setWithin1Day(int within1Day) {
        this.within1Day = within1Day;
    }
    
    public int getWithin3Days() {
        return within3Days;
    }
    
    public void setWithin3Days(int within3Days) {
        this.within3Days = within3Days;
    }
    
    public int getWithin5Days() {
        return within5Days;
    }
    
    public void setWithin5Days(int within5Days) {
        this.within5Days = within5Days;
    }
    
    public int getWithin2Weeks() {
        return within2Weeks;
    }
    
    public void setWithin2Weeks(int within2Weeks) {
        this.within2Weeks = within2Weeks;
    }
    
    public int getWithin4Weeks() {
        return within4Weeks;
    }
    
    public void setWithin4Weeks(int within4Weeks) {
        this.within4Weeks = within4Weeks;
    }
    
    public int getOver1Month() {
        return over1Month;
    }
    
    public void setOver1Month(int over1Month) {
        this.over1Month = over1Month;
    }
    
    public Date getReportDate() {
        return reportDate;
    }
    
    public void setReportDate(Date reportDate) {
        this.reportDate = reportDate;
    }
    
    public String getServiceName() {
        return serviceName;
    }
    
    public void setServiceName(String serviceName) {
        this.serviceName = serviceName;
    }
    
    public String getTaskDescription() {
        return taskDescription;
    }
    
    public void setTaskDescription(String taskDescription) {
        this.taskDescription = taskDescription;
    }
    
    public String getTaskType() {
        return taskType;
    }
    
    public void setTaskType(String taskType) {
        this.taskType = taskType;
    }
    
    public String getStatus() {
        return status;
    }
    
    public void setStatus(String status) {
        this.status = status;
    }
    
    public Date getDueDate() {
        return dueDate;
    }
    
    public void setDueDate(Date dueDate) {
        this.dueDate = dueDate;
    }
    
    public String getPriority() {
        return priority;
    }
    
    public void setPriority(String priority) {
        this.priority = priority;
    }
    
    public String getRemarks() {
        return remarks;
    }
    
    public void setRemarks(String remarks) {
        this.remarks = remarks;
    }
}
