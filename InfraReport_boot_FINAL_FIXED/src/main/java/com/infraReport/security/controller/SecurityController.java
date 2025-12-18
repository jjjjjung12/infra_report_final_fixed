package com.infraReport.security.controller;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
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

import com.infraReport.cmmn.CommonUtils;
import com.infraReport.security.dto.SecurityDTO;
import com.infraReport.security.service.SecurityService;

@Controller
@RequestMapping(value = "/security")
public class SecurityController {
	
	@Autowired
	SecurityService securityService;
	
	@GetMapping("main")
    public String main(@RequestParam HashMap<String, Object> requestMap, Model model) {
		
		//보안관제 활동 현황
        List<SecurityDTO> securityActivities = securityService.getSecurityActivityList(requestMap);
		
        //현재 일자
        LocalDate today = LocalDate.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        String reportDate = today.format(formatter);
        
        model.addAttribute("securityActivities", securityActivities);
        model.addAttribute("reportDate", reportDate);
        
        return "report/security.tiles";
    }
	
	@PostMapping("/searchSecurityActivityList")
    @ResponseBody
    public List<SecurityDTO> searchSecurityActivityList(@RequestParam HashMap<String, Object> requestMap) {
    	
    	//보안관제 활동 현황
    	List<SecurityDTO> securityActivities = securityService.getSecurityActivityList(requestMap);
    	
    	return securityActivities;
    }
	
	@PostMapping("/addSecurityActivity")
    @ResponseBody
    public Map<String, Object> addSecurityActivity(@RequestParam HashMap<String, Object> requestMap) {
    	boolean isSuccess = false;
    	String msg = "";
    	
        SecurityDTO sec = new SecurityDTO();
        sec.setReportDate((String) requestMap.get("reportDate"));
        sec.setTaskType((String) requestMap.get("taskType"));
        sec.setDetectionCount(CommonUtils.parseIntSafe((String) requestMap.get("detectionCount")));
        sec.setBlockedCount(CommonUtils.parseIntSafe((String) requestMap.get("blockedCount")));
        sec.setDetailInfo((String) requestMap.get("detailInfo"));
        sec.setActionStatus((String) requestMap.get("actionStatus"));
        sec.setManager("보안관제팀");
        sec.setCreatedBy("admin");
    	
    	//보안관제 활동 현황 등록
    	isSuccess = securityService.addSecurityActivity(sec);
    	
    	if(isSuccess) {
    		msg = "등록되었습니다.";
    	} else {
    		msg = "등록에 실패했습니다.";
    	}
    	
    	Map<String, Object> result = new HashMap<>();
        result.put("isSuccess", isSuccess);
        result.put("message", msg);
        
    	return result;
    }
	
	@PostMapping("/getSecurityActivity")
    @ResponseBody
    public SecurityDTO getSecurityActivity(@RequestParam("reportId") int reportId) {
    	//보안관제 활동 현황 상세 조회
    	return securityService.getSecurityActivityById(reportId);
    }
	
	@PostMapping("/updateSecurityActivity")
    @ResponseBody
    public Map<String, Object> updateSecurityActivity(@RequestParam HashMap<String, Object> requestMap) {
    	boolean isSuccess = false;
    	String msg = "";
    	
        SecurityDTO sec = new SecurityDTO();
        sec.setReportId(Integer.parseInt(requestMap.get("reportId").toString()));
        sec.setReportDate((String) requestMap.get("reportDate"));
        sec.setTaskType((String) requestMap.get("taskType"));
        sec.setDetectionCount(CommonUtils.parseIntSafe((String) requestMap.get("detectionCount")));
        sec.setBlockedCount(CommonUtils.parseIntSafe((String) requestMap.get("blockedCount")));
        sec.setDetailInfo((String) requestMap.get("detailInfo"));
        sec.setActionStatus((String) requestMap.get("actionStatus"));
        sec.setManager("보안관제팀");
        sec.setUpdatedBy("admin");
        
    	//보안관제 활동 현황 수정
    	isSuccess = securityService.updateSecurityActivity(sec);
    	
    	if(isSuccess) {
    		msg = "수정되었습니다.";
    	} else {
    		msg = "수정에 실패했습니다.";
    	}
    	
    	Map<String, Object> result = new HashMap<>();
        result.put("isSuccess", isSuccess);
        result.put("message", msg);
        
    	return result;
    }
	
	@PostMapping("/deleteSecurityActivity")
    @ResponseBody
    public Map<String, Object> deleteSecurityActivity(@RequestParam HashMap<String, Object> requestMap) {
    	boolean isSuccess = false;
    	String msg = "";
    	
    	//보안관제 활동 현황 삭제
    	isSuccess = securityService.deleteSecurityActivity(Integer.parseInt(requestMap.get("reportId").toString()));
    	
    	if(isSuccess) {
    		msg = "삭제되었습니다.";
    	} else {
    		msg = "삭제에 실패했습니다.";
    	}
    	
    	Map<String, Object> result = new HashMap<>();
    	result.put("isSuccess", isSuccess);
    	result.put("message", msg);
    	
    	return result;
    }
}
