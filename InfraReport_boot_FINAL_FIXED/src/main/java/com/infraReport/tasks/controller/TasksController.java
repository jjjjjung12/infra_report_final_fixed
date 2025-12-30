package com.infraReport.tasks.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.sql.Timestamp;
import java.time.LocalDate;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.infraReport.auth.domain.CustomUserDetails;
import com.infraReport.tasks.dto.TasksDTO;
import com.infraReport.tasks.dto.TasksFileDTO;
import com.infraReport.tasks.service.TasksService;

@Controller
@RequestMapping("/tasks")
public class TasksController {

    @Autowired
    private TasksService tasksService;
    
    @Value("${file.upload.path}")
	private String filePath;
    
    @GetMapping("/process/admin")
    public String adminTasks(Model model) {
    	List<TasksDTO> tasks = tasksService.getTasksInfoAllList();
    	List<TasksFileDTO> tasksFile = tasksService.getTasksFileUploadAllList();
    	
    	model.addAttribute("tasks", tasks);
    	model.addAttribute("tasksFile", tasksFile);
    	
        return "tasks/adminTasks.tiles"; 
    }
    
    @GetMapping("/process/user")
    public String userTasks(Model model, Authentication authentication) {
    	List<TasksDTO> tasks = tasksService.getTasksInfoAllList();
    	List<TasksFileDTO> tasksFile = tasksService.getTasksFileUploadAllList();
    	
    	model.addAttribute("tasks", tasks);
    	model.addAttribute("tasksFile", tasksFile);
    	
        return "tasks/userTasks.tiles";
    }
    
    /*
     * 의뢰서 등록
     * */
    @PostMapping("/addRequest")
    @ResponseBody
    public Map<String, Object> addRequest(MultipartHttpServletRequest request, Authentication authentication, Model model) {
    	
    	List<MultipartFile> fileArr = request.getFiles("fileArr");
    	String tasksName = request.getParameter("tasksName");
    	
    	CustomUserDetails userDetails = (CustomUserDetails) authentication.getPrincipal();
    	
    	boolean isSuccess = false;
    	String msg = "";
    	
    	//의뢰서 등록
    	TasksDTO tasks = new TasksDTO();
    	tasks.setTasksName(tasksName);
    	tasks.setRequestStatus("REQUEST");		//todo: DB ENUM 생성 및 상태값 관리
    	tasks.setCreatedBy(userDetails.getUsername());
    	
    	int requestIdx = tasksService.addTasksRequest(tasks);
    	
    	//의뢰 파일 등록
    	if(fileArr.size() > 0) {
    		for(MultipartFile file : fileArr) {
    			String fileName = file.getOriginalFilename();
    			String originFileName = fileName.substring(0, fileName.lastIndexOf("."));
    			String fileType = fileName.substring(fileName.lastIndexOf(".")+1);
    			
    			long millis = System.currentTimeMillis();

				String uploadFileName = originFileName + "_" + millis + "." + fileType;
				
				try {
					// 업로드 폴더 경로 생성
					File path = new File(filePath);
					if (!path.isDirectory()) {
						path.mkdirs();
					}

					// 파일 업로드
					if (!file.isEmpty()) {
						File destinationFile = new File(filePath + File.separatorChar +uploadFileName);
						file.transferTo(destinationFile);

						TasksFileDTO tasksFile = new TasksFileDTO();
						tasksFile.setTasksIdx(requestIdx);
						tasksFile.setTasksStage("REQUEST");
						tasksFile.setFilePath(filePath);
						tasksFile.setFileName(uploadFileName);
						tasksFile.setOrgFileName(fileName);
						tasksFile.setCreatedBy(userDetails.getUsername());
						
						isSuccess = tasksService.addTasksFileUpload(tasksFile);
					}

				} catch(Exception e) {
					msg = "파일 업로드 중 오류가 발생했습니다. 다시 확인해주세요.";
				}
    		}
    	}
    	
    	Map<String, Object> result = new HashMap<>();
    	
    	if(requestIdx > 0 || isSuccess) {
    		msg = "생성되었습니다.";
    		isSuccess = true;
    	} else {
    		msg = "생성에 실패했습니다.";
    		isSuccess = false;
    	}
    	
        result.put("isSuccess", isSuccess);
        result.put("message", msg);
        
        return result;
    }
    
