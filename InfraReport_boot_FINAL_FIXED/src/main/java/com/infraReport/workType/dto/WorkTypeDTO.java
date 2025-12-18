package com.infraReport.workType.dto;

import java.sql.Timestamp;

public class WorkTypeDTO {
	private int reportId;
    private String reportDate;
    private String serviceCategory;  // NEIS, K-EDUFINE, COMMON
    private String serviceName;
    private String taskDescription;
    private String taskType;
    private String status;
    private String checkTime;
    private String manager;
    private String department;
    private String remarks;
    private String priority;
    private Timestamp createdDate;
    private Timestamp updatedDate;
    private String createdBy;
    private String updatedBy;
    
    // 기본 생성자
	public WorkTypeDTO() {
	    this.priority = "보통";
	    this.status = "정상";
	    this.serviceCategory = "COMMON";
	}
	
    public int getReportId() { return reportId; }
    public void setReportId(int reportId) { this.reportId = reportId; }

    public String getReportDate() { return reportDate; }
    public void setReportDate(String reportDate) { this.reportDate = reportDate; }

    public String getServiceCategory() { return serviceCategory; }
    public void setServiceCategory(String serviceCategory) { this.serviceCategory = serviceCategory; }

    public String getServiceName() { return serviceName; }
    public void setServiceName(String serviceName) { this.serviceName = serviceName; }

    public String getTaskDescription() { return taskDescription; }
    public void setTaskDescription(String taskDescription) { this.taskDescription = taskDescription; }

    public String getTaskType() { return taskType; }
    public void setTaskType(String taskType) { this.taskType = taskType; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public String getCheckTime() { return checkTime; }
    public void setCheckTime(String checkTime) { this.checkTime = checkTime; }

    public String getManager() { return manager; }
    public void setManager(String manager) { this.manager = manager; }

    public String getDepartment() { return department; }
    public void setDepartment(String department) { this.department = department; }

    public String getRemarks() { return remarks; }
    public void setRemarks(String remarks) { this.remarks = remarks; }

    public String getPriority() { return priority; }
    public void setPriority(String priority) { this.priority = priority; }

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
