package com.infraReport.work.controller;

import com.infraReport.auth.domain.CustomUserDetails;
import com.infraReport.auth.domain.User;
import com.infraReport.work.domain.StageDocument;
import com.infraReport.work.domain.WorkDocumentTemplate;
import com.infraReport.work.domain.WorkProject;
import com.infraReport.work.service.WorkProcessService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.Resource;
import org.springframework.core.io.UrlResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/work")
public class WorkProcessController {

    @Autowired
    private WorkProcessService workProcessService;

    @Value("${file.upload.path:c:/uploads}") 
    private String uploadPath;

    @GetMapping("/dashboard")
    public String mainDashboard(Authentication authentication) {
        CustomUserDetails userDetails = (CustomUserDetails) authentication.getPrincipal();
        User user = userDetails.getUser();
        if ("ADMIN".equals(user.getRole())) return "redirect:/work/process/admin";
        else if (user.getDepartment() != null && !user.getDepartment().isEmpty()) return "redirect:/report/daily"; 
        else return "redirect:/work/process/user"; 
    }

    @GetMapping("/process/admin")
    public String adminProcessPage(Model model) {
        model.addAttribute("projects", workProcessService.getAllProjects());
        model.addAttribute("templates", workProcessService.getAllTemplates());
        model.addAttribute("pendingDocuments", workProcessService.getPendingDocuments());
        model.addAttribute("approvalHistory", workProcessService.getApprovalHistory());
        return "work/admin-process.tiles"; 
    }

    @GetMapping("/process/user")
    public String userProcessPage(Model model, Authentication authentication) {
        CustomUserDetails userDetails = (CustomUserDetails) authentication.getPrincipal();
        model.addAttribute("projects", workProcessService.getProjectsByUserId(userDetails.getUsername()));
        model.addAttribute("templates", workProcessService.getAllTemplates());
        return "work/user-process.tiles";
    }
    
    // [기능] 프로젝트 삭제 (NEW)
    @PostMapping("/project/delete")
    @ResponseBody
    public Map<String, Object> deleteProject(@RequestParam Long projectId) {
        Map<String, Object> result = new HashMap<>();
        try {
            workProcessService.deleteProject(projectId);
            result.put("success", true);
            result.put("message", "프로젝트가 삭제되었습니다.");
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", "삭제 실패: " + e.getMessage());
        }
        return result;
    }

    @PostMapping("/document/add")
    @ResponseBody
    public Map<String, Object> addDocument(@RequestParam Long projectId, @RequestParam Long templateId) {
        Map<String, Object> result = new HashMap<>();
        try {
            workProcessService.addStageDocument(projectId, templateId);
            result.put("success", true);
            result.put("message", "문서가 추가되었습니다.");
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", e.getMessage());
        }
        return result;
    }

    @PostMapping("/document/remove")
    @ResponseBody
    public Map<String, Object> removeDocument(@RequestParam Long documentId) {
        Map<String, Object> result = new HashMap<>();
        try {
            workProcessService.removeStageDocument(documentId);
            result.put("success", true);
            result.put("message", "문서가 삭제되었습니다.");
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", e.getMessage());
        }
        return result;
    }

    @GetMapping("/api/previous-docs")
    @ResponseBody
    public Map<String, Object> getPreviousDocs(@RequestParam Long projectId, @RequestParam String currentStage) {
        Map<String, Object> result = new HashMap<>();
        try {
            result.put("success", true);
            result.put("documents", workProcessService.getPreviousStageDocuments(projectId, currentStage));
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", e.getMessage());
        }
        return result;
    }

    @PostMapping("/template/upload")
    @ResponseBody
    public Map<String, Object> uploadTemplate(@RequestParam("stage") String stage, @RequestParam("documentType") String documentType, @RequestParam("documentName") String documentName, @RequestParam("file") MultipartFile file) {
        Map<String, Object> result = new HashMap<>();
        try {
            workProcessService.uploadTemplate(stage, documentType, documentName, file);
            result.put("success", true);
            result.put("message", "양식 등록 완료");
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", e.getMessage());
        }
        return result;
    }
    
