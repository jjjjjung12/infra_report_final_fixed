package com.infraReport.resource.dto;

import java.sql.Timestamp;

public class ResourceDTO {
	private int reportId;
    private String reportDate;
    private String serverName;
    private String resourceType;
    private double usagePercent;
    private double totalAmount;
    private double usedAmount;
    private double availableAmount;
    private String status;
    private String resourceStatus;
    private String monitoringTime;
    private Timestamp createdDate;
    private String createdBy;
    
    public int getReportId() { return reportId; }
    public void setReportId(int reportId) { this.reportId = reportId; }

    public String getReportDate() { return reportDate; }
    public void setReportDate(String reportDate) { this.reportDate = reportDate; }
    
    public String getServerName() { return serverName; }
    public void setServerName(String serverName) { this.serverName = serverName; }

    public String getResourceType() { return resourceType; }
    public void setResourceType(String resourceType) { this.resourceType = resourceType; }

    public double getUsagePercent() { return usagePercent; }
    public void setUsagePercent(double usagePercent) { this.usagePercent = usagePercent; }

    public double getTotalAmount() { return totalAmount; }
    public void setTotalAmount(double totalAmount) { this.totalAmount = totalAmount; }

    public double getUsedAmount() { return usedAmount; }
    public void setUsedAmount(double usedAmount) { this.usedAmount = usedAmount; }

    public double getAvailableAmount() { return availableAmount; }
    public void setAvailableAmount(double availableAmount) { this.availableAmount = availableAmount; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public String getResourceStatus() { return resourceStatus; }
    public void setResourceStatus(String resourceStatus) { this.resourceStatus = resourceStatus; }
    
    public String getMonitoringTime() { return monitoringTime; }
    public void setMonitoringTime(String monitoringTime) { this.monitoringTime = monitoringTime; }

    public Timestamp getCreatedDate() { return createdDate; }
    public void setCreatedDate(Timestamp createdDate) { this.createdDate = createdDate; }

    public String getCreatedBy() { return createdBy; }
    public void setCreatedBy(String createdBy) { this.createdBy = createdBy; }
    
    // 유틸리티 메소드
    public String getStatusClass() {
        switch (status) {
            case "정상": return "status-normal";
            case "주의": return "status-warning";
            case "장애": return "status-error";
            case "위험": return "status-error";
            case "성공": return "status-normal";
            case "실패": return "status-error";
            default: return "status-normal";
        }
    }
    
    // 자원 상태 클래스 (기존 status와 구분)
    public String getResourceStatusClass() {
        if (resourceStatus == null) return getStatusClass(); // 기존 status 사용
        
        switch (resourceStatus) {
            case "정상": return "status-normal";
            case "주의": return "status-warning";
            case "위험": return "status-error";
            default: return "status-normal";
        }
    }

}
