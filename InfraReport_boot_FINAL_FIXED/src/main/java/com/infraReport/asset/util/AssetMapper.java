package com.infraReport.asset.util;

import com.infraReport.asset.dto.AssetDTO;
import com.infraReport.asset.model.*;

import java.util.ArrayList;
import java.util.List;

/**
 * DTO ↔ Model 변환 유틸리티
 * 
 * 사용법:
 * - ServiceModel model = AssetMapper.toServiceModel(dto);
 * - AssetDTO dto = AssetMapper.fromServiceModel(model);
 */
public class AssetMapper {
    
    // ========================================
    // Service 변환
    // ========================================
    
    /**
     * DTO → ServiceModel
     */
    public static ServiceModel toServiceModel(AssetDTO dto) {
        if (dto == null) return null;
        
        ServiceModel model = new ServiceModel();
        model.setIdx(dto.getServiceIdx());
        model.setAssetNo(dto.getServiceAssetNo());
        model.setName(dto.getServiceName());
        model.setCreatedDate(dto.getServiceCreatedDate());
        model.setCreatedBy(dto.getServiceCreatedBy());
        model.setUpdatedDate(dto.getServiceUpdatedDate());
        model.setUpdatedBy(dto.getServiceUpdatedBy());
        
        return model;
    }
    
    /**
     * ServiceModel → DTO
     */
    public static AssetDTO fromServiceModel(ServiceModel model) {
        if (model == null) return null;
        
        AssetDTO dto = new AssetDTO();
        dto.setServiceIdx(model.getIdx());
        dto.setServiceAssetNo(model.getAssetNo());
        dto.setServiceName(model.getName());
        dto.setServiceCreatedDate(model.getCreatedDate());
        dto.setServiceCreatedBy(model.getCreatedBy());
        dto.setServiceUpdatedDate(model.getUpdatedDate());
        dto.setServiceUpdatedBy(model.getUpdatedBy());
        
        return dto;
    }
    
    /**
     * ServiceModel List → DTO List
     */
    public static List<AssetDTO> fromServiceModelList(List<ServiceModel> models) {
        if (models == null) return new ArrayList<>();
        
        List<AssetDTO> dtoList = new ArrayList<>();
        for (ServiceModel model : models) {
            dtoList.add(fromServiceModel(model));
        }
        return dtoList;
    }
    
    // ========================================
    // Hardware 변환
    // ========================================
    
    /**
     * DTO → HardwareModel
     */
    public static HardwareModel toHardwareModel(AssetDTO dto) {
        if (dto == null) return null;
        
        HardwareModel model = new HardwareModel();
        model.setIdx(dto.getHardwareIdx());
        model.setServiceIdx(dto.getServiceIdx());
        model.setAssetNo(dto.getHardwareAssetNo());
        model.setType(dto.getHardwareType());
        model.setManufacturer(dto.getHardwareManufacturer());
        model.setProductName(dto.getHardwareProductName());
        model.setVersion(dto.getHardwareVersion());
        model.setQuantity(dto.getHardwareQuantity());
        model.setCreatedDate(dto.getHardwareCreatedDate());
        model.setCreatedBy(dto.getHardwareCreatedBy());
        model.setUpdatedDate(dto.getHardwareUpdatedDate());
        model.setUpdatedBy(dto.getHardwareUpdatedBy());
        
        return model;
    }
    
    /**
     * HardwareModel → DTO
     */
    public static AssetDTO fromHardwareModel(HardwareModel model) {
        if (model == null) return null;
        
        AssetDTO dto = new AssetDTO();
        dto.setHardwareIdx(model.getIdx());
        dto.setServiceIdx(model.getServiceIdx());
        dto.setHardwareAssetNo(model.getAssetNo());
        dto.setHardwareType(model.getType());
        dto.setHardwareManufacturer(model.getManufacturer());
        dto.setHardwareProductName(model.getProductName());
        dto.setHardwareVersion(model.getVersion());
        dto.setHardwareQuantity(model.getQuantity());
        dto.setHardwareCreatedDate(model.getCreatedDate());
        dto.setHardwareCreatedBy(model.getCreatedBy());
        dto.setHardwareUpdatedDate(model.getUpdatedDate());
        dto.setHardwareUpdatedBy(model.getUpdatedBy());
        
        return dto;
    }
    
    // ========================================
    // Software 변환
    // ========================================
    
    /**
     * DTO → SoftwareModel
     */
    public static SoftwareModel toSoftwareModel(AssetDTO dto) {
        if (dto == null) return null;
        
        SoftwareModel model = new SoftwareModel();
        model.setIdx(dto.getSoftwareIdx());
        model.setHardwareIdx(dto.getHardwareIdx());
        model.setAssetNo(dto.getSoftwareAssetNo());
        model.setType(dto.getSoftwareType());
        model.setManufacturer(dto.getSoftwareManufacturer());
        model.setProductName(dto.getSoftwareProductName());
        model.setVersion(dto.getSoftwareVersion());
        model.setQuantity(dto.getSoftwareQuantity());
        model.setCreatedDate(dto.getSoftwareCreatedDate());
        model.setCreatedBy(dto.getSoftwareCreatedBy());
        model.setUpdatedDate(dto.getSoftwareUpdatedDate());
        model.setUpdatedBy(dto.getSoftwareUpdatedBy());
        
        return model;
    }
    
