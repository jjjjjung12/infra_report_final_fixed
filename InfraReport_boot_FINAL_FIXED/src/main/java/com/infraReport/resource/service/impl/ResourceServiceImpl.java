package com.infraReport.resource.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.infraReport.resource.dao.ResourceDAO;
import com.infraReport.resource.dto.ResourceDTO;
import com.infraReport.resource.service.ResourceService;

@Service("resourceService")
public class ResourceServiceImpl implements ResourceService {
	
	@Resource(name="resourceDao")
	private ResourceDAO resourceDao;
	
	/*
     * 서버별 자원 사용 현황 조회
     * */
    @Override
    public List<ResourceDTO> getResourceUsageList(HashMap<String, Object> param) {
        return resourceDao.selectResourceUsageList(param);
    }
	
    /*
     * 서버별 자원 사용 등록
     * */
    @Override
    public boolean addResourceUsage(ResourceDTO dto) {
        int rows = resourceDao.insertResourceUsage(dto);
        return rows > 0;
    }
    
    /*
	 * 서버별 자원 사용 요약 데이터 생성
	 * */
    @Override
    public List<Map<String, Object>> resourceSummary(List<ResourceDTO> resourceUsage) {
		
		List<Map<String, Object>> resourceSummary = new ArrayList<>();
		Map<String, Map<String, Object>> resMap = new LinkedHashMap<>();
		
        for (ResourceDTO ru : resourceUsage) {
            String server = ru.getServerName();
            if (server == null) continue;
            
            Map<String, Object> entry = resMap.get(server);
            if (entry == null) {
                entry = new HashMap<>();
                entry.put("serverName", server);
                entry.put("cpuUsage", 0.0);
                entry.put("memoryUsage", 0.0);
                entry.put("diskUsage", 0.0);
                entry.put("status", "정상");
                resMap.put(server, entry);
            }
            
            String type = ru.getResourceType();
            if ("CPU".equalsIgnoreCase(type)) {
                entry.put("cpuUsage", ru.getUsagePercent());
            } else if ("MEMORY".equalsIgnoreCase(type)) {
                entry.put("memoryUsage", ru.getUsagePercent());
            } else if ("DISK".equalsIgnoreCase(type)) {
                entry.put("diskUsage", ru.getUsagePercent());
            }
            String overallStatus = (String) entry.get("status");
            String newStatus = ru.getStatus();
            if ("위험".equals(newStatus)) {
                entry.put("status", "위험");
            } else if ("주의".equals(newStatus) && !"위험".equals(overallStatus)) {
                entry.put("status", "주의");
            }
        }
        resourceSummary.addAll(resMap.values());
        
        return resourceSummary;
	}

}
