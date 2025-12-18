package com.infraReport.report.controller;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.infraReport.report.service.ReportService;

@Controller
@RequestMapping("/report")   // ★ 클래스 레벨에서 /report 묶어줌
public class ReportController {
    
    @Autowired
    ReportService reportService;
    
    /*
     * 일일보고 페이지 (/report/daily)
     */
    @GetMapping("/daily")
    public String dailyReport() {
        return "report/dailyReport.tiles";
    }
    
    /*
     * 메인 페이지 (/report/main)
     */
    @GetMapping("/main")
    public String mainReport(Model model) {
        model.addAttribute("currentDate", new Date());
        return "report/mainReport.tiles";
    }
    
    /*
     * 엑셀 내보내기 (/report/exportExcel)
     */
    @PostMapping("/exportExcel")
    @ResponseBody
    public void exportExcel(@RequestParam HashMap<String, Object> requestMap,
                            HttpServletResponse response) throws Exception {
        reportService.exportExcel(requestMap, response);
    }

    /*
     * 엑셀 업로드 (/report/uploadExcel)
     */
    @PostMapping("/uploadExcel")
    @ResponseBody
    public Map<String, Object> uploadExcel(@RequestParam("uploadType") String uploadType,
                                           @RequestParam("excelFile") MultipartFile file) {
        return reportService.uploadExcel(uploadType, file);
    }
}
