package com.infraReport.asset.service;

import java.util.List;

import com.infraReport.asset.dto.AssetDTO;

public interface AssetService {
	
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
	
}
