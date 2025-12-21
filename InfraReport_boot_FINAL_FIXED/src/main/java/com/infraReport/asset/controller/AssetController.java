package com.infraReport.asset.controller;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.infraReport.asset.dto.AssetDTO;
import com.infraReport.asset.service.AssetService;
import com.infraReport.auth.domain.CustomUserDetails;
import com.infraReport.cmmn.CommonUtils;

@Controller
@RequestMapping("/asset")
public class AssetController {
    
    @Autowired
    AssetService assetService;
    
    /*
     * 자산관리 목록
     */
    @GetMapping("/list")
    public String assetList(Model model) {
    	
    	List<AssetDTO> assetServiceList = assetService.getAssetServiceAllList();
    	List<AssetDTO> assetHardwareList = assetService.getAssetHardwareAllList();
    	List<AssetDTO> assetSoftwareList = assetService.getAssetSoftwareAllList();
    	
    	model.addAttribute("serviceList", assetServiceList);
    	model.addAttribute("hardwareList", assetHardwareList);
    	model.addAttribute("softwareList", assetSoftwareList);
    	
        return "asset/assetList.tiles";
    }
    
    /*
     * 자산관리 상세
     */
    @GetMapping("/detail")
    public String assetDetail(@RequestParam HashMap<String, Object> requestMap, Model model) {
    	
    	String serviceIdx = requestMap.get("serviceIdx").toString();
    	String hardwareIdx = requestMap.get("hardwareIdx").toString();
    	String softwareIdx = requestMap.get("softwareIdx").toString();
    	
    	//서비스 조회
    	
    	//서비스 자원이력정보 조회
    	
    	//서비스 담당자정보 조회
    	
    	//하드웨어 조회
    	
    	//하드웨어 구성정보 조회
    	
    	//하드웨어 자원이력정보 조회
    	
    	//하드웨어 담당자정보 조회
    	
    	//소프트웨어 조회
    	
    	//소프트웨어 자원이력정보 조회
    	
    	//소프트웨어 담당자정보 조회
    	
    	return "asset/assetDetail.tiles";
    }
    
    /*
     * 자산관리 서비스 등록 수정
     */
    @GetMapping("/serviceRegist")
    public String serviceRegist() {
    	return "asset/assetServiceRegist.tiles";
    }
    
    /*
     * 자산관리 하드웨어 등록 수정
     */
    @GetMapping("/hardwareRegist")
    public String hardwareRegist(Model model) {
    	List<AssetDTO> assetServiceList = assetService.getAssetServiceAllList();
    	model.addAttribute("assetServiceList", assetServiceList);
    	return "asset/assetHardwareRegist.tiles";
    }
    
    /*
     * 자산관리 소프트웨어 등록 수정
     */
    @GetMapping("/softwareRegist")
    public String softwareRegist(Model model) {
    	List<AssetDTO> assetHardwareList = assetService.getAssetHardwareAllList();
    	model.addAttribute("assetHardwareList", assetHardwareList);
    	return "asset/assetSoftwareRegist.tiles";
    }
    
    /*
     * 서비스 등록
     * */
    @PostMapping("/addService")
    @ResponseBody
    public Map<String, Object> addService(@RequestBody Map<String, Object> requestMap, Authentication authentication) {
    	
    	String serviceName = (String) requestMap.get("serviceName");
        List<Map<String, Object>> histories = (List<Map<String, Object>>) requestMap.get("histories");
        List<Map<String, Object>> managers = (List<Map<String, Object>>) requestMap.get("managers");
        
        CustomUserDetails userDetails = (CustomUserDetails) authentication.getPrincipal();
        
        List<AssetDTO> assetServiceList = assetService.getAssetServiceAllList();
        
    	boolean isSuccess = false;
    	String msg = "";
    	
    	//자산관리번호
    	String date = LocalDate.now().format(DateTimeFormatter.ofPattern("yyyyMMdd"));
        
    	int nextNumber = 1; // 기본값: 001

    	if (!assetServiceList.isEmpty()) {

    	    String lastAssetNo = assetServiceList.get(0).getServiceAssetNo();

    	    String lastDate = lastAssetNo.substring(1, 9);
    	    String lastSeqStr = lastAssetNo.substring(9);
    	    int lastSeq = Integer.parseInt(lastSeqStr);

    	    // 날짜가 같으면 +1, 다르면 001
    	    if (date.equals(lastDate)) {
    	    	nextNumber = lastSeq + 1;
    	    }
    	}
    	
    	String number = String.format("%03d", nextNumber);
    	
    	AssetDTO service = new AssetDTO();
    	service.setServiceAssetNo("A"+date+number);
    	service.setServiceName(serviceName);
    	service.setServiceCreatedBy(userDetails.getUsername());
        
    	//서비스 등록
    	int serviceIdx = assetService.addAssetService(service);
    	
    	//자원이력 정보 등록
    	if(histories.size() > 0) {
    		for(int i=0; i<histories.size(); i++) {
    			service.setHistoryAssetType("service");
        		service.setHistoryParentIdx(serviceIdx);
        		service.setHistoryContent(histories.get(i).get("content").toString());
        		service.setHistoryRemark(histories.get(i).get("remark").toString());
        		service.setHistoryCreatedBy(userDetails.getUsername());
        		
        		assetService.addAssetHistory(service);
    		}
    	}
    	
    	//담당자 정보 등록
    	if(managers.size() > 0) {
    		for(int i=0; i<managers.size(); i++) {
    			service.setManagerAssetType("service");
    			service.setManagerParentIdx(serviceIdx);
    			service.setManagerName(managers.get(i).get("name").toString());
    			service.setManagerPhoneNumber(managers.get(i).get("phone").toString());
    			service.setManagerMobileNumber(managers.get(i).get("mobile").toString());
    			service.setManagerEmail(managers.get(i).get("email").toString());
    			service.setManagerCreatedBy(userDetails.getUsername());
    			
    			assetService.addAssetManager(service);
    		}
    	}
    	
    	if(serviceIdx > 0) {
    		msg = "등록되었습니다.";
    		isSuccess = true;
    	} else {
    		msg = "등록에 실패했습니다.";
    		isSuccess = false;
    	}
    	
    	Map<String, Object> result = new HashMap<>();
        result.put("isSuccess", isSuccess);
        result.put("message", msg);
        
    	return result;
    }
    
