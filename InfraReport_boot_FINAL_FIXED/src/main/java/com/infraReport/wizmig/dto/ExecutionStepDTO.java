package com.infraReport.wizmig.dto;

import java.time.LocalDateTime;

/**
 * 실행 단계 DTO
 */
public class ExecutionStepDTO {
    private Long stepId;
    private Long planId;
    private Integer stepOrder;
    private String scriptName;
    private String scriptPath;
    private String arguments;
    private String status; // PENDING, RUNNING, COMPLETED, FAILED, SKIPPED, TIMEOUT
    private Integer timeoutMinutes; // 타임아웃 시간 (분)
    private String onTimeout; // SKIP, FAIL, CONTINUE - 타임아웃 시 동작
    private String onError; // SKIP, FAIL, RETRY, CONTINUE - 에러 시 동작
    private Integer maxRetries; // 최대 재시도 횟수
    private Integer currentRetry; // 현재 재시도 횟수
    private String pid;
    private String apid;
    private String logFile;
    private String result;
    private LocalDateTime startedAt;
    private LocalDateTime completedAt;
    private Long executionTime; // 실행 시간 (초)
    
    // Getters and Setters
    public Long getStepId() {
        return stepId;
    }
    
    public void setStepId(Long stepId) {
        this.stepId = stepId;
    }
    
    public Long getPlanId() {
        return planId;
    }
    
    public void setPlanId(Long planId) {
        this.planId = planId;
    }
    
    public Integer getStepOrder() {
        return stepOrder;
    }
    
    public void setStepOrder(Integer stepOrder) {
        this.stepOrder = stepOrder;
    }
    
    public String getScriptName() {
        return scriptName;
    }
    
    public void setScriptName(String scriptName) {
        this.scriptName = scriptName;
    }
    
    public String getScriptPath() {
        return scriptPath;
    }
    
    public void setScriptPath(String scriptPath) {
        this.scriptPath = scriptPath;
    }
    
    public String getArguments() {
        return arguments;
    }
    
    public void setArguments(String arguments) {
        this.arguments = arguments;
    }
    
    public String getStatus() {
        return status;
    }
    
    public void setStatus(String status) {
        this.status = status;
    }
    
    public Integer getTimeoutMinutes() {
        return timeoutMinutes;
    }
    
    public void setTimeoutMinutes(Integer timeoutMinutes) {
        this.timeoutMinutes = timeoutMinutes;
    }
    
    public String getOnTimeout() {
        return onTimeout;
    }
    
    public void setOnTimeout(String onTimeout) {
        this.onTimeout = onTimeout;
    }
    
    public String getOnError() {
        return onError;
    }
    
    public void setOnError(String onError) {
        this.onError = onError;
    }
    
    public Integer getMaxRetries() {
        return maxRetries;
    }
    
    public void setMaxRetries(Integer maxRetries) {
        this.maxRetries = maxRetries;
    }
    
    public Integer getCurrentRetry() {
        return currentRetry;
    }
    
    public void setCurrentRetry(Integer currentRetry) {
        this.currentRetry = currentRetry;
    }
    
    public String getPid() {
        return pid;
    }
    
    public void setPid(String pid) {
        this.pid = pid;
    }
    
    public String getApid() {
        return apid;
    }
    
    public void setApid(String apid) {
        this.apid = apid;
    }
    
    public String getLogFile() {
        return logFile;
    }
    
    public void setLogFile(String logFile) {
        this.logFile = logFile;
    }
    
    public String getResult() {
        return result;
    }
    
    public void setResult(String result) {
        this.result = result;
    }
    
    public LocalDateTime getStartedAt() {
        return startedAt;
    }
    
    public void setStartedAt(LocalDateTime startedAt) {
        this.startedAt = startedAt;
    }
    
    public LocalDateTime getCompletedAt() {
        return completedAt;
    }
    
    public void setCompletedAt(LocalDateTime completedAt) {
        this.completedAt = completedAt;
    }
    
    public Long getExecutionTime() {
        return executionTime;
    }
    
    public void setExecutionTime(Long executionTime) {
        this.executionTime = executionTime;
    }
}
