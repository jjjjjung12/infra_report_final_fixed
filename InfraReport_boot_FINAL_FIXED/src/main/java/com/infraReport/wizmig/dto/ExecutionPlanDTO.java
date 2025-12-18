package com.infraReport.wizmig.dto;

import java.time.LocalDateTime;
import java.util.List;

/**
 * 실행 계획 DTO
 */
public class ExecutionPlanDTO {
    private Long planId;
    private String planName;
    private String description;
    private String sessionName;
    private String status; // READY, RUNNING, COMPLETED, FAILED, PAUSED
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
    private LocalDateTime startedAt;
    private LocalDateTime completedAt;
    private String createdBy;
    private List<ExecutionStepDTO> steps;
    
    // Getters and Setters
    public Long getPlanId() {
        return planId;
    }
    
    public void setPlanId(Long planId) {
        this.planId = planId;
    }
    
    public String getPlanName() {
        return planName;
    }
    
    public void setPlanName(String planName) {
        this.planName = planName;
    }
    
    public String getDescription() {
        return description;
    }
    
    public void setDescription(String description) {
        this.description = description;
    }
    
    public String getSessionName() {
        return sessionName;
    }
    
    public void setSessionName(String sessionName) {
        this.sessionName = sessionName;
    }
    
    public String getStatus() {
        return status;
    }
    
    public void setStatus(String status) {
        this.status = status;
    }
    
    public LocalDateTime getCreatedAt() {
        return createdAt;
    }
    
    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }
    
    public LocalDateTime getUpdatedAt() {
        return updatedAt;
    }
    
    public void setUpdatedAt(LocalDateTime updatedAt) {
        this.updatedAt = updatedAt;
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
    
    public String getCreatedBy() {
        return createdBy;
    }
    
    public void setCreatedBy(String createdBy) {
        this.createdBy = createdBy;
    }
    
    public List<ExecutionStepDTO> getSteps() {
        return steps;
    }
    
    public void setSteps(List<ExecutionStepDTO> steps) {
        this.steps = steps;
    }
}
