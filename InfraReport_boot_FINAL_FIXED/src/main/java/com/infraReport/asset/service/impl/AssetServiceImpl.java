package com.infraReport.asset.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
	 * 자산관리 조회
	 * */
    @Override
    public List<Map<String, Object>> getAssetList(HashMap<String, Object> param) {
    	return assetDao.selectAssetList(param);
    }
    
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
	 * 서비스 수정
	 * */
    @Override
    public boolean updateAssetService(AssetDTO dto) {
    	int rows = assetDao.updateAssetService(dto);
    	return rows > 0;
    }
	
	/*
	 * 하드웨어 수정
	 * */
    @Override
    public boolean updateAssetHardware(AssetDTO dto) {
    	int rows = assetDao.updateAssetHardware(dto);
    	return rows > 0;
    }
	
	/*
	 * 소프트웨어 수정
	 * */
    @Override
    public boolean updateAssetSoftware(AssetDTO dto) {
    	int rows = assetDao.updateAssetSoftware(dto);
    	return rows > 0;
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
    
    /*
	 * 구성정보 삭제
	 * */
    @Override
    public boolean deleteAssetHardwareComponent(AssetDTO dto) {
    	int rows = assetDao.deleteAssetHardwareComponent(dto);
    	return rows > 0;
    }
	
	/*
	 * 자원이력 정보 삭제
	 * */
    @Override
    public boolean deleteAssetHistory(AssetDTO dto) {
    	int rows = assetDao.deleteAssetHistory(dto);
    	return rows > 0;
    }
	
	/*
	 * 담당자 정보 삭제
	 * */
    @Override
    public boolean deleteAssetManager(AssetDTO dto) {
    	int rows = assetDao.deleteAssetManager(dto);
    	return rows > 0;
    }
	
    /*
	 * 서비스 조회
	 * */
    @Override
    public AssetDTO getAssetServiceByIdx(int serviceIdx) {
    	return assetDao.selectAssetServiceByIdx(serviceIdx);
    }
	
	/*
	 * 하드웨어 조회
	 * */
    @Override
    public AssetDTO getAssetHardwareByIdx(int hardwareIdx) {
    	return assetDao.selectAssetHardwareByIdx(hardwareIdx);
    }
	
	/*
	 * 소프트웨어 조회
	 * */
    @Override
    public AssetDTO getAssetSoftwareByIdx(int softwareIdx) {
    	return assetDao.selectAssetSoftwareByIdx(softwareIdx);
    }
	
	/*
	 * 자원이력정보 조회
	 * */
    @Override
    public List<AssetDTO> getAssetHistoryByType(HashMap<String, Object> param) {
    	return assetDao.selectAssetHistoryByType(param);
    }
	
	/*
	 * 담당자정보 조회
	 * */
    @Override
    public List<AssetDTO> getAssetManagerByType(HashMap<String, Object> param) {
    	return assetDao.selectAssetManagerByType(param);
    }
	
	/*
	 * 하드웨어 구성정보 조회
	 * */
    @Override
    public List<AssetDTO> getAssetHardwareComponentByHardware(HashMap<String, Object> param) {
    	return assetDao.selectAssetHardwareComponentByHardware(param);
    }
}
