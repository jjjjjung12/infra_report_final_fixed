package com.infraReport.dr.service;

import java.util.List;
import java.util.Map;

import com.infraReport.dr.dto.DrDashboardDTO.*;

/**
 * DR 대시보드 서비스 인터페이스
 */
public interface DrDashboardService {
    
    // =====================================================
    // 훈련 마스터 관련
    // =====================================================
    
    /** 훈련 목록 조회 */
    List<DrillInfo> getDrillList(Map<String, Object> params);
    
    /** 훈련 상세 조회 */
    DrillInfo getDrillById(Integer drillId);
    
    /** 현재 진행중인 훈련 조회 */
    DrillInfo getActiveDrill();
    
    /** 훈련 등록 */
    int createDrill(DrillInfo drill);
    
    /** 훈련 수정 */
    int updateDrill(DrillInfo drill);
    
    /** 훈련 삭제 */
    int deleteDrill(Integer drillId);
    
    /** 훈련 시작 */
    int startDrill(Integer drillId);
    
    /** 훈련 일시정지 */
    int pauseDrill(Integer drillId);
    
    /** 훈련 재개 */
    int resumeDrill(Integer drillId);
    
    /** 훈련 다시 시작 */
    int restartDrill(Integer drillId);
    
    /** 훈련 종료 */
    int endDrill(Integer drillId);
    
    // =====================================================
    // 센터 관련
    // =====================================================
    
    /** 전체 센터 목록 */
    List<CenterInfo> getCenterList();
    
    /** 훈련별 센터 목록 */
    List<CenterInfo> getCentersByDrillId(Integer drillId);
    
    /** 센터 상세 조회 */
    CenterInfo getCenterById(Integer centerId);
    
    /** 센터 등록 */
    int createCenter(CenterInfo center);
    
    /** 센터 수정 */
    int updateCenter(CenterInfo center);
    
    /** 센터 삭제 */
    int deleteCenter(Integer centerId);
    
    /** 훈련에 센터 매핑 */
    int addCenterToDrill(Integer drillId, Integer centerId, String roleType);
    
    // =====================================================
    // 태스크 관련
    // =====================================================
    
    /** 훈련별 태스크 목록 (세부태스크 포함) */
    List<TaskInfo> getTasksWithSubtasks(Integer drillId);
    
    /** 태스크 상세 조회 */
    TaskInfo getTaskById(Integer taskId);
    
    /** 태스크 등록 */
    int createTask(TaskInfo task);
    
    /** 태스크 수정 */
    int updateTask(TaskInfo task);
    
    /** 태스크 삭제 */
    int deleteTask(Integer taskId);
    
    /** 태스크 순서 변경 */
    int updateTaskOrder(Integer taskId, Integer taskOrder);
    
    /** 태스크 시작 */
    int startTask(Integer taskId);
    
    /** 태스크 완료 */
    int completeTask(Integer taskId);
    
    // =====================================================
    // 세부 태스크 관련
    // =====================================================
    
    /** 대분류별 세부 태스크 목록 */
    List<SubtaskInfo> getSubtasksByTaskId(Integer taskId);
    
    /** 세부 태스크 상세 */
    SubtaskInfo getSubtaskById(Integer subtaskId);
    
    /** 세부 태스크 등록 */
    int createSubtask(SubtaskInfo subtask);
    
    /** 세부 태스크 수정 */
    int updateSubtask(SubtaskInfo subtask);
    
    /** 세부 태스크 삭제 */
    int deleteSubtask(Integer subtaskId);
    
    /** 세부 태스크 순서 변경 */
    int updateSubtaskOrder(Integer subtaskId, Integer subtaskOrder);
    
    /** 세부 태스크 시작 */
    int startSubtask(Integer subtaskId);
    
    /** 세부 태스크 완료 */
    int completeSubtask(Integer subtaskId);
    
    /** 세부태스크 일괄 순서 변경 */
    int reorderSubtasks(List<Map<String, Integer>> orderList);
    
    /** 태스크 순서 변경 */
    int reorderTasks(List<Map<String, Integer>> orderList);
    
    // =====================================================
    // 타임라인 관련
    // =====================================================
    
    /** 훈련별 타임라인 조회 */
    List<TimelineEvent> getTimelineByDrillId(Integer drillId);
    
    /** 타임라인 이벤트 등록 */
    int addTimelineEvent(TimelineEvent event);
    
    // =====================================================
    // 시스템 복구 관련
    // =====================================================
    
    /** 훈련별 복구 시스템 목록 */
    List<RecoverySystemInfo> getRecoverySystems(Integer drillId);
    
    /** 복구 시스템 등록 */
    int createRecoverySystem(RecoverySystemInfo system);
    
    /** 복구 시스템 수정 */
    int updateRecoverySystem(RecoverySystemInfo system);
    
    /** 복구 시스템 삭제 */
    int deleteRecoverySystem(Integer systemId);
    
    /** 복구 시스템 시작 */
    int startRecoverySystem(Integer systemId);
    
    /** 복구 시스템 완료 */
    int completeRecoverySystem(Integer systemId);
    
    /** 복구 시스템 통계 */
    StatInfo getRecoverySystemStats(Integer drillId);
    
    // =====================================================
    // 업무 점검 관련
    // =====================================================
    
    /** 훈련별 점검 항목 목록 */
    List<BusinessCheckInfo> getBusinessChecks(Integer drillId);
    
    /** 점검 항목 등록 */
    int createBusinessCheck(BusinessCheckInfo check);
    
    /** 점검 항목 수정 */
    int updateBusinessCheck(BusinessCheckInfo check);
    
    /** 점검 항목 삭제 */
    int deleteBusinessCheck(Integer checkId);
    
    /** 점검 결과 업데이트 */
    int updateBusinessCheckStatus(Integer checkId, String status);
    
    /** 업무 점검 통계 */
    StatInfo getBusinessCheckStats(Integer drillId);
    
    // =====================================================
    // 대시보드 데이터 통합 조회
    // =====================================================
    
    /** DR 현황판 전체 데이터 */
    Map<String, Object> getDrDashboardData(Integer drillId);
    
    /** RTO 잔여시간 계산 */
    Map<String, Object> getRtoRemaining(Integer drillId);
}
