package com.infraReport.asset.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.infraReport.asset.dao.AssetDAO;
import com.infraReport.asset.dto.AssetDTO;
import com.infraReport.asset.service.AssetService;

@Service("assetService")
public class AssetServiceImpl implements AssetService {

    @Resource(name="assetDao")
	private AssetDAO assetDao;
    
    /*
     * 서비스 조회
     * */
    @Override
    public List<AssetDTO> getAssetServiceAllList() {
        return assetDao.selectAssetServiceAllList();
    }
    
    /*
     * 하드웨어 조회
     * */
    @Override
    public List<AssetDTO> getAssetHardwareAllList() {
    	return assetDao.selectAssetHardwareAllList();
    }
    
    /*
     * 소프트웨어 조회
     * */
    @Override
    public List<AssetDTO> getAssetSoftwareAllList() {
    	return assetDao.selectAssetSoftwareAllList();
    }
    
    /*
     * 서비스 등록
     * */
    @Override
    public int addAssetService(AssetDTO dto) {
        assetDao.insertAssetService(dto);
        return dto.getServiceIdx();
    }

    /*
     * 하드웨어 등록
     * */
    @Override
    public int addAssetHardware(AssetDTO dto) {
        assetDao.insertAssetHardware(dto);
        return dto.getHardwareIdx();
    }
    
    /*
     * 소프트웨어 등록
     * */
    @Override
    public int addAssetSoftware(AssetDTO dto) {
    	assetDao.insertAssetSoftware(dto);
    	return dto.getSoftwareIdx();
    }
    
    /*
     * 구성정보 등록
     * */
    @Override
    public boolean addAssetHardwareComponent(AssetDTO dto) {
    	int rows = assetDao.insertAssetHardwareComponent(dto);
    	return rows > 0;
    }
    
    /*
     * 자원이력 정보 등록
     * */
    @Override
    public boolean addAssetHistory(AssetDTO dto) {
    	int rows = assetDao.insertAssetHistory(dto);
    	return rows > 0;
    }
    
    /*
     * 담당자 정보 등록
     * */
    @Override
    public boolean addAssetManager(AssetDTO dto) {
    	int rows = assetDao.insertAssetManager(dto);
    	return rows > 0;
    }
}