    /**
     * SoftwareModel → DTO
     */
    public static AssetDTO fromSoftwareModel(SoftwareModel model) {
        if (model == null) return null;
        
        AssetDTO dto = new AssetDTO();
        dto.setSoftwareIdx(model.getIdx());
        dto.setHardwareIdx(model.getHardwareIdx());
        dto.setSoftwareAssetNo(model.getAssetNo());
        dto.setSoftwareType(model.getType());
        dto.setSoftwareManufacturer(model.getManufacturer());
        dto.setSoftwareProductName(model.getProductName());
        dto.setSoftwareVersion(model.getVersion());
        dto.setSoftwareQuantity(model.getQuantity());
        dto.setSoftwareCreatedDate(model.getCreatedDate());
        dto.setSoftwareCreatedBy(model.getCreatedBy());
        dto.setSoftwareUpdatedDate(model.getUpdatedDate());
        dto.setSoftwareUpdatedBy(model.getUpdatedBy());
        
        return dto;
    }
    
    // ========================================
    // Component 변환
    // ========================================
    
    /**
     * DTO → ComponentModel
     */
    public static ComponentModel toComponentModel(AssetDTO dto) {
        if (dto == null) return null;
        
        ComponentModel model = new ComponentModel();
        model.setIdx(dto.getComponentIdx());
        model.setHardwareIdx(dto.getHardwareIdx());
        model.setType(dto.getComponentType());
        model.setName(dto.getComponentName());
        model.setQuantity(dto.getComponentQuantity());
        model.setDescription(dto.getComponentDescription());
        model.setCreatedDate(dto.getComponentCreatedDate());
        model.setCreatedBy(dto.getComponentCreatedBy());
        model.setUpdatedDate(dto.getComponentUpdatedDate());
        model.setUpdatedBy(dto.getComponentUpdatedBy());
        
        return model;
    }
    
    /**
     * ComponentModel → DTO
     */
    public static AssetDTO fromComponentModel(ComponentModel model) {
        if (model == null) return null;
        
        AssetDTO dto = new AssetDTO();
        dto.setComponentIdx(model.getIdx());
        dto.setHardwareIdx(model.getHardwareIdx());
        dto.setComponentType(model.getType());
        dto.setComponentName(model.getName());
        dto.setComponentQuantity(model.getQuantity());
        dto.setComponentDescription(model.getDescription());
        dto.setComponentCreatedDate(model.getCreatedDate());
        dto.setComponentCreatedBy(model.getCreatedBy());
        dto.setComponentUpdatedDate(model.getUpdatedDate());
        dto.setComponentUpdatedBy(model.getUpdatedBy());
        
        return dto;
    }
    
    // ========================================
    // History 변환
    // ========================================
    
    /**
     * DTO → HistoryModel
     */
    public static HistoryModel toHistoryModel(AssetDTO dto) {
        if (dto == null) return null;
        
        HistoryModel model = new HistoryModel();
        model.setIdx(dto.getHistoryIdx());
        model.setAssetType(dto.getHistoryAssetType());
        model.setParentIdx(dto.getHistoryParentIdx());
        model.setContent(dto.getHistoryContent());
        model.setRemark(dto.getHistoryRemark());
        model.setCreatedDate(dto.getHistoryCreatedDate());
        model.setCreatedBy(dto.getHistoryCreatedBy());
        model.setUpdatedDate(dto.getHistoryUpdatedDate());
        model.setUpdatedBy(dto.getHistoryUpdatedBy());
        
        return model;
    }
    
    /**
     * HistoryModel → DTO
     */
    public static AssetDTO fromHistoryModel(HistoryModel model) {
        if (model == null) return null;
        
        AssetDTO dto = new AssetDTO();
        dto.setHistoryIdx(model.getIdx());
        dto.setHistoryAssetType(model.getAssetType());
        dto.setHistoryParentIdx(model.getParentIdx());
        dto.setHistoryContent(model.getContent());
        dto.setHistoryRemark(model.getRemark());
        dto.setHistoryCreatedDate(model.getCreatedDate());
        dto.setHistoryCreatedBy(model.getCreatedBy());
        dto.setHistoryUpdatedDate(model.getUpdatedDate());
        dto.setHistoryUpdatedBy(model.getUpdatedBy());
        
        return dto;
    }
    
    // ========================================
    // Manager 변환
    // ========================================
    
    /**
     * DTO → ManagerModel
     */
    public static ManagerModel toManagerModel(AssetDTO dto) {
        if (dto == null) return null;
        
        ManagerModel model = new ManagerModel();
        model.setIdx(dto.getManagerIdx());
        model.setAssetType(dto.getManagerAssetType());
        model.setParentIdx(dto.getManagerParentIdx());
        model.setName(dto.getManagerName());
        model.setPhoneNumber(dto.getManagerPhoneNumber());
        model.setMobileNumber(dto.getManagerMobileNumber());
        model.setEmail(dto.getManagerEmail());
        model.setCreatedDate(dto.getManagerCreatedDate());
        model.setCreatedBy(dto.getManagerCreatedBy());
        model.setUpdatedDate(dto.getManagerUpdatedDate());
        model.setUpdatedBy(dto.getManagerUpdatedBy());
        
        return model;
    }
    
    /**
     * ManagerModel → DTO
     */
    public static AssetDTO fromManagerModel(ManagerModel model) {
        if (model == null) return null;
        
        AssetDTO dto = new AssetDTO();
        dto.setManagerIdx(model.getIdx());
        dto.setManagerAssetType(model.getAssetType());
        dto.setManagerParentIdx(model.getParentIdx());
        dto.setManagerName(model.getName());
        dto.setManagerPhoneNumber(model.getPhoneNumber());
        dto.setManagerMobileNumber(model.getMobileNumber());
        dto.setManagerEmail(model.getEmail());
        dto.setManagerCreatedDate(model.getCreatedDate());
        dto.setManagerCreatedBy(model.getCreatedBy());
        dto.setManagerUpdatedDate(model.getUpdatedDate());
        dto.setManagerUpdatedBy(model.getUpdatedBy());
        
        return dto;
    }
}
