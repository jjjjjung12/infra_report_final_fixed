package com.infraReport.work.dao;

import com.infraReport.work.domain.*;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import java.util.List;
import java.util.Map;

@Mapper
public interface WorkProcessDAO {
    List<WorkProject> selectAllProjects();
    List<WorkProject> selectProjectsByUserId(@Param("userId") String userId);
    WorkProject selectProjectById(@Param("projectId") Long projectId);
    int insertProject(WorkProject project);
    int updateProject(WorkProject project);
    int updateProjectStage(@Param("projectId") Long projectId, @Param("stage") String stage);
    int updateProjectStatus(@Param("projectId") Long projectId, @Param("status") String status);

    List<StageDocument> selectDocumentsByProjectId(@Param("projectId") Long projectId);
    List<StageDocument> selectDocumentsByProjectIdAndStage(@Param("projectId") Long projectId, @Param("stage") String stage);
    List<StageDocument> selectPendingDocuments();
    StageDocument selectDocumentById(@Param("documentId") Long documentId);
    int insertDocument(StageDocument document);
    int updateDocumentFile(@Param("documentId") Long documentId, @Param("filePath") String filePath, @Param("fileName") String fileName, @Param("originalFileName") String originalFileName);
    int updateDocumentStatus(@Param("documentId") Long documentId, @Param("status") String status, @Param("approverId") String approverId, @Param("reason") String reason);
    int countApprovedDocumentsByStage(@Param("projectId") Long projectId, @Param("stage") String stage);
    int countTotalDocumentsByStage(@Param("projectId") Long projectId, @Param("stage") String stage);
    boolean isStageAllApproved(@Param("projectId") Long projectId, @Param("stage") String stage);
    int deleteDocument(Long documentId); // [추가]
    List<WorkDocumentTemplate> selectTemplatesByStage(@Param("stage") String stage);
    List<WorkDocumentTemplate> selectAllTemplates();
    
    // [추가] 템플릿 등록
    int insertTemplate(WorkDocumentTemplate template);
 // [추가] 프로젝트 삭제용
    int deleteProject(Long projectId);
    int deleteDocumentsByProjectId(Long projectId);
    int deleteApprovalHistoryByProjectId(Long projectId);
    WorkDocumentTemplate selectTemplateById(@Param("templateId") Long templateId);
    int insertApprovalHistory(@Param("projectId") Long projectId, @Param("stage") String stage, @Param("status") String status, @Param("approverId") String approverId, @Param("comments") String comments);
    int insertApprovalHistoryWithDocument(@Param("projectId") Long projectId, @Param("documentId") Long documentId, @Param("stage") String stage, @Param("status") String status, @Param("approverId") String approverId, @Param("comments") String comments);
    List<Map<String, Object>> selectApprovalHistory();
    List<Map<String, Object>> selectApprovalHistoryByProjectId(@Param("projectId") Long projectId);
}