// ============= 3. DailyReportStatDTO.java - 통계 DTO =============
package com.infraReport.report.dto;

public class DailyReportStatDTO {
    private String reportDate;
    private int totalTasks;
    private int normalCount;
    private int warningCount;
    private int errorCount;
    private double normalRate;
    
    // 업무유형별 카운트
    private int dailyCheckCount;      // 일상점검
    private int securityCheckCount;   // 보안점검
    private int systemMgmtCount;      // 시스템관리
    private int specialCheckCount;    // 특별점검
    private int regularCheckCount;    // 정기점검
    private int incidentCount;        // 장애대응
    private int workCount;            // 작업
    
    public DailyReportStatDTO() {}
    
    public DailyReportStatDTO(String reportDate, int totalTasks, 
                             int normalCount, int warningCount, int errorCount) {
        this.reportDate = reportDate;
        this.totalTasks = totalTasks;
        this.normalCount = normalCount;
        this.warningCount = warningCount;
        this.errorCount = errorCount;
        
        if (totalTasks > 0) {
            this.normalRate = (double) normalCount / totalTasks * 100;
        } else {
            this.normalRate = 0.0;
        }
    }
    
    // Getter/Setter
    public String getReportDate() { return reportDate; }
    public void setReportDate(String reportDate) { this.reportDate = reportDate; }
    
    public int getTotalTasks() { return totalTasks; }
    public void setTotalTasks(int totalTasks) { this.totalTasks = totalTasks; }
    
    public int getNormalCount() { return normalCount; }
    public void setNormalCount(int normalCount) { this.normalCount = normalCount; }
    
    public int getWarningCount() { return warningCount; }
    public void setWarningCount(int warningCount) { this.warningCount = warningCount; }
    
    public int getErrorCount() { return errorCount; }
    public void setErrorCount(int errorCount) { this.errorCount = errorCount; }
    
    public double getNormalRate() { return normalRate; }
    public void setNormalRate(double normalRate) { this.normalRate = normalRate; }
    
    public int getDailyCheckCount() { return dailyCheckCount; }
    public void setDailyCheckCount(int dailyCheckCount) { this.dailyCheckCount = dailyCheckCount; }
    
    public int getSecurityCheckCount() { return securityCheckCount; }
    public void setSecurityCheckCount(int securityCheckCount) { this.securityCheckCount = securityCheckCount; }
    
    public int getSystemMgmtCount() { return systemMgmtCount; }
    public void setSystemMgmtCount(int systemMgmtCount) { this.systemMgmtCount = systemMgmtCount; }
    
    public int getSpecialCheckCount() { return specialCheckCount; }
    public void setSpecialCheckCount(int specialCheckCount) { this.specialCheckCount = specialCheckCount; }
    
    public int getRegularCheckCount() { return regularCheckCount; }
    public void setRegularCheckCount(int regularCheckCount) { this.regularCheckCount = regularCheckCount; }
    
    public int getIncidentCount() { return incidentCount; }
    public void setIncidentCount(int incidentCount) { this.incidentCount = incidentCount; }
    
    public int getWorkCount() { return workCount; }
    public void setWorkCount(int workCount) { this.workCount = workCount; }
}