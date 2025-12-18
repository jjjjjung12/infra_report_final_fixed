package com.infraReport.work.domain;

/**
 * 작업 문서 템플릿 도메인
 */
public class WorkDocumentTemplate {
    
    private Long templateId;
    private String stage;
    private String documentType;
    private String documentName;
    private String templateFilePath;
    private String templateFileName;
    private Integer sortOrder;
    private Boolean isRequired;
    private String description;
    
    // Getters and Setters
    public Long getTemplateId() {
        return templateId;
    }
    
    public void setTemplateId(Long templateId) {
        this.templateId = templateId;
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
    
    public String getTemplateFilePath() {
        return templateFilePath;
    }
    
    public void setTemplateFilePath(String templateFilePath) {
        this.templateFilePath = templateFilePath;
    }
    
    public String getTemplateFileName() {
        return templateFileName;
    }
    
    public void setTemplateFileName(String templateFileName) {
        this.templateFileName = templateFileName;
    }
    
    public Integer getSortOrder() {
        return sortOrder;
    }
    
    public void setSortOrder(Integer sortOrder) {
        this.sortOrder = sortOrder;
    }
    
    public Boolean getIsRequired() {
        return isRequired;
    }
    
    public void setIsRequired(Boolean isRequired) {
        this.isRequired = isRequired;
    }
    
    public String getDescription() {
        return description;
    }
    
    public void setDescription(String description) {
        this.description = description;
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
    
    public boolean hasTemplate() {
        return templateFilePath != null && !templateFilePath.isEmpty();
    }
}
