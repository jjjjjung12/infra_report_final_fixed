package com.infraReport.security.dto;

import java.sql.Timestamp;

public class SecurityDTO {
	private int reportId;
    private String reportDate;
    private String taskType;
    private int detectionCount;
    private int blockedCount;
    private String detailInfo;
    private String actionStatus;
    private String status;
    private String manager;
    private Timestamp createdDate;
    private Timestamp updatedDate;
    private String createdBy;
    private String updatedBy;
    
    public int getReportId() { return reportId; }
    public void setReportId(int reportId) { this.reportId = reportId; }

    public String getReportDate() { return reportDate; }
    public void setReportDate(String reportDate) { this.reportDate = reportDate; }

    public String getTaskType() { return taskType; }
    public void setTaskType(String taskType) { this.taskType = taskType; }

    public int getDetectionCount() { return detectionCount; }
    public void setDetectionCount(int detectionCount) { this.detectionCount = detectionCount; }

    public int getBlockedCount() { return blockedCount; }
    public void setBlockedCount(int blockedCount) { this.blockedCount = blockedCount; }

    public String getDetailInfo() { return detailInfo; }
    public void setDetailInfo(String detailInfo) { this.detailInfo = detailInfo; }

    public String getActionStatus() { return actionStatus; }
    public void setActionStatus(String actionStatus) { this.actionStatus = actionStatus; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    
    public String getManager() { return manager; }
    public void setManager(String manager) { this.manager = manager; }

    public Timestamp getCreatedDate() { return createdDate; }
    public void setCreatedDate(Timestamp createdDate) { this.createdDate = createdDate; }

    public Timestamp getUpdatedDate() { return updatedDate; }
    public void setUpdatedDate(Timestamp updatedDate) { this.updatedDate = updatedDate; }

    public String getCreatedBy() { return createdBy; }
    public void setCreatedBy(String createdBy) { this.createdBy = createdBy; }

    public String getUpdatedBy() { return updatedBy; }
    public void setUpdatedBy(String updatedBy) { this.updatedBy = updatedBy; }

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
    
}