    @GetMapping("/template/download/{templateId}")
    public ResponseEntity<Resource> downloadTemplate(@PathVariable Long templateId) {
        try {
             WorkDocumentTemplate template = workProcessService.getTemplateById(templateId); 
             if (template == null || template.getTemplateFilePath() == null) return ResponseEntity.notFound().build();
             Path path = Paths.get(uploadPath, template.getTemplateFilePath());
             Resource resource = new UrlResource(path.toUri());
             if (!resource.exists()) return ResponseEntity.notFound().build();
             String encodedName = URLEncoder.encode(template.getTemplateFileName(), StandardCharsets.UTF_8).replaceAll("\\+", "%20");
             return ResponseEntity.ok().contentType(MediaType.APPLICATION_OCTET_STREAM).header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename*=UTF-8''" + encodedName).body(resource);
        } catch (Exception e) {
            return ResponseEntity.internalServerError().build();
        }
    }

    @PostMapping("/document/approve")
    @ResponseBody
    public Map<String, Object> approveDocument(@RequestParam Long documentId, @RequestParam(required=false) String comments, Authentication auth) {
        Map<String, Object> result = new HashMap<>();
        try {
            workProcessService.approveDocument(documentId, auth.getName(), comments);
            result.put("success", true);
            result.put("message", "승인되었습니다.");
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", e.getMessage());
        }
        return result;
    }

    @PostMapping("/document/reject")
    @ResponseBody
    public Map<String, Object> rejectDocument(@RequestParam Long documentId, @RequestParam String reason, Authentication auth) {
        Map<String, Object> result = new HashMap<>();
        try {
            workProcessService.rejectDocument(documentId, auth.getName(), reason);
            result.put("success", true);
            result.put("message", "반려되었습니다.");
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", e.getMessage());
        }
        return result;
    }
    
    @PostMapping("/project/create")
    @ResponseBody
    public Map<String, Object> createProject(@RequestBody WorkProject project, Authentication authentication) {
        Map<String, Object> result = new HashMap<>();
        try {
            CustomUserDetails user = (CustomUserDetails) authentication.getPrincipal();
            project.setUserId(user.getUsername());
            project.setCurrentStage("INITIATION");
            project.setProjectStatus("IN_PROGRESS");
            workProcessService.createProject(project);
            result.put("success", true);
            result.put("message", "프로젝트 생성 완료");
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", e.getMessage());
        }
        return result;
    }

    @GetMapping("/project/{projectId}")
    @ResponseBody
    public Map<String, Object> getProjectDetail(@PathVariable Long projectId) {
        Map<String, Object> result = new HashMap<>();
        result.put("project", workProcessService.getProjectById(projectId));
        result.put("documents", workProcessService.getDocumentsByProjectId(projectId));
        return result;
    }
    
    @PostMapping("/document/upload")
    @ResponseBody
    public Map<String, Object> uploadDocument(@RequestParam Long documentId, @RequestParam("file") MultipartFile file) {
        Map<String, Object> result = new HashMap<>();
        try {
            workProcessService.uploadDocument(documentId, file);
            result.put("success", true);
            result.put("message", "업로드 완료");
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", e.getMessage());
        }
        return result;
    }
    
    @GetMapping("/document/download/{documentId}")
    public ResponseEntity<Resource> downloadDocument(@PathVariable Long documentId) {
        try {
            StageDocument doc = workProcessService.getDocumentById(documentId);
            if (doc == null || doc.getFilePath() == null) return ResponseEntity.notFound().build();
            Path path = Paths.get(uploadPath, doc.getFilePath());
            Resource resource = new UrlResource(path.toUri());
            if (!resource.exists()) return ResponseEntity.notFound().build();
            String fileName = doc.getOriginalFileName();
            String encodedName = URLEncoder.encode(fileName, StandardCharsets.UTF_8).replaceAll("\\+", "%20");
            return ResponseEntity.ok().contentType(MediaType.APPLICATION_OCTET_STREAM).header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename*=UTF-8''" + encodedName).body(resource);
        } catch (Exception e) {
            return ResponseEntity.internalServerError().build();
        }
    }
    
    @PostMapping("/stage/approve")
    @ResponseBody
    public Map<String, Object> approveStage(@RequestParam Long projectId, @RequestParam String stage, Authentication auth) {
        Map<String, Object> result = new HashMap<>();
        try {
            workProcessService.approveStage(projectId, stage, auth.getName(), "관리자 승인");
            result.put("success", true);
            result.put("message", "단계 승인 완료");
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", e.getMessage());
        }
        return result;
    }
}