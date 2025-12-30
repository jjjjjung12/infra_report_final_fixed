package com.infraReport.asset.model;

import java.sql.Timestamp;
import java.util.regex.Pattern;

public class ManagerModel {
    private int idx;
    private String assetType;
    private int parentIdx;
    private String name;
    private String phoneNumber;
    private String mobileNumber;
    private String email;
    private Timestamp createdDate;
    private String createdBy;
    private Timestamp updatedDate;
    private String updatedBy;
    
    public ValidationResult validate() {
        ValidationResult result = new ValidationResult();
        if (name == null || name.trim().isEmpty()) result.addError("담당자 이름은 필수입니다.");
        if (mobileNumber == null || mobileNumber.trim().isEmpty()) result.addError("핸드폰번호는 필수입니다.");
        if (email == null || email.trim().isEmpty()) result.addError("이메일은 필수입니다.");
        if (email != null && !Pattern.matches("^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,6}$", email)) {
            result.addError("이메일 형식이 올바르지 않습니다.");
        }
        return result;
    }
    
    public int getIdx() { return idx; }
    public void setIdx(int idx) { this.idx = idx; }
    public String getAssetType() { return assetType; }
    public void setAssetType(String assetType) { this.assetType = assetType; }
    public int getParentIdx() { return parentIdx; }
    public void setParentIdx(int parentIdx) { this.parentIdx = parentIdx; }
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    public String getPhoneNumber() { return phoneNumber; }
    public void setPhoneNumber(String phoneNumber) { this.phoneNumber = phoneNumber; }
    public String getMobileNumber() { return mobileNumber; }
    public void setMobileNumber(String mobileNumber) { this.mobileNumber = mobileNumber; }
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    public Timestamp getCreatedDate() { return createdDate; }
    public void setCreatedDate(Timestamp createdDate) { this.createdDate = createdDate; }
    public String getCreatedBy() { return createdBy; }
    public void setCreatedBy(String createdBy) { this.createdBy = createdBy; }
    public Timestamp getUpdatedDate() { return updatedDate; }
    public void setUpdatedDate(Timestamp updatedDate) { this.updatedDate = updatedDate; }
    public String getUpdatedBy() { return updatedBy; }
    public void setUpdatedBy(String updatedBy) { this.updatedBy = updatedBy; }
}