    /*
     * 하드웨어 등록
     * */
    @PostMapping("/addHardware")
    @ResponseBody
    public Map<String, Object> addHardware(@RequestBody Map<String, Object> requestMap, Authentication authentication) {
    	
    	String serviceIdx = requestMap.get("serviceIdx").toString();
    	if(CommonUtils.isEmpty(serviceIdx)) {
    		serviceIdx = "0";
    	}
    	String hardwareType = (String) requestMap.get("hardwareType");
    	String manufacturer = (String) requestMap.get("manufacturer");
    	String productName = (String) requestMap.get("productName");
    	String version = (String) requestMap.get("version");
    	String quantity = (String) requestMap.get("quantity");
    	List<Map<String, Object>> components = (List<Map<String, Object>>) requestMap.get("components");
    	List<Map<String, Object>> histories = (List<Map<String, Object>>) requestMap.get("histories");
    	List<Map<String, Object>> managers = (List<Map<String, Object>>) requestMap.get("managers");
    	
    	CustomUserDetails userDetails = (CustomUserDetails) authentication.getPrincipal();
    	
    	List<AssetDTO> assetHardwareList = assetService.getAssetHardwareAllList();
    	
    	boolean isSuccess = false;
    	String msg = "";
    	
    	//자산관리번호
    	String date = LocalDate.now().format(DateTimeFormatter.ofPattern("yyyyMMdd"));
    	
    	int nextNumber = 1; // 기본값: 001
    	
    	if (!assetHardwareList.isEmpty()) {

    	    String lastAssetNo = assetHardwareList.get(0).getHardwareAssetNo();

    	    String lastDate = lastAssetNo.substring(1, 9);
    	    String lastSeqStr = lastAssetNo.substring(9);
    	    int lastSeq = Integer.parseInt(lastSeqStr);

    	    // 날짜가 같으면 +1, 다르면 001
    	    if (date.equals(lastDate)) {
    	    	nextNumber = lastSeq + 1;
    	    }
    	}
    	
    	String number = String.format("%03d", nextNumber);
    	
    	AssetDTO service = new AssetDTO();
    	service.setServiceIdx(Integer.parseInt(serviceIdx));
    	service.setHardwareAssetNo("H"+date+number);
    	service.setHardwareType(hardwareType);
    	service.setHardwareManufacturer(manufacturer);
    	service.setHardwareProductName(productName);
    	service.setHardwareVersion(version);
    	service.setHardwareQuantity(quantity);
    	service.setHardwareCreatedBy(userDetails.getUsername());
    	
    	//서비스 등록
    	int hardwareIdx = assetService.addAssetHardware(service);
    	
    	//구성정보 등록
    	if(components.size() > 0) {
    		for(int i=0; i<components.size(); i++) {
    			service.setHardwareIdx(hardwareIdx);
    			service.setComponentType(components.get(i).get("type").toString());
    			service.setComponentName(components.get(i).get("name").toString());
    			service.setComponentQuantity(components.get(i).get("quantity").toString());
    			service.setComponentDescription(components.get(i).get("description").toString());
    			service.setComponentCreatedBy(userDetails.getUsername());

    			assetService.addAssetHardwareComponent(service);
    		}
    	}
    	
    	//자원이력 정보 등록
    	if(histories.size() > 0) {
    		for(int i=0; i<histories.size(); i++) {
    			service.setHistoryAssetType("hardware");
    			service.setHistoryParentIdx(hardwareIdx);
    			service.setHistoryContent(histories.get(i).get("content").toString());
    			service.setHistoryRemark(histories.get(i).get("remark").toString());
    			service.setHistoryCreatedBy(userDetails.getUsername());
    			
    			assetService.addAssetHistory(service);
    		}
    	}
    	
    	//담당자 정보 등록
    	if(managers.size() > 0) {
    		for(int i=0; i<managers.size(); i++) {
    			service.setManagerAssetType("hardware");
    			service.setManagerParentIdx(hardwareIdx);
    			service.setManagerName(managers.get(i).get("name").toString());
    			service.setManagerPhoneNumber(managers.get(i).get("phone").toString());
    			service.setManagerMobileNumber(managers.get(i).get("mobile").toString());
    			service.setManagerEmail(managers.get(i).get("email").toString());
    			service.setManagerCreatedBy(userDetails.getUsername());
    			
    			assetService.addAssetManager(service);
    		}
    	}
    	
    	if(hardwareIdx > 0) {
    		msg = "등록되었습니다.";
    		isSuccess = true;
    	} else {
    		msg = "등록에 실패했습니다.";
    		isSuccess = false;
    	}
    	
    	Map<String, Object> result = new HashMap<>();
    	result.put("isSuccess", isSuccess);
    	result.put("message", msg);
    	
    	return result;
    }
    
