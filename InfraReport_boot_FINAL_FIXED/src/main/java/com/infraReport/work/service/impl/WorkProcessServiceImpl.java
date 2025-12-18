package com.infraReport.work.service.impl;

import com.infraReport.work.dao.WorkProcessDAO;
import com.infraReport.work.domain.StageDocument;
import com.infraReport.work.domain.WorkDocumentTemplate;
import com.infraReport.work.domain.WorkProject;
import com.infraReport.work.service.WorkProcessService;
import com.infraReport.util.FileUploadUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Service
@Transactional
public class WorkProcessServiceImpl implements WorkProcessService {

    @Autowired
    private WorkProcessDAO workProcessDAO;

    @Value("${file.upload.path:c:/uploads}")
    private String uploadPath;

    @Override
    public List<WorkProject> getAllProjects() { return workProcessDAO.selectAllProjects(); }
    @Override
    public List<WorkProject> getProjectsByUserId(String userId) { return workProcessDAO.selectProjectsByUserId(userId); }
    @Override
    public WorkProject getProjectById(Long projectId) { return workProcessDAO.selectProjectById(projectId); }
    
    @Override
    public Long createProject(WorkProject project) {
        workProcessDAO.insertProject(project);
        createStageDocuments(project.getProjectId(), "INITIATION");
        return project.getProjectId();
    }
    @Override
    public void updateProject(WorkProject project) { workProcessDAO.updateProject(project); }

    // [구현] 프로젝트 삭제 (순서 중요!)
    @Override
    public void deleteProject(Long projectId) {
        // 1. 승인 이력 삭제
        workProcessDAO.deleteApprovalHistoryByProjectId(projectId);
        // 2. 문서 삭제
        workProcessDAO.deleteDocumentsByProjectId(projectId);
        // 3. 프로젝트 삭제
        workProcessDAO.deleteProject(projectId);
    }

    @Override
    public List<StageDocument> getDocumentsByProjectId(Long projectId) { return workProcessDAO.selectDocumentsByProjectId(projectId); }
    @Override
    public List<StageDocument> getDocumentsByProjectIdAndStage(Long projectId, String stage) { return workProcessDAO.selectDocumentsByProjectIdAndStage(projectId, stage); }
    
    @Override
    public List<StageDocument> getPreviousStageDocuments(Long projectId, String currentStage) {
        String prevStage = "";
        if ("CONSTRUCTION".equals(currentStage)) prevStage = "INITIATION";
        else if ("COMPLETION".equals(currentStage)) prevStage = "CONSTRUCTION";
        else return new ArrayList<>();
        return workProcessDAO.selectDocumentsByProjectIdAndStage(projectId, prevStage);
    }

    @Override
    public List<StageDocument> getPendingDocuments() { return workProcessDAO.selectPendingDocuments(); }
    @Override
    public StageDocument getDocumentById(Long documentId) { return workProcessDAO.selectDocumentById(documentId); }

    @Override
    public void addStageDocument(Long projectId, Long templateId) {
        WorkDocumentTemplate t = workProcessDAO.selectTemplateById(templateId);
        if(t == null) throw new IllegalArgumentException("템플릿 정보가 없습니다.");
        StageDocument d = new StageDocument();
        d.setProjectId(projectId);
        d.setStage(t.getStage());
        d.setDocumentType(t.getDocumentType());
        d.setDocumentName(t.getDocumentName());
        d.setDocumentStatus("NOT_UPLOADED");
        workProcessDAO.insertDocument(d);
    }

    @Override
    public void removeStageDocument(Long documentId) {
        workProcessDAO.deleteDocument(documentId);
    }

    @Override
    public void uploadDocument(Long documentId, MultipartFile file) throws Exception {
        String savedPath = FileUploadUtil.saveFile(file, uploadPath, "work-documents");
        workProcessDAO.updateDocumentFile(documentId, savedPath, file.getOriginalFilename(), file.getOriginalFilename());
    }

