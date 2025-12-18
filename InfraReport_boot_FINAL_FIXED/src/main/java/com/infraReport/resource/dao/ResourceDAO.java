package com.infraReport.resource.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.stereotype.Repository;

import com.infraReport.resource.dto.ResourceDTO;

@Repository("resourceDao")
public interface ResourceDAO {
    
	/*
	 * 서버별 자원 사용 현황 조회
	 * */
	List<ResourceDTO> selectResourceUsageList(HashMap<String, Object> param);
	
	/*
	 * 서버별 자원 사용 등록
	 * */
	int insertResourceUsage(ResourceDTO dto);
	
}
