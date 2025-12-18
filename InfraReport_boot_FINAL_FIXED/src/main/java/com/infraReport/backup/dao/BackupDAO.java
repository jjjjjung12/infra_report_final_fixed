package com.infraReport.backup.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.stereotype.Repository;

import com.infraReport.backup.dto.BackupDTO;

@Repository("backupDao")
public interface BackupDAO {
	
	/*
	 * 백업 관리대장 조회
	 * */
	List<BackupDTO> selectBackupResultList(HashMap<String, Object> param);
	
	/*
	 * 백업 결과 등록
	 * */
	int insertBackupResult(BackupDTO dto);
	
	/*
	 * 백업 결과 상세 조회 
	 * */
	BackupDTO selectBackupResultById(int reportId);

	/*
	 * 백업 결과 수정
	 * */
	int updateBackupResult(BackupDTO dto);
	
	/*
	 * 백업 결과 삭제
	 * */
	int deleteBackupResult(int reportId);
    
}
