package com.infraReport.backup.dto;

import java.sql.Timestamp;

public class BackupDTO {
	private int reportId;
    private String reportDate;
    private String serviceName;
    private String backupType;
    private String backupLibrary;
    private String backupCategory;
    private int backupLevel;
    private String backupStatus;
    private String status;
    private String remarks;
    private Timestamp createdDate;
    private Timestamp updatedDate;
    private String createdBy;
    private String updatedBy;
    
    public int getReportId() { return reportId; }
    public void setReportId(int reportId) { this.reportId = reportId; }

    public String getReportDate() { return reportDate; }
    public void setReportDate(String reportDate) { this.reportDate = reportDate; }

    public String getServiceName() { return serviceName; }
    public void setServiceName(String serviceName) { this.serviceName = serviceName; }

    public String getBackupType() { return backupType; }
    public void setBackupType(String backupType) { this.backupType = backupType; }

    public String getBackupLibrary() { return backupLibrary; }
    public void setBackupLibrary(String backupLibrary) { this.backupLibrary = backupLibrary; }

    public String getBackupCategory() { return backupCategory; }
    public void setBackupCategory(String backupCategory) { this.backupCategory = backupCategory; }

    public int getBackupLevel() { return backupLevel; }
    public void setBackupLevel(int backupLevel) { this.backupLevel = backupLevel; }

    public String getBackupStatus() { return backupStatus; }
    public void setBackupStatus(String backupStatus) { this.backupStatus = backupStatus; }
    
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    
    public String getRemarks() { return remarks; }
    public void setRemarks(String remarks) { this.remarks = remarks; }
    
    public Timestamp getCreatedDate() { return createdDate; }
    public void setCreatedDate(Timestamp createdDate) { this.createdDate = createdDate; }

    public Timestamp getUpdatedDate() { return updatedDate; }
    public void setUpdatedDate(Timestamp updatedDate) { this.updatedDate = updatedDate; }
    
    public String getCreatedBy() { return createdBy; }
    public void setCreatedBy(String createdBy) { this.createdBy = createdBy; }

    public String getUpdatedBy() { return updatedBy; }
    public void setUpdatedBy(String updatedBy) { this.updatedBy = updatedBy; }
    
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
