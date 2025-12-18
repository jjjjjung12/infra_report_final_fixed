// ============= 2. CommonCodeDTO.java - 공통코드 DTO =============
package com.infraReport.report.dto;

import java.sql.Timestamp;

public class CommonCodeDTO {
    private String cdType;
    private String cdTypeName;
    private int cdVal;
    private String cdName;
    private String useYn;
    private int sortOrder;
    private Timestamp createdDate;
    
    public CommonCodeDTO() {
        this.useYn = "Y";
    }
    
    public CommonCodeDTO(String cdType, int cdVal, String cdName) {
        this();
        this.cdType = cdType;
        this.cdVal = cdVal;
        this.cdName = cdName;
    }
    
    // Getter/Setter
    public String getCdType() { return cdType; }
    public void setCdType(String cdType) { this.cdType = cdType; }
    
    public String getCdTypeName() { return cdTypeName; }
    public void setCdTypeName(String cdTypeName) { this.cdTypeName = cdTypeName; }
    
    public int getCdVal() { return cdVal; }
    public void setCdVal(int cdVal) { this.cdVal = cdVal; }
    
    public String getCdName() { return cdName; }
    public void setCdName(String cdName) { this.cdName = cdName; }
    
    public String getUseYn() { return useYn; }
    public void setUseYn(String useYn) { this.useYn = useYn; }
    
    public int getSortOrder() { return sortOrder; }
    public void setSortOrder(int sortOrder) { this.sortOrder = sortOrder; }
    
    public Timestamp getCreatedDate() { return createdDate; }
    public void setCreatedDate(Timestamp createdDate) { this.createdDate = createdDate; }
    
    public boolean isUsed() {
        return "Y".equals(useYn);
    }
}