package com.infraReport.security.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.stereotype.Repository;

import com.infraReport.security.dto.SecurityDTO;

@Repository("securityDao")
public interface SecurityDAO {
	
	/*
	 * 보안관제 활동 현황 조회
	 * */
	List<SecurityDTO> selectSecurityActivityList(HashMap<String, Object> param);
	
	/*
	 * 보안관제 활동 현황 등록
	 * */
	int insertSecurityActivity(SecurityDTO dto);
	
	/*
	 * 보안관제 활동 현황 상세 조회 
	 * */
	SecurityDTO selectSecurityActivityById(int reportId);

	/*
	 * 보안관제 활동 현황 수정
	 * */
	int updateSecurityActivity(SecurityDTO dto);
	
	/*
	 * 보안관제 활동 현황 삭제
	 * */
	int deleteSecurityActivity(int reportId);
}
