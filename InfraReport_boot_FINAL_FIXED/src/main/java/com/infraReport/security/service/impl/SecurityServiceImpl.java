package com.infraReport.security.service.impl;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.infraReport.security.dao.SecurityDAO;
import com.infraReport.security.dto.SecurityDTO;
import com.infraReport.security.service.SecurityService;

@Service("securityService")
public class SecurityServiceImpl implements SecurityService {

	@Resource(name="securityDao")
	private SecurityDAO securityDao;
	
	/*
     * 보안관제 활동 현황 조회
     * */
    @Override
    public List<SecurityDTO> getSecurityActivityList(HashMap<String, Object> param) {
        return securityDao.selectSecurityActivityList(param);
    }
    
    /*
     * 보안관제 활동 현황 등록
     * */
    @Override
    public boolean addSecurityActivity(SecurityDTO dto) {
        int rows = securityDao.insertSecurityActivity(dto);
        return rows > 0;
    }
    
    /*
     * 보안관제 활동 현황 상세 조회 
     * */
    @Override
    public SecurityDTO getSecurityActivityById(int reportId) {
    	return securityDao.selectSecurityActivityById(reportId);
    }

    /*
     * 보안관제 활동 현황 수정
     * */
    @Override
    public boolean updateSecurityActivity(SecurityDTO dto) {
        int rows = securityDao.updateSecurityActivity(dto);
        return rows > 0;
    }
    
    /*
     * 보안관제 활동 현황 삭제
     * */
    @Override
    public boolean deleteSecurityActivity(int reportId) {
    	int rows = securityDao.deleteSecurityActivity(reportId);
    	return rows > 0;
    }
}
