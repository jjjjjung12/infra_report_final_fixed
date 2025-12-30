package com.infraReport.asset.model;

import java.sql.Timestamp;

public class HistoryModel {
    private int idx;
    private String assetType;
    private int parentIdx;
    private String content;
    private String remark;
    private Timestamp createdDate;
    private String createdBy;
    private Timestamp updatedDate;
    private String updatedBy;
    
    public int getIdx() { return idx; }
    public void setIdx(int idx) { this.idx = idx; }
    public String getAssetType() { return assetType; }
    public void setAssetType(String assetType) { this.assetType = assetType; }
    public int getParentIdx() { return parentIdx; }
    public void setParentIdx(int parentIdx) { this.parentIdx = parentIdx; }
    public String getContent() { return content; }
    public void setContent(String content) { this.content = content; }
    public String getRemark() { return remark; }
    public void setRemark(String remark) { this.remark = remark; }
    public Timestamp getCreatedDate() { return createdDate; }
    public void setCreatedDate(Timestamp createdDate) { this.createdDate = createdDate; }
    public String getCreatedBy() { return createdBy; }
    public void setCreatedBy(String createdBy) { this.createdBy = createdBy; }
    public Timestamp getUpdatedDate() { return updatedDate; }
    public void setUpdatedDate(Timestamp updatedDate) { this.updatedDate = updatedDate; }
    public String getUpdatedBy() { return updatedBy; }
    public void setUpdatedBy(String updatedBy) { this.updatedBy = updatedBy; }
}