    /*
     * 소프트웨어 등록
     * */
    @PostMapping("/addSoftware")
    @ResponseBody
    public Map<String, Object> addSoftware(@RequestBody Map<String, Object> requestMap, Authentication authentication) {
    	
    	String hardwareIdx = requestMap.get("hardwareIdx").toString();
    	if(CommonUtils.isEmpty(hardwareIdx)) {
    		hardwareIdx = "0";
    	}
    	String softwareType = (String) requestMap.get("softwareType");
    	String manufacturer = (String) requestMap.get("manufacturer");
    	String productName = (String) requestMap.get("productName");
    	String version = (String) requestMap.get("version");
    	String quantity = (String) requestMap.get("quantity");
    	List<Map<String, Object>> histories = (List<Map<String, Object>>) requestMap.get("histories");
    	List<Map<String, Object>> managers = (List<Map<String, Object>>) requestMap.get("managers");
    	
    	CustomUserDetails userDetails = (CustomUserDetails) authentication.getPrincipal();
    	
    	List<AssetDTO> assetSoftwareList = assetService.getAssetSoftwareAllList();
    	
    	boolean isSuccess = false;
    	String msg = "";
    	
    	//자산관리번호
    	String date = LocalDate.now().format(DateTimeFormatter.ofPattern("yyyyMMdd"));
    	
    	int nextNumber = 1; // 기본값: 001

    	if (!assetSoftwareList.isEmpty()) {

    	    String lastAssetNo = assetSoftwareList.get(0).getSoftwareAssetNo();

    	    String lastDate = lastAssetNo.substring(1, 9);
    	    String lastSeqStr = lastAssetNo.substring(9);
    	    int lastSeq = Integer.parseInt(lastSeqStr);

    	    // 날짜가 같으면 +1, 다르면 001
    	    if (date.equals(lastDate)) {
    	    	nextNumber = lastSeq + 1;
    	    }
    	}
    	
    	String number = String.format("%03d", nextNumber);
    	
    	AssetDTO service = new AssetDTO();
    	service.setHardwareIdx(Integer.parseInt(hardwareIdx));
    	service.setSoftwareAssetNo("S"+date+number);
    	service.setSoftwareType(softwareType);
    	service.setSoftwareManufacturer(manufacturer);
    	service.setSoftwareProductName(productName);
    	service.setSoftwareVersion(version);
    	service.setSoftwareQuantity(quantity);
    	service.setSoftwareCreatedBy(userDetails.getUsername());
    	
    	//서비스 등록
    	int softwareIdx = assetService.addAssetSoftware(service);
    	
    	//자원이력 정보 등록
    	if(histories.size() > 0) {
    		for(int i=0; i<histories.size(); i++) {
    			service.setHistoryAssetType("software");
    			service.setHistoryParentIdx(softwareIdx);
    			service.setHistoryContent(histories.get(i).get("content").toString());
    			service.setHistoryRemark(histories.get(i).get("remark").toString());
    			service.setHistoryCreatedBy(userDetails.getUsername());
    			
    			assetService.addAssetHistory(service);
    		}
    	}
    	
    	//담당자 정보 등록
    	if(managers.size() > 0) {
    		for(int i=0; i<managers.size(); i++) {
    			service.setManagerAssetType("software");
    			service.setManagerParentIdx(softwareIdx);
    			service.setManagerName(managers.get(i).get("name").toString());
    			service.setManagerPhoneNumber(managers.get(i).get("phone").toString());
    			service.setManagerMobileNumber(managers.get(i).get("mobile").toString());
    			service.setManagerEmail(managers.get(i).get("email").toString());
    			service.setManagerCreatedBy(userDetails.getUsername());
    			
    			assetService.addAssetManager(service);
    		}
    	}
    	
    	if(softwareIdx > 0) {
    		msg = "등록되었습니다.";
    		isSuccess = true;
    	} else {
    		msg = "등록에 실패했습니다.";
    		isSuccess = false;
    	}
    	
    	Map<String, Object> result = new HashMap<>();
    	result.put("isSuccess", isSuccess);
    	result.put("message", msg);
    	
    	return result;
    }
}
