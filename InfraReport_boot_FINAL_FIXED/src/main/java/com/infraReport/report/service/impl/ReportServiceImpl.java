package com.infraReport.report.service.impl;

import java.io.InputStream;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.usermodel.WorkbookFactory;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.infraReport.backup.dto.BackupDTO;
import com.infraReport.backup.service.BackupService;
import com.infraReport.cmmn.CommonUtils;
import com.infraReport.hwsw.dto.HwswDTO;
import com.infraReport.hwsw.service.HwswService;
import com.infraReport.report.dao.ReportDAO;
import com.infraReport.report.dto.CommonCodeDTO;
import com.infraReport.report.dto.DailyReportStatDTO;
import com.infraReport.report.service.ReportService;
import com.infraReport.resource.dto.ResourceDTO;
import com.infraReport.resource.service.ResourceService;
import com.infraReport.security.dto.SecurityDTO;
import com.infraReport.security.service.SecurityService;
import com.infraReport.workType.dto.WorkTypeDTO;
import com.infraReport.workType.service.WorkTypeService;

@Service("reportService")
public class ReportServiceImpl implements ReportService {

    @Resource(name="reportDao")
	private ReportDAO reportDao;
    
    @Autowired
    private WorkTypeService workTypeService;
	
	@Autowired
	private ResourceService resourceService;
	
	@Autowired
	private HwswService hwswService;

	@Autowired
	private SecurityService securityService;
	
	@Autowired
	private BackupService backupService;
    
    /*
     * 업무 유형 별 통계 조회
     * */
    @Override
    public DailyReportStatDTO getDailyReportStats() {
        return reportDao.selectDailyReportStats();
    }
    
    /*
     * 공통 코드 조회
     * */
    @Override
    public List<CommonCodeDTO> getCodeListByType(String cdType) {
    	return reportDao.selectCodeListByType(cdType);
    }
    
