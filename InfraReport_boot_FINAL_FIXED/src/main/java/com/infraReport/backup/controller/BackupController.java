package com.infraReport.backup.controller;

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

import com.infraReport.backup.dto.BackupDTO;
import com.infraReport.backup.service.BackupService;
import com.infraReport.cmmn.CommonUtils;
import com.infraReport.report.dto.CommonCodeDTO;
import com.infraReport.report.service.ReportService;

@Controller
@RequestMapping(value = "/backup")
public class BackupController {
	
	@Autowired
	BackupService backupService;
	
	@Autowired
	ReportService reportService;
	
	@GetMapping("/main")
    public String main(@RequestParam HashMap<String, Object> requestMap, Model model) {
		
		//백업 관리대장 조회
        List<BackupDTO> backupResults = backupService.getBackupResultList(requestMap);
		
        //백업 구분
        List<CommonCodeDTO> backupCategories = reportService.getCodeListByType("BACKUP_CATEGORY");
		
		//현재 일자
        LocalDate today = LocalDate.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        String reportDate = today.format(formatter);
        
		model.addAttribute("backupResults", backupResults);
		model.addAttribute("backupCategories", backupCategories);
		model.addAttribute("reportDate", reportDate);
		
        return "report/backup.tiles";
    }
	
	@PostMapping("/searchBackupResultList")
    @ResponseBody
    public List<BackupDTO> searchBackupResultList(@RequestParam HashMap<String, Object> requestMap) {
    	
    	//백업 관리대장 조회
    	List<BackupDTO> backupResults = backupService.getBackupResultList(requestMap);
    	
    	return backupResults;
    }
	
	@PostMapping("/addBackupResult")
    @ResponseBody
    public Map<String, Object> addBackupResult(@RequestParam HashMap<String, Object> requestMap) {
    	boolean isSuccess = false;
    	String msg = "";
    	
    	BackupDTO backup = new BackupDTO();
        
        backup.setReportDate((String) requestMap.get("reportDate"));
        backup.setServiceName((String) requestMap.get("serviceName"));
        backup.setBackupType((String) requestMap.get("backupType"));
        backup.setBackupLibrary((String) requestMap.get("backupLibrary"));
        backup.setBackupCategory((String) requestMap.get("backupCategory"));
        backup.setBackupLevel(CommonUtils.parseIntSafe((String) requestMap.get("backupLevel")));
        backup.setBackupStatus((String) requestMap.get("backupStatus"));
        backup.setRemarks((String) requestMap.get("remarks"));
        backup.setCreatedBy("admin");
        
    	//백업 결과 등록
    	isSuccess = backupService.addBackupResult(backup);
    	
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
	
	@PostMapping("/getBackupResult")
    @ResponseBody
    public BackupDTO getBackupResult(@RequestParam("reportId") int reportId) {
    	//백업 결과 상세 조회
    	return backupService.getBackupResultById(reportId);
    }
	
	@PostMapping("/updateBackupResult")
    @ResponseBody
    public Map<String, Object> updateBackupResult(@RequestParam HashMap<String, Object> requestMap) {
    	boolean isSuccess = false;
    	String msg = "";
    	
    	BackupDTO backup = new BackupDTO();
    	
    	backup.setReportId(Integer.parseInt((String) requestMap.get("reportId")));
        backup.setReportDate((String) requestMap.get("reportDate"));
        backup.setServiceName((String) requestMap.get("serviceName"));
        backup.setBackupType((String) requestMap.get("backupType"));
        backup.setBackupLibrary((String) requestMap.get("backupLibrary"));
        backup.setBackupCategory((String) requestMap.get("backupCategory"));
        backup.setBackupLevel(CommonUtils.parseIntSafe((String) requestMap.get("backupLevel")));
        backup.setBackupStatus((String) requestMap.get("backupStatus"));
        backup.setRemarks((String) requestMap.get("remarks"));
        backup.setUpdatedBy("admin");
        
    	//백업 결과 수정
    	isSuccess = backupService.updateBackupResult(backup);
    	
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
	
	@PostMapping("/deleteBackupResult")
    @ResponseBody
    public Map<String, Object> deleteBackupResult(@RequestParam HashMap<String, Object> requestMap) {
    	boolean isSuccess = false;
    	String msg = "";
    	
    	//백업 결과 삭제
    	isSuccess = backupService.deleteBackupResult(Integer.parseInt(requestMap.get("reportId").toString()));
    	
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
