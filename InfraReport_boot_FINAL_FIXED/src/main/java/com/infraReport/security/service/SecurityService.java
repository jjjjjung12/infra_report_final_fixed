package com.infraReport.security.service;

import java.util.HashMap;
import java.util.List;

import com.infraReport.security.dto.SecurityDTO;

public interface SecurityService {
	
	/*
	 * 보안관제 활동 현황 조회
	 * */
	List<SecurityDTO> getSecurityActivityList(HashMap<String, Object> param);
	
	/*
	 * 보안관제 활동 현황 등록
	 * */
	boolean addSecurityActivity(SecurityDTO dto);
	
	/*
	 * 보안관제 활동 현황 상세 조회
	 * */
	SecurityDTO getSecurityActivityById(int reportId);

	/*
	 * 보안관제 활동 현황 수정
	 * */
	boolean updateSecurityActivity(SecurityDTO dto);
	
	/*
	 * 보안관제 활동 현황 삭제
	 * */
	boolean deleteSecurityActivity(int reportId);
	
}