    /*
     * 엑셀 내보내기
     * */
    @Override
    public void exportExcel(HashMap<String, Object> requestMap, HttpServletResponse response) throws Exception {
    	String reportAction = requestMap.get("reportAction").toString();
        
        XSSFWorkbook workbook = new XSSFWorkbook();
        XSSFSheet sheet = workbook.createSheet("Report");

        String[] headers = null;
        List<List<String>> rows = new ArrayList<>();
        
        DateTimeFormatter fmt = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");
        
        switch (reportAction) {

	        case "daily":
	            headers = new String[]{"카테고리", "서비스명", "업무유형", "업무내용", "상태", "담당자", "등록일시", "등록자", "수정일시", "수정자"};
	            List<WorkTypeDTO> reports = workTypeService.getReportList(requestMap);
	            
	            for (WorkTypeDTO report : reports) {
	                rows.add(Arrays.asList(
	                		  report.getServiceCategory()
	                		, report.getServiceName()
	                		, report.getTaskType()
	                		, report.getTaskDescription()
	                		, report.getStatus()
	                		, report.getManager()
	                		, CommonUtils.getFormattedTimestamp(report.getCreatedDate(), fmt)
	                		, report.getCreatedBy()
	                		, CommonUtils.getFormattedTimestamp(report.getUpdatedDate(), fmt)
	                		, report.getUpdatedBy()
	                ));
	            }
	            break;
	
	        case "resource":
	        	headers = new String[]{"서버명", "자원유형", "사용률(%)", "모니터링 시간", "상태", "등록일시", "등록자"};
	        	List<ResourceDTO> resourceUsage = resourceService.getResourceUsageList(requestMap);
	            
	            for (ResourceDTO ru : resourceUsage) {
	                rows.add(Arrays.asList(
	                		  ru.getServerName()
	                		, ru.getResourceType()
	                		, String.valueOf(ru.getUsagePercent())
	                		, ru.getMonitoringTime()
	                		, ru.getResourceStatus()
	                		, CommonUtils.getFormattedTimestamp(ru.getCreatedDate(), fmt)
	                		, ru.getCreatedBy()
	                ));
	            }
	            break;
	
	        case "hwsw":
	        	headers = new String[]{"서버명", "점검항목", "점검내용", "결과", "에러내용", "조치사항", "담당자", "등록일시", "등록자", "수정일시", "수정자"};
	        	List<HwswDTO> hwswChecks = hwswService.getHwswCheckList(requestMap);
	            
	            for (HwswDTO check : hwswChecks) {
	                rows.add(Arrays.asList(
	                		  check.getServerName()
	                		, check.getCheckItem()
	                		, check.getCheckContent()
	                		, check.getCheckResult()
	                		, check.getErrorContent()
	                		, check.getActionTaken()
	                		, check.getManager()
	                		, CommonUtils.getFormattedTimestamp(check.getCreatedDate(), fmt)
	                		, check.getCreatedBy()
	                		, CommonUtils.getFormattedTimestamp(check.getUpdatedDate(), fmt)
	                		, check.getUpdatedBy()
	                ));
	            }
	            break;
	            
	        case "security":
	        	headers = new String[]{"활동유형", "탐지건수", "차단건수", "상세정보", "처리상태", "등록일시", "등록자", "수정일시", "수정자"};
	        	List<SecurityDTO> securityActivities = securityService.getSecurityActivityList(requestMap);
	            
	            for (SecurityDTO sec : securityActivities) {
	                rows.add(Arrays.asList(
	                		  sec.getTaskType()
	                		, String.valueOf(sec.getDetectionCount())
	                		, String.valueOf(sec.getBlockedCount())
	                		, sec.getDetailInfo()
	                		, sec.getActionStatus()
	                		, CommonUtils.getFormattedTimestamp(sec.getCreatedDate(), fmt)
	                		, sec.getCreatedBy()
	                		, CommonUtils.getFormattedTimestamp(sec.getUpdatedDate(), fmt)
	                		, sec.getUpdatedBy()
	                ));
	            }
	        	break;
	        	
	        case "backup":
	        	headers = new String[]{"서비스명", "백업유형", "백업장비", "백업구분", "레벨", "상태", "비고", "등록일시", "등록자", "수정일시", "수정자"};
	        	List<BackupDTO> backupResults = backupService.getBackupResultList(requestMap);
	            
	            for (BackupDTO backup : backupResults) {
	                rows.add(Arrays.asList(
	                		backup.getServiceName()
	                		, backup.getBackupType()
	                		, backup.getBackupLibrary()
	                		, backup.getBackupCategory()
	                		, String.valueOf(backup.getBackupLevel())
	                		, backup.getBackupStatus()
	                		, backup.getRemarks()
	                		, CommonUtils.getFormattedTimestamp(backup.getCreatedDate(), fmt)
	                		, backup.getCreatedBy()
	                		, CommonUtils.getFormattedTimestamp(backup.getUpdatedDate(), fmt)
	                		, backup.getUpdatedBy()
	                ));
	            }
	        	break;
	
	        default:
	            headers = new String[]{"알 수 없는 유형"};
	            rows.add(Arrays.asList("지원하지 않는 유형입니다."));
	            break;
	    }
        
        //헤더 생성
        Row headerRow = sheet.createRow(0);
        for (int i = 0; i < headers.length; i++) {
            Cell cell = headerRow.createCell(i);
            cell.setCellValue(headers[i]);
        }

        //데이터 행 채우기
        int rowNum = 1;
        for (List<String> rowData : rows) {
            Row row = sheet.createRow(rowNum++);
            for (int i = 0; i < rowData.size(); i++) {
                row.createCell(i).setCellValue(rowData.get(i));
            }
        }
        
        // 현재 날짜 + 시간
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyyMMdd_HHmmss");
        String timestamp = LocalDateTime.now().format(formatter);

        //파일명 / 응답 헤더
        String fileName = reportAction + "_Report_" + timestamp + ".xlsx";
        response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
        response.setHeader("Content-Disposition", "attachment; filename=\"" + fileName + "\"");

        //엑셀 출력
        workbook.write(response.getOutputStream());
        workbook.close();
    }

