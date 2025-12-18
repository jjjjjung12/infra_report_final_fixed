package com.infraReport.work.domain;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

/**
 * 단계별 문서 도메인
 */
public class StageDocument {
    
    private static final DateTimeFormatter FORMATTER = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");
    
    private Long documentId;
    private Long projectId;
    private String stage;
    private String documentType;
    private String documentName;
    private String filePath;
    private String fileName;
    private String originalFileName;
    private LocalDateTime uploadDate;
    private String documentStatus;
    private String approverId;
    private LocalDateTime approvalDate;
    private String rejectReason;
    private String comments;
    
    // 조인용 필드
    private String approverName;
    private String projectName;
    private String userName;
    
    // Getters and Setters
    public Long getDocumentId() {
        return documentId;
    }
    
    public void setDocumentId(Long documentId) {
        this.documentId = documentId;
    }
    
    public Long getProjectId() {
        return projectId;
    }
    
    public void setProjectId(Long projectId) {
        this.projectId = projectId;
    }
    
    public String getStage() {
        return stage;
    }
    
    public void setStage(String stage) {
        this.stage = stage;
    }
    
    public String getDocumentType() {
        return documentType;
    }
    
    public void setDocumentType(String documentType) {
        this.documentType = documentType;
    }
    
    public String getDocumentName() {
        return documentName;
    }
    
    public void setDocumentName(String documentName) {
        this.documentName = documentName;
    }
    
    public String getFilePath() {
        return filePath;
    }
    
    public void setFilePath(String filePath) {
        this.filePath = filePath;
    }
    
    public String getFileName() {
        return fileName;
    }
    
    public void setFileName(String fileName) {
        this.fileName = fileName;
    }
    
    public String getOriginalFileName() {
        return originalFileName;
    }
    
    public void setOriginalFileName(String originalFileName) {
        this.originalFileName = originalFileName;
    }
    
    public LocalDateTime getUploadDate() {
        return uploadDate;
    }
    
    public void setUploadDate(LocalDateTime uploadDate) {
        this.uploadDate = uploadDate;
    }
    
    public String getDocumentStatus() {
        return documentStatus;
    }
    
    public void setDocumentStatus(String documentStatus) {
        this.documentStatus = documentStatus;
    }
    
    public String getApproverId() {
        return approverId;
    }
    
    public void setApproverId(String approverId) {
        this.approverId = approverId;
    }
    
    public LocalDateTime getApprovalDate() {
        return approvalDate;
    }
    
    public void setApprovalDate(LocalDateTime approvalDate) {
        this.approvalDate = approvalDate;
    }
    
    public String getRejectReason() {
        return rejectReason;
    }
    
    public void setRejectReason(String rejectReason) {
        this.rejectReason = rejectReason;
    }
    
    public String getComments() {
        return comments;
    }
    
    public void setComments(String comments) {
        this.comments = comments;
    }
    
    public String getApproverName() {
        return approverName;
    }
    
    public void setApproverName(String approverName) {
        this.approverName = approverName;
    }
    
    public String getProjectName() {
        return projectName;
    }
    
    public void setProjectName(String projectName) {
        this.projectName = projectName;
    }
    
    public String getUserName() {
        return userName;
    }
    
    public void setUserName(String userName) {
        this.userName = userName;
    }
    
    // 유틸리티 메서드
    public String getStageName() {
        if (stage == null) return "";
        switch (stage) {
            case "INITIATION": return "착수";
            case "CONSTRUCTION": return "구축";
            case "COMPLETION": return "완료";
            default: return stage;
        }
    }
    
    public String getStatusName() {
        if (documentStatus == null) return "";
        switch (documentStatus) {
            case "NOT_UPLOADED": return "미제출";
            case "PENDING": return "검토중";
            case "APPROVED": return "승인";
            case "REJECTED": return "반려";
            default: return documentStatus;
        }
    }
    
    public String getStatusBadgeClass() {
        if (documentStatus == null) return "secondary";
        switch (documentStatus) {
            case "NOT_UPLOADED": return "secondary";
            case "PENDING": return "warning";
            case "APPROVED": return "success";
            case "REJECTED": return "danger";
            default: return "secondary";
        }
    }
    
    public String getFormattedUploadDate() {
        return uploadDate != null ? uploadDate.format(FORMATTER) : "";
    }
    
    public String getFormattedApprovalDate() {
        return approvalDate != null ? approvalDate.format(FORMATTER) : "";
    }
    
    // [Modified] Renamed to allow JSON serialization (isUploaded -> uploaded in JS)
    public boolean getUploaded() {
        return filePath != null && !filePath.isEmpty();
    }
    
    // [Modified] Renamed to allow JSON serialization (canUpload -> canUpload in JS)
    public boolean getCanUpload() {
        return "NOT_UPLOADED".equals(documentStatus) || "REJECTED".equals(documentStatus);
    }
    
    // [Modified] Renamed to allow JSON serialization (canApprove -> canApprove in JS)
    public boolean getCanApprove() {
        return "PENDING".equals(documentStatus);
    }
}