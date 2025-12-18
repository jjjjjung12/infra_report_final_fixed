package com.infraReport.backup.service.impl;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.infraReport.backup.dao.BackupDAO;
import com.infraReport.backup.dto.BackupDTO;
import com.infraReport.backup.service.BackupService;

@Service("backupService")
public class BackupServiceImpl implements BackupService {

    @Resource(name="backupDao")
	private BackupDAO backupDao;
    
    /*
     * 백업 관리대장 조회
     * */
    @Override
    public List<BackupDTO> getBackupResultList(HashMap<String, Object> param) {
        return backupDao.selectBackupResultList(param);
    }
    
    /*
     * 백업 결과 등록
     * */
    @Override
    public boolean addBackupResult(BackupDTO dto) {
        int rows = backupDao.insertBackupResult(dto);
        return rows > 0;
    }
    
    /*
     * 백업 결과 상세 조회 
     * */
    @Override
    public BackupDTO getBackupResultById(int reportId) {
    	return backupDao.selectBackupResultById(reportId);
    }

    /*
     * 백업 결과 수정
     * */
    @Override
    public boolean updateBackupResult(BackupDTO dto) {
        int rows = backupDao.updateBackupResult(dto);
        return rows > 0;
    }
    
    /*
     * 백업 결과 삭제
     * */
    @Override
    public boolean deleteBackupResult(int reportId) {
    	int rows = backupDao.deleteBackupResult(reportId);
    	return rows > 0;
    }

}
