package com.infraReport.asset.model;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * 하드웨어 도메인 모델
 */
public class HardwareModel {
    
    private int idx;
    private int serviceIdx;
    private String assetNo;
    private String type;
    private String manufacturer;
    private String productName;
    private String version;
    private String quantity;
    private Timestamp createdDate;
    private String createdBy;
    private Timestamp updatedDate;
    private String updatedBy;
    
    private List<ComponentModel> components = new ArrayList<>();
    private List<HistoryModel> histories = new ArrayList<>();
    private List<ManagerModel> managers = new ArrayList<>();
    
    public String generateAssetNo() {
        String prefix = "HW";
        String date = new SimpleDateFormat("yyyyMMdd").format(new Date());
        String sequence = String.format("%03d", idx > 0 ? idx : 1);
        this.assetNo = prefix + "-" + date + "-" + sequence;
        return this.assetNo;
    }
    
    public ValidationResult validate() {
        ValidationResult result = new ValidationResult();
        if (type == null || type.trim().isEmpty()) result.addError("HW 구분은 필수입니다.");
        if (manufacturer == null || manufacturer.trim().isEmpty()) result.addError("제조사는 필수입니다.");
        if (productName == null || productName.trim().isEmpty()) result.addError("제품명은 필수입니다.");
        if (version == null || version.trim().isEmpty()) result.addError("버전은 필수입니다.");
        if (quantity == null || quantity.trim().isEmpty()) result.addError("개수는 필수입니다.");
        return result;
    }
    
    public void addComponent(String type, String name, String quantity, String description) {
        ComponentModel component = new ComponentModel();
        component.setHardwareIdx(this.idx);
        component.setType(type);
        component.setName(name);
        component.setQuantity(quantity);
        component.setDescription(description);
        this.components.add(component);
    }
    
    public String getSummary() {
        return String.format("[%s] %s %s %s", 
            assetNo != null ? assetNo : "미발급", manufacturer, productName, version);
    }
    
    // Getters & Setters
    public int getIdx() { return idx; }
    public void setIdx(int idx) { this.idx = idx; }
    public int getServiceIdx() { return serviceIdx; }
    public void setServiceIdx(int serviceIdx) { this.serviceIdx = serviceIdx; }
    public String getAssetNo() { return assetNo; }
    public void setAssetNo(String assetNo) { this.assetNo = assetNo; }
    public String getType() { return type; }
    public void setType(String type) { this.type = type; }
    public String getManufacturer() { return manufacturer; }
    public void setManufacturer(String manufacturer) { this.manufacturer = manufacturer; }
    public String getProductName() { return productName; }
    public void setProductName(String productName) { this.productName = productName; }
    public String getVersion() { return version; }
    public void setVersion(String version) { this.version = version; }
    public String getQuantity() { return quantity; }
    public void setQuantity(String quantity) { this.quantity = quantity; }
    public Timestamp getCreatedDate() { return createdDate; }
    public void setCreatedDate(Timestamp createdDate) { this.createdDate = createdDate; }
    public String getCreatedBy() { return createdBy; }
    public void setCreatedBy(String createdBy) { this.createdBy = createdBy; }
    public Timestamp getUpdatedDate() { return updatedDate; }
    public void setUpdatedDate(Timestamp updatedDate) { this.updatedDate = updatedDate; }
    public String getUpdatedBy() { return updatedBy; }
    public void setUpdatedBy(String updatedBy) { this.updatedBy = updatedBy; }
    public List<ComponentModel> getComponents() { return components; }
    public void setComponents(List<ComponentModel> components) { this.components = components; }
    public List<HistoryModel> getHistories() { return histories; }
    public void setHistories(List<HistoryModel> histories) { this.histories = histories; }
    public List<ManagerModel> getManagers() { return managers; }
    public void setManagers(List<ManagerModel> managers) { this.managers = managers; }
}
