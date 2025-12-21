package com.infraReport.asset.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.infraReport.asset.dto.AssetDTO;

@Repository("assetDao")
public interface AssetDAO {

	/*
	 * 서비스 조회
	 * */
	List<AssetDTO> selectAssetServiceAllList();
	
	/*
	 * 하드웨어 조회
	 * */
	List<AssetDTO> selectAssetHardwareAllList();
	
	/*
	 * 소프트웨어 조회
	 * */
	List<AssetDTO> selectAssetSoftwareAllList();
	
	/*
	 * 서비스 등록
	 * */
	int insertAssetService(AssetDTO dto);
	
	/*
	 * 하드웨어 등록
	 * */
	int insertAssetHardware(AssetDTO dto);
	
	/*
	 * 소프트웨어 등록
	 * */
	int insertAssetSoftware(AssetDTO dto);
	
	/*
	 * 구성정보 등록
	 * */
	int insertAssetHardwareComponent(AssetDTO dto);
	
	/*
	 * 자원이력 정보 등록
	 * */
	int insertAssetHistory(AssetDTO dto);
	
	/*
	 * 담당자 정보 등록
	 * */
	int insertAssetManager(AssetDTO dto);
}