    @Override
    public void approveDocument(Long documentId, String approverId) { approveDocument(documentId, approverId, null); }
    @Override
    public void approveDocument(Long documentId, String approverId, String comments) {
        StageDocument doc = workProcessDAO.selectDocumentById(documentId);
        workProcessDAO.updateDocumentStatus(documentId, "APPROVED", approverId, null);
        workProcessDAO.insertApprovalHistoryWithDocument(doc.getProjectId(), documentId, doc.getStage(), "APPROVED", approverId, comments);
    }

    @Override
    public void rejectDocument(Long documentId, String approverId, String reason) {
        StageDocument doc = workProcessDAO.selectDocumentById(documentId);
        workProcessDAO.updateDocumentStatus(documentId, "REJECTED", approverId, reason);
        workProcessDAO.insertApprovalHistoryWithDocument(doc.getProjectId(), documentId, doc.getStage(), "REJECTED", approverId, reason);
    }

    @Override
    public boolean isStageAllApproved(Long projectId, String stage) { return workProcessDAO.isStageAllApproved(projectId, stage); }
    @Override
    public int[] getStageApprovalProgress(Long projectId, String stage) { 
        return new int[]{workProcessDAO.countApprovedDocumentsByStage(projectId, stage), workProcessDAO.countTotalDocumentsByStage(projectId, stage)}; 
    }
    @Override
    public void approveStage(Long projectId, String stage, String approverId, String comments) {
        if (!isStageAllApproved(projectId, stage)) throw new IllegalStateException("모든 문서가 승인되어야 합니다.");
        workProcessDAO.insertApprovalHistory(projectId, stage, "STAGE_APPROVED", approverId, comments);
        advanceToNextStage(projectId, approverId, comments);
    }
    @Override
    public void advanceToNextStage(Long projectId, String approverId, String comments) {
        WorkProject p = workProcessDAO.selectProjectById(projectId);
        String next = p.getNextStage();
        if (next == null) workProcessDAO.updateProjectStatus(projectId, "COMPLETED");
        else {
            workProcessDAO.updateProjectStage(projectId, next);
            createStageDocuments(projectId, next);
        }
    }
    
    private void createStageDocuments(Long projectId, String stage) {
        List<WorkDocumentTemplate> tpls = workProcessDAO.selectTemplatesByStage(stage);
        for (WorkDocumentTemplate t : tpls) {
            StageDocument d = new StageDocument();
            d.setProjectId(projectId);
            d.setStage(stage);
            d.setDocumentType(t.getDocumentType());
            d.setDocumentName(t.getDocumentName());
            d.setDocumentStatus("NOT_UPLOADED");
            workProcessDAO.insertDocument(d);
        }
    }
    @Override
    public List<WorkDocumentTemplate> getTemplatesByStage(String stage) { return workProcessDAO.selectTemplatesByStage(stage); }
    @Override
    public List<WorkDocumentTemplate> getAllTemplates() { return workProcessDAO.selectAllTemplates(); }
    @Override
    public WorkDocumentTemplate getTemplateById(Long templateId) { return workProcessDAO.selectTemplateById(templateId); }
    @Override
    public void uploadTemplate(String stage, String documentType, String documentName, MultipartFile file) throws Exception {
        String savedPath = FileUploadUtil.saveFile(file, uploadPath, "templates");
        WorkDocumentTemplate t = new WorkDocumentTemplate();
        t.setStage(stage);
        t.setDocumentType(documentType);
        t.setDocumentName(documentName);
        t.setTemplateFilePath(savedPath);
        t.setTemplateFileName(file.getOriginalFilename());
        t.setIsRequired(true);
        workProcessDAO.insertTemplate(t);
    }
    @Override
    public List<Map<String, Object>> getApprovalHistory() { return workProcessDAO.selectApprovalHistory(); }
    @Override
    public List<Map<String, Object>> getApprovalHistoryByProjectId(Long projectId) { return workProcessDAO.selectApprovalHistoryByProjectId(projectId); }
}