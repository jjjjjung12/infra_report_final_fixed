package com.infraReport.resource.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.infraReport.resource.dto.ResourceDTO;
import com.infraReport.resource.service.ResourceService;

@Controller
@RequestMapping(value = "/resource")
public class ResourceController {
	
	@Autowired
	ResourceService resourceService;
	
	@GetMapping("main")
    public String main(@RequestParam HashMap<String, Object> requestMap, Model model) {
		
		//서버별 자원 사용 현황
        List<ResourceDTO> resourceUsage = resourceService.getResourceUsageList(requestMap);

        // 서버별 자원 사용 요약 데이터 생성
        List<Map<String, Object>> resourceSummary = resourceService.resourceSummary(resourceUsage);
        
        model.addAttribute("resourceUsage", resourceUsage);
        model.addAttribute("resourceSummary", resourceSummary);
        
        return "report/resource.tiles";
    }
	
	@PostMapping("/searchResourceList")
    @ResponseBody
    public List<ResourceDTO> searchResourceList(@RequestParam HashMap<String, Object> requestMap) {
    	
    	//서버별 자원 사용 현황
    	List<ResourceDTO> resourceUsage = resourceService.getResourceUsageList(requestMap);
    	
    	return resourceUsage;
    }
    
}
