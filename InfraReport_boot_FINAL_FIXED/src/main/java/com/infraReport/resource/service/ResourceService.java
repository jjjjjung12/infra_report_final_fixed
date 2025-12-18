package com.infraReport.resource.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.infraReport.resource.dto.ResourceDTO;

public interface ResourceService {
	
	/*
	 * 서버별 자원 사용 현황 조회
	 * */
	List<ResourceDTO> getResourceUsageList(HashMap<String, Object> param);
	
	/*
	 * 서버별 자원 사용 등록
	 * */
	boolean addResourceUsage(ResourceDTO dto);
	
	/*
	 * 서버별 자원 사용 요약 데이터 생성
	 * */
	List<Map<String, Object>> resourceSummary(List<ResourceDTO> resourceUsage);
}
