package com.infraReport.asset.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.infraReport.asset.dto.AssetDTO;

@Repository("assetDao")
public interface AssetDAO {
	
	/*
	 * 자산관리 조회
	 * */
	List<Map<String, Object>> selectAssetList(HashMap<String, Object> param);

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
	 * 서비스 수정
	 * */
	int updateAssetService(AssetDTO dto);
	
	/*
	 * 하드웨어 수정
	 * */
	int updateAssetHardware(AssetDTO dto);
	
	/*
	 * 소프트웨어 수정
	 * */
	int updateAssetSoftware(AssetDTO dto);
	
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
	
	/*
	 * 구성정보 삭제
	 * */
	int deleteAssetHardwareComponent(AssetDTO dto);
	
	/*
	 * 자원이력 정보 삭제
	 * */
	int deleteAssetHistory(AssetDTO dto);
	
	/*
	 * 담당자 정보 삭제
	 * */
	int deleteAssetManager(AssetDTO dto);
	
	/*
	 * 서비스 조회
	 * */
	AssetDTO selectAssetServiceByIdx(int serviceIdx);
	
	/*
	 * 하드웨어 조회
	 * */
	AssetDTO selectAssetHardwareByIdx(int hardwareIdx);
	
	/*
	 * 소프트웨어 조회
	 * */
	AssetDTO selectAssetSoftwareByIdx(int softwareIdx);
	
	/*
	 * 자원이력정보 조회
	 * */
	List<AssetDTO> selectAssetHistoryByType(HashMap<String, Object> param);
	
	/*
	 * 담당자정보 조회
	 * */
	List<AssetDTO> selectAssetManagerByType(HashMap<String, Object> param);
	
	/*
	 * 하드웨어 구성정보 조회
	 * */
	List<AssetDTO> selectAssetHardwareComponentByHardware(HashMap<String, Object> param);
}
