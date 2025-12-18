package com.infraReport.dashboard.dto;

import java.util.Date;

/**
 * 대시보드 데이터 전송 객체
 */
public class DashboardDTO {
    
    // 일일 보고서 통계
    private int totalTasks;
    private int completedTasks;
    private int pendingTasks;
    private String completionRate;
    
    // 서비스 상태
    private String serviceName;
    private String serviceStatus;
    private String serviceCategory;
    
    // 장애 정보
    private int criticalCount;
    private int warningCount;
    private int ongoingIssues;
    
    // HW/SW 점검
    private int totalChecks;
    private int passedChecks;
    private int failedChecks;
    
    // 자원 사용률
    private String resourceType;
    private Double usagePercent;
    private String status;
    private Double avgUsage;
    
    // 백업 상태
    private int successBackups;
    private int failedBackups;
    private int totalBackups;
    
    // 보안 활동
    private int detectionCount;
    private int blockedCount;
    
    // 티켓 정보
    private int newTickets;
    private int processingTickets;
    private int closedTickets;
    
    // 당직자 정보
    private String managerName;
    private String managerType; // 주간/야간
    private String department;
    
    // 작업 정보
    private Date reportDate;
    private String taskDescription;
    private String taskType;
    private String checkTime;
    private String manager;
    private String remarks;
    
    // Getters and Setters
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
    
    public String getCompletionRate() {
        return completionRate;
    }
    
    public void setCompletionRate(String completionRate) {
        this.completionRate = completionRate;
    }
    
    public String getServiceName() {
        return serviceName;
    }
    
    public void setServiceName(String serviceName) {
        this.serviceName = serviceName;
    }
    
    public String getServiceStatus() {
        return serviceStatus;
    }
    
    public void setServiceStatus(String serviceStatus) {
        this.serviceStatus = serviceStatus;
    }
    
    public String getServiceCategory() {
        return serviceCategory;
    }
    
    public void setServiceCategory(String serviceCategory) {
        this.serviceCategory = serviceCategory;
    }
    
    public int getCriticalCount() {
        return criticalCount;
    }
    
    public void setCriticalCount(int criticalCount) {
        this.criticalCount = criticalCount;
    }
    
    public int getWarningCount() {
        return warningCount;
    }
    
    public void setWarningCount(int warningCount) {
        this.warningCount = warningCount;
    }
    
    public int getOngoingIssues() {
        return ongoingIssues;
    }
    
    public void setOngoingIssues(int ongoingIssues) {
        this.ongoingIssues = ongoingIssues;
    }
    
    public int getTotalChecks() {
        return totalChecks;
    }
    
    public void setTotalChecks(int totalChecks) {
        this.totalChecks = totalChecks;
    }
    
    public int getPassedChecks() {
        return passedChecks;
    }
    
    public void setPassedChecks(int passedChecks) {
        this.passedChecks = passedChecks;
    }
    
    public int getFailedChecks() {
        return failedChecks;
    }
    
    public void setFailedChecks(int failedChecks) {
        this.failedChecks = failedChecks;
    }
    
    public String getResourceType() {
        return resourceType;
    }
    
    public void setResourceType(String resourceType) {
        this.resourceType = resourceType;
    }
    
    public Double getUsagePercent() {
        return usagePercent;
    }
    
    public void setUsagePercent(Double usagePercent) {
        this.usagePercent = usagePercent;
    }
    
    public String getStatus() {
        return status;
    }
    
    public void setStatus(String status) {
        this.status = status;
    }
    
    public Double getAvgUsage() {
        return avgUsage;
    }
    
    public void setAvgUsage(Double avgUsage) {
        this.avgUsage = avgUsage;
    }
    
    public int getSuccessBackups() {
        return successBackups;
    }
    
    public void setSuccessBackups(int successBackups) {
        this.successBackups = successBackups;
    }
    
    public int getFailedBackups() {
        return failedBackups;
    }
    
    public void setFailedBackups(int failedBackups) {
        this.failedBackups = failedBackups;
    }
    
    public int getTotalBackups() {
        return totalBackups;
    }
    
    public void setTotalBackups(int totalBackups) {
        this.totalBackups = totalBackups;
    }
    
    public int getDetectionCount() {
        return detectionCount;
    }
    
    public void setDetectionCount(int detectionCount) {
        this.detectionCount = detectionCount;
    }
    
    public int getBlockedCount() {
        return blockedCount;
    }
    
    public void setBlockedCount(int blockedCount) {
        this.blockedCount = blockedCount;
    }
    
    public int getNewTickets() {
        return newTickets;
    }
    
    public void setNewTickets(int newTickets) {
        this.newTickets = newTickets;
    }
    
    public int getProcessingTickets() {
        return processingTickets;
    }
    
    public void setProcessingTickets(int processingTickets) {
        this.processingTickets = processingTickets;
    }
    
    public int getClosedTickets() {
        return closedTickets;
    }
    
    public void setClosedTickets(int closedTickets) {
        this.closedTickets = closedTickets;
    }
    
    public String getManagerName() {
        return managerName;
    }
    
    public void setManagerName(String managerName) {
        this.managerName = managerName;
    }
    
    public String getManagerType() {
        return managerType;
    }
    
    public void setManagerType(String managerType) {
        this.managerType = managerType;
    }
    
    public String getDepartment() {
        return department;
    }
    
    public void setDepartment(String department) {
        this.department = department;
    }
    
    public Date getReportDate() {
        return reportDate;
    }
    
    public void setReportDate(Date reportDate) {
        this.reportDate = reportDate;
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
    
    public String getCheckTime() {
        return checkTime;
    }
    
    public void setCheckTime(String checkTime) {
        this.checkTime = checkTime;
    }
    
    public String getManager() {
        return manager;
    }
    
    public void setManager(String manager) {
        this.manager = manager;
    }
    
    public String getRemarks() {
        return remarks;
    }
    
    public void setRemarks(String remarks) {
        this.remarks = remarks;
    }
}
