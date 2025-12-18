package com.infraReport.work.service;

import com.infraReport.work.domain.StageDocument;
import com.infraReport.work.domain.WorkDocumentTemplate;
import com.infraReport.work.domain.WorkProject;
import org.springframework.web.multipart.MultipartFile;
import java.util.List;
import java.util.Map;

public interface WorkProcessService {
    
    List<WorkProject> getAllProjects();
    List<WorkProject> getProjectsByUserId(String userId);
    WorkProject getProjectById(Long projectId);
    Long createProject(WorkProject project);
    void updateProject(WorkProject project);
    
    // [추가] 프로젝트 삭제
    void deleteProject(Long projectId);

    List<StageDocument> getDocumentsByProjectId(Long projectId);
    List<StageDocument> getDocumentsByProjectIdAndStage(Long projectId, String stage);
    List<StageDocument> getPendingDocuments();
    StageDocument getDocumentById(Long documentId);
    
    List<StageDocument> getPreviousStageDocuments(Long projectId, String currentStage);
    
    void addStageDocument(Long projectId, Long templateId);
    void removeStageDocument(Long documentId);
    void uploadDocument(Long documentId, MultipartFile file) throws Exception;
    
    void approveDocument(Long documentId, String approverId);
    void approveDocument(Long documentId, String approverId, String comments);
    void rejectDocument(Long documentId, String approverId, String reason);

    boolean isStageAllApproved(Long projectId, String stage);
    int[] getStageApprovalProgress(Long projectId, String stage);
    void approveStage(Long projectId, String stage, String approverId, String comments);
    void advanceToNextStage(Long projectId, String approverId, String comments);

    List<WorkDocumentTemplate> getTemplatesByStage(String stage);
    List<WorkDocumentTemplate> getAllTemplates();
    WorkDocumentTemplate getTemplateById(Long templateId);
    void uploadTemplate(String stage, String documentType, String documentName, MultipartFile file) throws Exception;

    List<Map<String, Object>> getApprovalHistory();
    List<Map<String, Object>> getApprovalHistoryByProjectId(Long projectId);
}