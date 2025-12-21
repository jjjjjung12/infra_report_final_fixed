package com.infraReport.asset.dto;

import java.sql.Timestamp;

public class AssetDTO {
	
	//서비스
	private int serviceIdx;
	private String serviceAssetNo;
	private String serviceName;
	private Timestamp serviceCreatedDate;
	private String serviceCreatedBy;
    private Timestamp serviceUpdatedDate;
    private String serviceUpdatedBy;
	
	//하드웨어
	private int hardwareIdx;
	private String hardwareAssetNo;
	private String hardwareType;
	private String hardwareManufacturer;
	private String hardwareProductName;
	private String hardwareVersion;
	private String hardwareQuantity;
	private Timestamp hardwareCreatedDate;
	private String hardwareCreatedBy;
    private Timestamp hardwareUpdatedDate;
    private String hardwareUpdatedBy;
	
	//소프트웨어
    private int softwareIdx;
	private String softwareAssetNo;
	private String softwareType;
	private String softwareManufacturer;
	private String softwareProductName;
	private String softwareVersion;
	private String softwareQuantity;
	private Timestamp softwareCreatedDate;
	private String softwareCreatedBy;
    private Timestamp softwareUpdatedDate;
    private String softwareUpdatedBy;
    
	//하드웨어 구성 정보
    private int componentIdx;
    private String componentType;
    private String componentName;
    private String componentQuantity;
    private String componentDescription;
    private Timestamp componentCreatedDate;
	private String componentCreatedBy;
    private Timestamp componentUpdatedDate;
    private String componentUpdatedBy;
    
	//자원이력 정보
	private int historyIdx;
	private String historyAssetType;
	private int historyParentIdx;
	private String historyContent;
	private String historyRemark;
	private Timestamp historyCreatedDate;
	private String historyCreatedBy;
    private Timestamp historyUpdatedDate;
    private String historyUpdatedBy;
    
	//담당자 정보
    private int managerIdx;
	private String managerAssetType;
	private int managerParentIdx;
	private String managerName;
	private String managerPhoneNumber;
	private String managerMobileNumber;
	private String managerEmail;
	private Timestamp managerCreatedDate;
	private String managerCreatedBy;
    private Timestamp managerUpdatedDate;
    private String managerUpdatedBy;
    
