package com.infraReport.asset.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.infraReport.asset.dto.AssetDTO;

public interface AssetService {
	
	/*
	 * 자산관리 조회
	 * */
	List<Map<String, Object>> getAssetList(HashMap<String, Object> param);
	
	/*
	 * 서비스 조회
	 * */
	List<AssetDTO> getAssetServiceAllList();
	
	/*
	 * 하드웨어 조회
	 * */
	List<AssetDTO> getAssetHardwareAllList();
	
	/*
	 * 소프트웨어 조회
	 * */
	List<AssetDTO> getAssetSoftwareAllList();
	
	/*
	 * 서비스 등록
	 * */
	int addAssetService(AssetDTO dto);
	
	/*
	 * 하드웨어 등록
	 * */
	int addAssetHardware(AssetDTO dto);
	
	/*
	 * 소프트웨어 등록
	 * */
	int addAssetSoftware(AssetDTO dto);
	
	/*
	 * 서비스 수정
	 * */
	boolean updateAssetService(AssetDTO dto);
	
	/*
	 * 하드웨어 수정
	 * */
	boolean updateAssetHardware(AssetDTO dto);
	
	/*
	 * 소프트웨어 수정
	 * */
	boolean updateAssetSoftware(AssetDTO dto);
	
	/*
	 * 구성정보 등록
	 * */
	boolean addAssetHardwareComponent(AssetDTO dto);
	
	/*
	 * 자원이력 정보 등록
	 * */
	boolean addAssetHistory(AssetDTO dto);
	
	/*
	 * 담당자 정보 등록
	 * */
	boolean addAssetManager(AssetDTO dto);
	
	/*
	 * 구성정보 삭제
	 * */
	boolean deleteAssetHardwareComponent(AssetDTO dto);
	
	/*
	 * 자원이력 정보 삭제
	 * */
	boolean deleteAssetHistory(AssetDTO dto);
	
	/*
	 * 담당자 정보 삭제
	 * */
	boolean deleteAssetManager(AssetDTO dto);
	
	/*
	 * 서비스 조회
	 * */
	AssetDTO getAssetServiceByIdx(int serviceIdx);
	
	/*
	 * 하드웨어 조회
	 * */
	AssetDTO getAssetHardwareByIdx(int hardwareIdx);
	
	/*
	 * 소프트웨어 조회
	 * */
	AssetDTO getAssetSoftwareByIdx(int softwareIdx);
	
	/*
	 * 자원이력정보 조회
	 * */
	List<AssetDTO> getAssetHistoryByType(HashMap<String, Object> param);
	
	/*
	 * 담당자정보 조회
	 * */
	List<AssetDTO> getAssetManagerByType(HashMap<String, Object> param);
	
	/*
	 * 하드웨어 구성정보 조회
	 * */
	List<AssetDTO> getAssetHardwareComponentByHardware(HashMap<String, Object> param);
}
