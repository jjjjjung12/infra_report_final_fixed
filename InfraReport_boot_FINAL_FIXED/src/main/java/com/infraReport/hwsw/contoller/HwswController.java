package com.infraReport.hwsw.contoller;

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

import com.infraReport.hwsw.dto.HwswDTO;
import com.infraReport.hwsw.service.HwswService;

@Controller
@RequestMapping(value = "/hwsw")
public class HwswController {
	
	@Autowired
	HwswService hwswService;
	
	@GetMapping("/main")
    public String main(@RequestParam HashMap<String, Object> requestMap, Model model) {
		
		//HW/SW 점검 결과 조회
        List<HwswDTO> hwswChecks = hwswService.getHwswCheckList(requestMap);
        
        //현재 일자
        LocalDate today = LocalDate.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        String reportDate = today.format(formatter);
        
        model.addAttribute("hwswChecks", hwswChecks);
        model.addAttribute("reportDate", reportDate);
        
        return "report/hwsw.tiles";
    }
	
	@PostMapping("/searchHwswCheckList")
    @ResponseBody
    public List<HwswDTO> searchHwswCheckList(@RequestParam HashMap<String, Object> requestMap) {
    	
    	//HW/SW 점검 결과 조회
    	List<HwswDTO> hwswChecks = hwswService.getHwswCheckList(requestMap);
    	
    	return hwswChecks;
    }
	
	@PostMapping("/addHwswCheck")
    @ResponseBody
    public Map<String, Object> addHwswCheck(@RequestParam HashMap<String, Object> requestMap) {
    	boolean isSuccess = false;
    	String msg = "";
    	
    	HwswDTO check = new HwswDTO();
    	
    	check.setReportDate((String) requestMap.get("reportDate"));
        check.setServerName((String) requestMap.get("serverName"));
        check.setCheckItem((String) requestMap.get("checkItem"));
        check.setCheckContent((String) requestMap.get("checkContent"));
        check.setCheckResult((String) requestMap.get("checkResult"));
        check.setErrorContent((String) requestMap.get("errorContent"));
        check.setActionTaken((String) requestMap.get("actionTaken"));
        check.setManager((String) requestMap.get("manager"));
        check.setCreatedBy("admin");
    	
    	//HW/SW 점검 결과 등록
    	isSuccess = hwswService.addHwswCheck(check);
    	
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
	
	@PostMapping("/getHwswCheck")
    @ResponseBody
    public HwswDTO getHwswCheck(@RequestParam("reportId") int reportId) {
    	//HW/SW 점검 결과 상세 조회
    	return hwswService.getHwswCheckById(reportId);
    }
	
	@PostMapping("/updateHwswCheck")
    @ResponseBody
    public Map<String, Object> updateHwswCheck(@RequestParam HashMap<String, Object> requestMap) {
    	boolean isSuccess = false;
    	String msg = "";
    	
    	HwswDTO check = new HwswDTO();
    	
    	check.setReportId(Integer.parseInt(requestMap.get("reportId").toString()));
    	check.setReportDate((String) requestMap.get("reportDate"));
        check.setServerName((String) requestMap.get("serverName"));
        check.setCheckItem((String) requestMap.get("checkItem"));
        check.setCheckContent((String) requestMap.get("checkContent"));
        check.setCheckResult((String) requestMap.get("checkResult"));
        check.setErrorContent((String) requestMap.get("errorContent"));
        check.setActionTaken((String) requestMap.get("actionTaken"));
        check.setManager((String) requestMap.get("manager"));
        check.setUpdatedBy("admin");
        
    	//HW/SW 점검 결과 수정
    	isSuccess = hwswService.updateHwswCheck(check);
    	
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
	
	@PostMapping("/deleteHwswCheck")
    @ResponseBody
    public Map<String, Object> deleteHwswCheck(@RequestParam HashMap<String, Object> requestMap) {
    	boolean isSuccess = false;
    	String msg = "";
    	
    	//HW/SW 점검 결과 삭제
    	isSuccess = hwswService.deleteHwswCheck(Integer.parseInt(requestMap.get("reportId").toString()));
    	
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