    /*
     * 작업 수정
     * */
    @PostMapping("/updateTasks")
    @ResponseBody
    public Map<String, Object> updateTasks(MultipartHttpServletRequest request, Authentication authentication, Model model) {
    	
    	List<MultipartFile> fileArr = request.getFiles("fileArr");
    	int tasksIdx = Integer.parseInt(request.getParameter("tasksIdx"));
    	String tasksStage = request.getParameter("tasksStage");
    	
    	CustomUserDetails userDetails = (CustomUserDetails) authentication.getPrincipal();
    	
    	boolean isSuccess = false;
    	String msg = "";
    	
    	TasksDTO tasks = new TasksDTO();
    	tasks.setUpdatedBy(userDetails.getUsername());
    	tasks.setIdx(tasksIdx);
    	tasks.setTaskStatus("REQUEST");
    	
    	//작업 수정
    	if("REQUEST".equals(tasksStage)) {
    		tasks.setTasksStage(tasksStage);
    	} else if("PLAN".equals(tasksStage)) {
        	
    		String startDateStr = request.getParameter("planStartDate");
    		String endDateStr   = request.getParameter("planEndDate");

    		if (startDateStr != null && !startDateStr.isEmpty()) {
    		    LocalDate startDate = LocalDate.parse(startDateStr);
    		    tasks.setPlanStartDate(Timestamp.valueOf(startDate.atStartOfDay()));
    		}

    		if (endDateStr != null && !endDateStr.isEmpty()) {
    		    LocalDate endDate = LocalDate.parse(endDateStr);
    		    tasks.setPlanEndDate(Timestamp.valueOf(endDate.atStartOfDay()));
    		}
    		
    		tasks.setUpdatedBy(userDetails.getUsername());
    		tasks.setTasksStage(tasksStage);
    		
    	} else if("RESULT".equals(tasksStage)) {
    		tasks.setTasksStage(tasksStage);
    	}
    	
    	isSuccess = tasksService.updateTasks(tasks);
    	
    	//파일 등록
    	if(fileArr.size() > 0) {
    		for(MultipartFile file : fileArr) {
    			String fileName = file.getOriginalFilename();
    			String originFileName = fileName.substring(0, fileName.lastIndexOf("."));
    			String fileType = fileName.substring(fileName.lastIndexOf(".")+1);
    			
    			long millis = System.currentTimeMillis();

				String uploadFileName = originFileName + "_" + millis + "." + fileType;
				
				try {
					// 업로드 폴더 경로 생성
					File path = new File(filePath);
					if (!path.isDirectory()) {
						path.mkdirs();
					}

					// 파일 업로드
					if (!file.isEmpty()) {
						File destinationFile = new File(filePath + File.separatorChar +uploadFileName);
						file.transferTo(destinationFile);

						TasksFileDTO tasksFile = new TasksFileDTO();
						tasksFile.setTasksIdx(tasksIdx);
						tasksFile.setTasksStage(tasksStage);
						tasksFile.setFilePath(filePath);
						tasksFile.setFileName(uploadFileName);
						tasksFile.setOrgFileName(fileName);
						tasksFile.setCreatedBy(userDetails.getUsername());
						
						isSuccess = tasksService.addTasksFileUpload(tasksFile);
					}

				} catch(Exception e) {
					msg = "파일 업로드 중 오류가 발생했습니다. 다시 확인해주세요.";
				}
    		}
    	}
    	
    	Map<String, Object> result = new HashMap<>();
    	
    	if(isSuccess) {
    		msg = "수정되었습니다.";
    		isSuccess = true;
    	} else {
    		msg = "수정에 실패했습니다.";
    		isSuccess = false;
    	}
    	
        result.put("isSuccess", isSuccess);
        result.put("message", msg);
        
        return result;
    }
    
    /*
     * 파일 삭제
     * */
    @PostMapping("/deleteFile")
    @ResponseBody
    public Map<String, Object> deleteFile(@RequestParam("idx") int idx, Model model) {
    	
    	boolean isSuccess = false;
    	String msg = "";
    	
    	isSuccess = tasksService.deleteFile(idx);
    	
    	Map<String, Object> result = new HashMap<>();
    	
    	if(isSuccess) {
    		msg = "삭제되었습니다.";
    		isSuccess = true;
    	} else {
    		msg = "삭제에 실패했습니다.";
    		isSuccess = false;
    	}
    	
    	result.put("isSuccess", isSuccess);
    	result.put("message", msg);
    	
    	return result;
    }
    
    /*
     * 단계별 승인
     * */
    @PostMapping("/updateApproved")
    @ResponseBody
    public Map<String, Object> updateApproved(@RequestParam("idx") int idx, @RequestParam("tasksStage") String tasksStage, Authentication authentication, Model model) {
    	
    	boolean isSuccess = false;
    	String msg = "";
    	
    	CustomUserDetails userDetails = (CustomUserDetails) authentication.getPrincipal();
    	
    	HashMap<String, Object> param = new HashMap<String, Object>();
    	param.put("idx", idx);
    	param.put("tasksStage", tasksStage);
    	param.put("taskStatus", "COMPLETED");
    	param.put("updatedBy", userDetails.getUsername());
    	
    	isSuccess = tasksService.updateApproved(param);
    	
    	Map<String, Object> result = new HashMap<>();
    	
    	if(isSuccess) {
    		msg = "승인되었습니다.";
    		isSuccess = true;
    	} else {
    		msg = "승인에 실패했습니다.";
    		isSuccess = false;
    	}
    	
    	result.put("isSuccess", isSuccess);
    	result.put("message", msg);
    	
    	return result;
    }
    
    /*
     * 파일 다운로드
     * */
    @GetMapping("/downloadFile")
    public void downloadFile(@RequestParam("idx") int idx, HttpServletResponse response) throws Exception {

        TasksFileDTO tasksFile = tasksService.getTasksFileByIdx(idx);

        File downFile = new File(tasksFile.getFilePath() + File.separator + tasksFile.getFileName());

        response.setContentType("application/octet-stream");
        response.setHeader(
            "Content-Disposition",
            "attachment; filename=\"" +
            URLEncoder.encode(tasksFile.getOrgFileName(), "UTF-8") + "\""
        );
        response.setContentLengthLong(downFile.length());

        try (InputStream is = new FileInputStream(downFile);
             OutputStream os = response.getOutputStream()) {

            FileCopyUtils.copy(is, os);
        }
    }
}