    /*
     * 엑셀 업로드
     * */
    @Override
    public Map<String, Object> uploadExcel(String uploadType, MultipartFile file) {
    	Map<String, Object> result = new HashMap<>();

        if (file.isEmpty()) {
            result.put("success", false);
            result.put("message", "업로드할 파일이 없습니다.");
            return result;
        }

        try (InputStream is = file.getInputStream();
             Workbook workbook = WorkbookFactory.create(is)) {

        	//현재 일자
            LocalDate today = LocalDate.now();
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
            String reportDate = today.format(formatter);
            
            Sheet sheet = workbook.getSheetAt(0);
            int lastRow = sheet.getLastRowNum();

            for (int i = 1; i <= lastRow; i++) {
                Row row = sheet.getRow(i);
                if (row == null) continue;

                switch (uploadType) {
                    case "resource":
                        ResourceDTO resource = new ResourceDTO();
                        resource.setReportDate(reportDate);
//                        resource.setServerName(CommonUtils.getCellString(row, 0));
//                        resource.setResourceType(CommonUtils.getCellString(row, 1));
//                        resource.setUsagePercent(CommonUtils.getCellDouble(row, 2));
//                        resource.setTotalAmount(CommonUtils.getCellDouble(row, 3));
//                        resource.setUsedAmount(CommonUtils.getCellDouble(row, 4));
//                        resource.setAvailableAmount(CommonUtils.getCellDouble(row, 5));
//                        resource.setMonitoringTime(CommonUtils.getCellString(row, 6));
//                        resource.setStatus(CommonUtils.getCellString(row, 7));
//                        resource.setCreatedBy("admin");
                        
                        resource.setServerName(CommonUtils.getCellString(row, 0));
                        resource.setResourceType(CommonUtils.getCellString(row, 1));
                        resource.setUsagePercent(CommonUtils.getCellDouble(row, 2));
                        resource.setMonitoringTime(CommonUtils.getCellString(row, 3));
                        resource.setStatus(CommonUtils.getCellString(row, 4));
                        resource.setCreatedBy("admin");
                        resourceService.addResourceUsage(resource);
                        break;

                    case "security":
                        SecurityDTO sec = new SecurityDTO();
                        sec.setReportDate(reportDate);
                        sec.setTaskType(CommonUtils.getCellString(row, 0));
                        sec.setDetectionCount(CommonUtils.parseIntSafe(CommonUtils.getCellString(row, 1)));
                        sec.setBlockedCount(CommonUtils.parseIntSafe(CommonUtils.getCellString(row, 2)));
                        sec.setDetailInfo(CommonUtils.getCellString(row, 3));
                        sec.setActionStatus(CommonUtils.getCellString(row, 4));
                        sec.setManager("보안관제팀");
                        sec.setCreatedBy("admin");
                        securityService.addSecurityActivity(sec);
                        break;

                    case "backup":
                        BackupDTO backup = new BackupDTO();
                        backup.setReportDate(reportDate);
                        backup.setServiceName(CommonUtils.getCellString(row, 0));
                        backup.setBackupType(CommonUtils.getCellString(row, 1));
                        backup.setBackupLibrary(CommonUtils.getCellString(row, 2));
                        backup.setBackupCategory(CommonUtils.getCellString(row, 3));
                        backup.setBackupLevel(CommonUtils.parseIntSafe(CommonUtils.getCellString(row, 4)));
                        backup.setBackupStatus(CommonUtils.getCellString(row, 5));
                        backup.setRemarks(CommonUtils.getCellString(row, 6));
                        backupService.addBackupResult(backup);
                        break;

                    default:
                        throw new IllegalArgumentException("지원하지 않는 업로드 유형입니다.");
                }
            }

            result.put("success", true);
            result.put("message", "엑셀 업로드 성공");

        } catch (Exception e) {
            e.printStackTrace();
            result.put("success", false);
            result.put("message", "엑셀 처리 중 오류: " + e.getMessage());
        }

        return result;
    }
}
