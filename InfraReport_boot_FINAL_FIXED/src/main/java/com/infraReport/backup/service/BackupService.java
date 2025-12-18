package com.infraReport.backup.service;

import java.util.HashMap;
import java.util.List;

import com.infraReport.backup.dto.BackupDTO;

public interface BackupService {
	
	/*
	 * 백업 관리대장 조회
	 * */
	List<BackupDTO> getBackupResultList(HashMap<String, Object> param);
	
	/*
	 * 백업 결과 등록
	 * */
	boolean addBackupResult(BackupDTO dto);
	
	/*
	 * 백업 결과 상세 조회
	 * */
	BackupDTO getBackupResultById(int reportId);

	/*
	 * 백업 결과 수정
	 * */
	boolean updateBackupResult(BackupDTO dto);
	
	/*
	 * 백업 결과 삭제
	 * */
	boolean deleteBackupResult(int reportId);
	
}