	public int getServiceIdx() {
		return serviceIdx;
	}
	public void setServiceIdx(int serviceIdx) {
		this.serviceIdx = serviceIdx;
	}
	public String getServiceAssetNo() {
		return serviceAssetNo;
	}
	public void setServiceAssetNo(String serviceAssetNo) {
		this.serviceAssetNo = serviceAssetNo;
	}
	public String getServiceName() {
		return serviceName;
	}
	public void setServiceName(String serviceName) {
		this.serviceName = serviceName;
	}
	public Timestamp getServiceCreatedDate() {
		return serviceCreatedDate;
	}
	public void setServiceCreatedDate(Timestamp serviceCreatedDate) {
		this.serviceCreatedDate = serviceCreatedDate;
	}
	public String getServiceCreatedBy() {
		return serviceCreatedBy;
	}
	public void setServiceCreatedBy(String serviceCreatedBy) {
		this.serviceCreatedBy = serviceCreatedBy;
	}
	public Timestamp getServiceUpdatedDate() {
		return serviceUpdatedDate;
	}
	public void setServiceUpdatedDate(Timestamp serviceUpdatedDate) {
		this.serviceUpdatedDate = serviceUpdatedDate;
	}
	public String getServiceUpdatedBy() {
		return serviceUpdatedBy;
	}
	public void setServiceUpdatedBy(String serviceUpdatedBy) {
		this.serviceUpdatedBy = serviceUpdatedBy;
	}
	public int getHardwareIdx() {
		return hardwareIdx;
	}
	public void setHardwareIdx(int hardwareIdx) {
		this.hardwareIdx = hardwareIdx;
	}
	public String getHardwareAssetNo() {
		return hardwareAssetNo;
	}
	public void setHardwareAssetNo(String hardwareAssetNo) {
		this.hardwareAssetNo = hardwareAssetNo;
	}
	public String getHardwareType() {
		return hardwareType;
	}
	public void setHardwareType(String hardwareType) {
		this.hardwareType = hardwareType;
	}
	public String getHardwareManufacturer() {
		return hardwareManufacturer;
	}
	public void setHardwareManufacturer(String hardwareManufacturer) {
		this.hardwareManufacturer = hardwareManufacturer;
	}
	public String getHardwareProductName() {
		return hardwareProductName;
	}
	public void setHardwareProductName(String hardwareProductName) {
		this.hardwareProductName = hardwareProductName;
	}
	public String getHardwareVersion() {
		return hardwareVersion;
	}
	public void setHardwareVersion(String hardwareVersion) {
		this.hardwareVersion = hardwareVersion;
	}
	public String getHardwareQuantity() {
		return hardwareQuantity;
	}
	public void setHardwareQuantity(String hardwareQuantity) {
		this.hardwareQuantity = hardwareQuantity;
	}
	public Timestamp getHardwareCreatedDate() {
		return hardwareCreatedDate;
	}
	public void setHardwareCreatedDate(Timestamp hardwareCreatedDate) {
		this.hardwareCreatedDate = hardwareCreatedDate;
	}
	public String getHardwareCreatedBy() {
		return hardwareCreatedBy;
	}
	public void setHardwareCreatedBy(String hardwareCreatedBy) {
		this.hardwareCreatedBy = hardwareCreatedBy;
	}
	public Timestamp getHardwareUpdatedDate() {
		return hardwareUpdatedDate;
	}
	public void setHardwareUpdatedDate(Timestamp hardwareUpdatedDate) {
		this.hardwareUpdatedDate = hardwareUpdatedDate;
	}
	public String getHardwareUpdatedBy() {
		return hardwareUpdatedBy;
	}
	public void setHardwareUpdatedBy(String hardwareUpdatedBy) {
		this.hardwareUpdatedBy = hardwareUpdatedBy;
	}
	public int getSoftwareIdx() {
		return softwareIdx;
	}
	public void setSoftwareIdx(int softwareIdx) {
		this.softwareIdx = softwareIdx;
	}
	public String getSoftwareAssetNo() {
		return softwareAssetNo;
	}
	public void setSoftwareAssetNo(String softwareAssetNo) {
		this.softwareAssetNo = softwareAssetNo;
	}
	public String getSoftwareType() {
		return softwareType;
	}
	public void setSoftwareType(String softwareType) {
		this.softwareType = softwareType;
	}
	public String getSoftwareManufacturer() {
		return softwareManufacturer;
	}
	public void setSoftwareManufacturer(String softwareManufacturer) {
		this.softwareManufacturer = softwareManufacturer;
	}
	public String getSoftwareProductName() {
		return softwareProductName;
	}
	public void setSoftwareProductName(String softwareProductName) {
		this.softwareProductName = softwareProductName;
	}
	public String getSoftwareVersion() {
		return softwareVersion;
	}
	public void setSoftwareVersion(String softwareVersion) {
		this.softwareVersion = softwareVersion;
	}
	public String getSoftwareQuantity() {
		return softwareQuantity;
	}
	public void setSoftwareQuantity(String softwareQuantity) {
		this.softwareQuantity = softwareQuantity;
	}
	public Timestamp getSoftwareCreatedDate() {
		return softwareCreatedDate;
	}
	public void setSoftwareCreatedDate(Timestamp softwareCreatedDate) {
		this.softwareCreatedDate = softwareCreatedDate;
	}
	public String getSoftwareCreatedBy() {
		return softwareCreatedBy;
	}
	public void setSoftwareCreatedBy(String softwareCreatedBy) {
		this.softwareCreatedBy = softwareCreatedBy;
	}
	public Timestamp getSoftwareUpdatedDate() {
		return softwareUpdatedDate;
	}
	public void setSoftwareUpdatedDate(Timestamp softwareUpdatedDate) {
		this.softwareUpdatedDate = softwareUpdatedDate;
	}
	public String getSoftwareUpdatedBy() {
		return softwareUpdatedBy;
	}
	public void setSoftwareUpdatedBy(String softwareUpdatedBy) {
		this.softwareUpdatedBy = softwareUpdatedBy;
	}
	public int getComponentIdx() {
		return componentIdx;
	}
	public void setComponentIdx(int componentIdx) {
		this.componentIdx = componentIdx;
	}
	public String getComponentType() {
		return componentType;
	}
	public void setComponentType(String componentType) {
		this.componentType = componentType;
	}
	public String getComponentName() {
		return componentName;
	}
	public void setComponentName(String componentName) {
		this.componentName = componentName;
	}
	public String getComponentQuantity() {
		return componentQuantity;
	}
	public void setComponentQuantity(String componentQuantity) {
		this.componentQuantity = componentQuantity;
	}
	public String getComponentDescription() {
		return componentDescription;
	}
	public void setComponentDescription(String componentDescription) {
		this.componentDescription = componentDescription;
	}
	public Timestamp getComponentCreatedDate() {
		return componentCreatedDate;
	}
	public void setComponentCreatedDate(Timestamp componentCreatedDate) {
		this.componentCreatedDate = componentCreatedDate;
	}
	public String getComponentCreatedBy() {
		return componentCreatedBy;
	}
	public void setComponentCreatedBy(String componentCreatedBy) {
		this.componentCreatedBy = componentCreatedBy;
	}
	public Timestamp getComponentUpdatedDate() {
		return componentUpdatedDate;
	}
	public void setComponentUpdatedDate(Timestamp componentUpdatedDate) {
		this.componentUpdatedDate = componentUpdatedDate;
	}
	public String getComponentUpdatedBy() {
		return componentUpdatedBy;
	}
	public void setComponentUpdatedBy(String componentUpdatedBy) {
		this.componentUpdatedBy = componentUpdatedBy;
	}
	public int getHistoryIdx() {
		return historyIdx;
	}
	public void setHistoryIdx(int historyIdx) {
		this.historyIdx = historyIdx;
	}
	public String getHistoryAssetType() {
		return historyAssetType;
	}
	public void setHistoryAssetType(String historyAssetType) {
		this.historyAssetType = historyAssetType;
	}
	public int getHistoryParentIdx() {
		return historyParentIdx;
	}
	public void setHistoryParentIdx(int historyParentIdx) {
		this.historyParentIdx = historyParentIdx;
	}
	public String getHistoryContent() {
		return historyContent;
	}
	public void setHistoryContent(String historyContent) {
		this.historyContent = historyContent;
	}
	public String getHistoryRemark() {
		return historyRemark;
	}
	public void setHistoryRemark(String historyRemark) {
		this.historyRemark = historyRemark;
	}
	public Timestamp getHistoryCreatedDate() {
		return historyCreatedDate;
	}
	public void setHistoryCreatedDate(Timestamp historyCreatedDate) {
		this.historyCreatedDate = historyCreatedDate;
	}
	public String getHistoryCreatedBy() {
		return historyCreatedBy;
	}
	public void setHistoryCreatedBy(String historyCreatedBy) {
		this.historyCreatedBy = historyCreatedBy;
	}
	public Timestamp getHistoryUpdatedDate() {
		return historyUpdatedDate;
	}
	public void setHistoryUpdatedDate(Timestamp historyUpdatedDate) {
		this.historyUpdatedDate = historyUpdatedDate;
	}
	public String getHistoryUpdatedBy() {
		return historyUpdatedBy;
	}
	public void setHistoryUpdatedBy(String historyUpdatedBy) {
		this.historyUpdatedBy = historyUpdatedBy;
	}
	public int getManagerIdx() {
		return managerIdx;
	}
	public void setManagerIdx(int managerIdx) {
		this.managerIdx = managerIdx;
	}
	public String getManagerAssetType() {
		return managerAssetType;
	}
	public void setManagerAssetType(String managerAssetType) {
		this.managerAssetType = managerAssetType;
	}
	public int getManagerParentIdx() {
		return managerParentIdx;
	}
	public void setManagerParentIdx(int managerParentIdx) {
		this.managerParentIdx = managerParentIdx;
	}
	public String getManagerName() {
		return managerName;
	}
	public void setManagerName(String managerName) {
		this.managerName = managerName;
	}
	public String getManagerPhoneNumber() {
		return managerPhoneNumber;
	}
	public void setManagerPhoneNumber(String managerPhoneNumber) {
		this.managerPhoneNumber = managerPhoneNumber;
	}
	public String getManagerMobileNumber() {
		return managerMobileNumber;
	}
	public void setManagerMobileNumber(String managerMobileNumber) {
		this.managerMobileNumber = managerMobileNumber;
	}
	public String getManagerEmail() {
		return managerEmail;
	}
	public void setManagerEmail(String managerEmail) {
		this.managerEmail = managerEmail;
	}
	public Timestamp getManagerCreatedDate() {
		return managerCreatedDate;
	}
	public void setManagerCreatedDate(Timestamp managerCreatedDate) {
		this.managerCreatedDate = managerCreatedDate;
	}
	public String getManagerCreatedBy() {
		return managerCreatedBy;
	}
	public void setManagerCreatedBy(String managerCreatedBy) {
		this.managerCreatedBy = managerCreatedBy;
	}
	public Timestamp getManagerUpdatedDate() {
		return managerUpdatedDate;
	}
	public void setManagerUpdatedDate(Timestamp managerUpdatedDate) {
		this.managerUpdatedDate = managerUpdatedDate;
	}
	public String getManagerUpdatedBy() {
		return managerUpdatedBy;
	}
	public void setManagerUpdatedBy(String managerUpdatedBy) {
		this.managerUpdatedBy = managerUpdatedBy;
	}
}
