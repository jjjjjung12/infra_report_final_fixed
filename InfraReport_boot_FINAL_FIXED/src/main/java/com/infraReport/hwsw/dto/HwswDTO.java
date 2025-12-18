package com.infraReport.hwsw.dto;

import java.sql.Timestamp;

public class HwswDTO {
	private int reportId;
    private String reportDate;
    private String serverName;
    private String checkItem;
    private String checkContent;
    private String checkResult;  // O/X
    private String errorContent;
    private String actionTaken;
    private String manager;
    private Timestamp createdDate;
    private Timestamp updatedDate;
    private String createdBy;
    private String updatedBy;
    
    public int getReportId() { return reportId; }
    public void setReportId(int reportId) { this.reportId = reportId; }

    public String getReportDate() { return reportDate; }
    public void setReportDate(String reportDate) { this.reportDate = reportDate; }

    public String getServerName() { return serverName; }
    public void setServerName(String serverName) { this.serverName = serverName; }

    public String getCheckItem() { return checkItem; }
    public void setCheckItem(String checkItem) { this.checkItem = checkItem; }

    public String getCheckContent() { return checkContent; }
    public void setCheckContent(String checkContent) { this.checkContent = checkContent; }

    public String getCheckResult() { return checkResult; }
    public void setCheckResult(String checkResult) { this.checkResult = checkResult; }

    public String getErrorContent() { return errorContent; }
    public void setErrorContent(String errorContent) { this.errorContent = errorContent; }

    public String getActionTaken() { return actionTaken; }
    public void setActionTaken(String actionTaken) { this.actionTaken = actionTaken; }

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
    
    public String getCheckResultClass() {
        return "O".equals(checkResult) ? "result-success" : "result-fail";
    }

}
