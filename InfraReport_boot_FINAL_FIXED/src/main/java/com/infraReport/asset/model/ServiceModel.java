package com.infraReport.asset.model;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.regex.Pattern;

/**
 * 서비스 도메인 모델
 * - 비즈니스 로직 포함
 * - 유효성 검증
 * - 자산번호 자동 생성
 */
public class ServiceModel {
    
    private int idx;
    private String assetNo;
    private String name;
    private Timestamp createdDate;
    private String createdBy;
    private Timestamp updatedDate;
    private String updatedBy;
    
    // 연관 객체
    private List<HistoryModel> histories;
    private List<ManagerModel> managers;
    
    // 생성자
    public ServiceModel() {
        this.histories = new ArrayList<>();
        this.managers = new ArrayList<>();
    }
    
    public ServiceModel(String name) {
        this();
        this.name = name;
    }
    
    // ========================================
    // 비즈니스 로직
    // ========================================
    
    /**
     * 자산번호 자동 생성
     * 형식: SVC-YYYYMMDD-XXX
     */
    public String generateAssetNo() {
        String prefix = "SVC";
        String date = new SimpleDateFormat("yyyyMMdd").format(new Date());
        String sequence = String.format("%03d", idx > 0 ? idx : 1);
        this.assetNo = prefix + "-" + date + "-" + sequence;
        return this.assetNo;
    }
    
    /**
     * 서비스 유효성 검증
     */
    public ValidationResult validate() {
        ValidationResult result = new ValidationResult();
        
        // 서비스명 필수
        if (name == null || name.trim().isEmpty()) {
            result.addError("서비스명은 필수입니다.");
        }
        
        // 서비스명 길이 체크 (100자 제한)
        if (name != null && name.length() > 100) {
            result.addError("서비스명은 100자 이내여야 합니다.");
        }
        
        // 자산번호 형식 체크
        if (assetNo != null && !assetNo.isEmpty() && !isValidAssetNo(assetNo)) {
            result.addError("자산번호 형식이 올바르지 않습니다. (SVC-YYYYMMDD-XXX)");
        }
        
        return result;
    }
    
    /**
     * 자산번호 형식 검증
     */
    private boolean isValidAssetNo(String assetNo) {
        String pattern = "^SVC-\\d{8}-\\d{3}$";
        return Pattern.matches(pattern, assetNo);
    }
    
    /**
     * 이력 추가
     */
    public void addHistory(String content, String remark, String createdBy) {
        HistoryModel history = new HistoryModel();
        history.setAssetType("service");
        history.setParentIdx(this.idx);
        history.setContent(content);
        history.setRemark(remark);
        history.setCreatedBy(createdBy);
        this.histories.add(history);
    }
    
    /**
     * 담당자 추가
     */
    public void addManager(String name, String phoneNumber, String mobileNumber, String email, String createdBy) {
        ManagerModel manager = new ManagerModel();
        manager.setAssetType("service");
        manager.setParentIdx(this.idx);
        manager.setName(name);
        manager.setPhoneNumber(phoneNumber);
        manager.setMobileNumber(mobileNumber);
        manager.setEmail(email);
        manager.setCreatedBy(createdBy);
        this.managers.add(manager);
    }
    
    /**
     * 서비스 정보 요약
     */
    public String getSummary() {
        return String.format("[%s] %s (담당자: %d명, 이력: %d건)", 
            assetNo != null ? assetNo : "미발급", 
            name, 
            managers != null ? managers.size() : 0, 
            histories != null ? histories.size() : 0);
    }
    
    /**
     * 서비스명 존재 여부
     */
    public boolean hasName() {
        return name != null && !name.trim().isEmpty();
    }
    
    /**
     * 자산번호 존재 여부
     */
    public boolean hasAssetNo() {
        return assetNo != null && !assetNo.trim().isEmpty();
    }
    
    // ========================================
    // Getters & Setters
    // ========================================
    
    public int getIdx() {
        return idx;
    }
    
    public void setIdx(int idx) {
        this.idx = idx;
    }
    
    public String getAssetNo() {
        return assetNo;
    }
    
    public void setAssetNo(String assetNo) {
        this.assetNo = assetNo;
    }
    
    public String getName() {
        return name;
    }
    
    public void setName(String name) {
        this.name = name;
    }
    
    public Timestamp getCreatedDate() {
        return createdDate;
    }
    
    public void setCreatedDate(Timestamp createdDate) {
        this.createdDate = createdDate;
    }
    
    public String getCreatedBy() {
        return createdBy;
    }
    
    public void setCreatedBy(String createdBy) {
        this.createdBy = createdBy;
    }
    
    public Timestamp getUpdatedDate() {
        return updatedDate;
    }
    
    public void setUpdatedDate(Timestamp updatedDate) {
        this.updatedDate = updatedDate;
    }
    
    public String getUpdatedBy() {
        return updatedBy;
    }
    
    public void setUpdatedBy(String updatedBy) {
        this.updatedBy = updatedBy;
    }
    
    public List<HistoryModel> getHistories() {
        return histories;
    }
    
    public void setHistories(List<HistoryModel> histories) {
        this.histories = histories;
    }
    
    public List<ManagerModel> getManagers() {
        return managers;
    }
    
    public void setManagers(List<ManagerModel> managers) {
        this.managers = managers;
    }
    
    @Override
    public String toString() {
        return "ServiceModel{" +
                "idx=" + idx +
                ", assetNo='" + assetNo + '\'' +
                ", name='" + name + '\'' +
                ", createdBy='" + createdBy + '\'' +
                ", histories=" + (histories != null ? histories.size() : 0) +
                ", managers=" + (managers != null ? managers.size() : 0) +
                '}';
    }
}
