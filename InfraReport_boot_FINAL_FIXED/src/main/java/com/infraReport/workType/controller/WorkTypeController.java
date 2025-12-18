package com.infraReport.workType.controller;

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

import com.infraReport.report.dto.CommonCodeDTO;
import com.infraReport.report.dto.DailyReportStatDTO;
import com.infraReport.report.service.ReportService;
import com.infraReport.workType.dto.WorkTypeDTO;
import com.infraReport.workType.service.WorkTypeService;

@Controller
@RequestMapping(value = "/workType")
public class WorkTypeController {
	
	@Autowired
	WorkTypeService workTypeService;
	
	@Autowired
	ReportService reportService;

    @GetMapping("/main")
    public String main(@RequestParam HashMap<String, Object> requestMap, Model model) {
        
    	//업무 유형 별 통계 조회
    	DailyReportStatDTO stats = reportService.getDailyReportStats();
    	
    	//업무 목록 조회
    	List<WorkTypeDTO> reports = workTypeService.getReportList(requestMap);
    	
    	//공통 코드 조회
    	List<CommonCodeDTO> serviceCategories = reportService.getCodeListByType("SERVICE_CATEGORY");
    	List<CommonCodeDTO> taskTypes = reportService.getCodeListByType("TASK_TYPE");
        List<CommonCodeDTO> statusTypes = reportService.getCodeListByType("STATUS_TYPE");
        
        //현재 일자
        LocalDate today = LocalDate.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        String reportDate = today.format(formatter);
        
    	model.addAttribute("stats", stats);
    	model.addAttribute("reports", reports);
    	model.addAttribute("serviceCategories", serviceCategories);
    	model.addAttribute("taskTypes", taskTypes);
    	model.addAttribute("statusTypes", statusTypes);
    	model.addAttribute("reportDate", reportDate);
    	
        return "report/workType.tiles";
    }
    
    @PostMapping("/searchReportList")
    @ResponseBody
    public List<WorkTypeDTO> searchReportList(@RequestParam HashMap<String, Object> requestMap) {
    	
    	//업무 목록 조회
    	List<WorkTypeDTO> reports = workTypeService.getReportList(requestMap);
    	
    	return reports;
    }
    
    @PostMapping("/addReport")
    @ResponseBody
    public Map<String, Object> addReport(@RequestParam HashMap<String, Object> requestMap) {
    	boolean isSuccess = false;
    	String msg = "";
    	
    	WorkTypeDTO report = new WorkTypeDTO();
    	
    	report.setReportDate((String) requestMap.get("reportDate"));
        report.setServiceCategory((String) requestMap.get("serviceCategory"));
        report.setServiceName((String) requestMap.get("serviceName"));
        report.setTaskDescription((String) requestMap.get("taskDescription"));
        report.setTaskType((String) requestMap.get("taskType"));
        report.setStatus((String) requestMap.get("status"));
        report.setCheckTime((String) requestMap.get("checkTime"));
        report.setManager((String) requestMap.get("manager"));
        report.setDepartment((String) requestMap.get("department"));
        report.setRemarks((String) requestMap.get("remarks"));
        report.setPriority((String) requestMap.get("priority"));
        report.setCreatedBy("admin");
        
    	//새 업무 등록
    	isSuccess = workTypeService.addDailyReport(report);
    	
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
    
    @PostMapping("/getReport")
    @ResponseBody
    public WorkTypeDTO getReport(@RequestParam("reportId") int reportId) {
    	//업무 상세 조회
    	return workTypeService.getDailyReportById(reportId);
    }
    
    @PostMapping("/updateReport")
    @ResponseBody
    public Map<String, Object> updateReport(@RequestParam HashMap<String, Object> requestMap) {
    	boolean isSuccess = false;
    	String msg = "";
    	
    	WorkTypeDTO report = new WorkTypeDTO();
    	
    	report.setReportId(Integer.parseInt(requestMap.get("reportId").toString()));
    	report.setReportDate((String) requestMap.get("reportDate"));
        report.setServiceCategory((String) requestMap.get("serviceCategory"));
        report.setServiceName((String) requestMap.get("serviceName"));
        report.setTaskDescription((String) requestMap.get("taskDescription"));
        report.setTaskType((String) requestMap.get("taskType"));
        report.setStatus((String) requestMap.get("status"));
        report.setCheckTime((String) requestMap.get("checkTime"));
        report.setManager((String) requestMap.get("manager"));
        report.setDepartment((String) requestMap.get("department"));
        report.setRemarks((String) requestMap.get("remarks"));
        report.setPriority((String) requestMap.get("priority"));
        report.setUpdatedBy("admin");
        
    	//업무 수정
    	isSuccess = workTypeService.updateDailyReport(report);
    	
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
    
    @PostMapping("/deleteReport")
    @ResponseBody
    public Map<String, Object> deleteReport(@RequestParam HashMap<String, Object> requestMap) {
    	boolean isSuccess = false;
    	String msg = "";
    	
    	//업무 삭제
    	isSuccess = workTypeService.deleteDailyReport(Integer.parseInt(requestMap.get("reportId").toString()));
    	
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
