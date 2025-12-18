package com.infraReport.dr.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.infraReport.dr.dto.DrDashboardDTO.*;

@Mapper
public interface DrDashboardDAO {
    
    List<DrillInfo> selectDrillList(Map<String, Object> params);
    DrillInfo selectDrillById(@Param("drillId") Integer drillId);
    DrillInfo selectActiveDrill();
    int insertDrill(DrillInfo drill);
    int updateDrill(DrillInfo drill);
    int deleteDrill(@Param("drillId") Integer drillId);
    int updateDrillStatus(@Param("drillId") Integer drillId, @Param("status") String status);
    int startDrill(@Param("drillId") Integer drillId);
    int pauseDrill(@Param("drillId") Integer drillId);
    int resumeDrill(@Param("drillId") Integer drillId);
    int endDrill(@Param("drillId") Integer drillId);

    int restartDrill(@Param("drillId") Integer drillId);
    int resetTasks(@Param("drillId") Integer drillId);
    int resetSubtasks(@Param("drillId") Integer drillId);
    int resetRecoverySystems(@Param("drillId") Integer drillId);
    int resetBusinessChecks(@Param("drillId") Integer drillId);
    
    List<CenterInfo> selectCenterList();
    List<CenterInfo> selectCentersByDrillId(@Param("drillId") Integer drillId);
    CenterInfo selectCenterById(@Param("centerId") Integer centerId);
    int insertCenter(CenterInfo center);
    int updateCenter(CenterInfo center);
    int deleteCenter(@Param("centerId") Integer centerId);
    int insertDrillCenter(@Param("drillId") Integer drillId, @Param("centerId") Integer centerId, @Param("roleType") String roleType);
    int deleteDrillCenter(@Param("drillId") Integer drillId);

    List<TaskInfo> selectTasksByDrillId(@Param("drillId") Integer drillId);
    TaskInfo selectTaskById(@Param("taskId") Integer taskId);
    int insertTask(TaskInfo task);
    int updateTask(TaskInfo task);
    int deleteTask(@Param("taskId") Integer taskId);
    int updateTaskOrder(@Param("taskId") Integer taskId, @Param("taskOrder") Integer taskOrder);
    int startTask(@Param("taskId") Integer taskId);
    int completeTask(@Param("taskId") Integer taskId);
    int updateTaskProgress(@Param("taskId") Integer taskId, @Param("progressRate") Integer progressRate);

    // [수정] 태스크 진척률 평균 계산 메서드 추가
    int calculateTaskProgressRate(@Param("taskId") Integer taskId);

    List<SubtaskInfo> selectSubtasksByTaskId(@Param("taskId") Integer taskId);
    SubtaskInfo selectSubtaskById(@Param("subtaskId") Integer subtaskId);
    int insertSubtask(SubtaskInfo subtask);
    int updateSubtask(SubtaskInfo subtask);
    int deleteSubtask(@Param("subtaskId") Integer subtaskId);
    int updateSubtaskOrder(@Param("subtaskId") Integer subtaskId, @Param("subtaskOrder") Integer subtaskOrder);
    int startSubtask(@Param("subtaskId") Integer subtaskId);
    int completeSubtask(@Param("subtaskId") Integer subtaskId);
    int countCompletedSubtasks(@Param("taskId") Integer taskId);
    int countTotalSubtasks(@Param("taskId") Integer taskId);

    List<TimelineEvent> selectTimelineByDrillId(@Param("drillId") Integer drillId);
    int insertTimelineEvent(TimelineEvent event);
    int deleteTimelineEvent(@Param("timelineId") Integer timelineId);

    List<RecoverySystemInfo> selectRecoverySystemsByDrillId(@Param("drillId") Integer drillId);
    int insertRecoverySystem(RecoverySystemInfo system);
    int updateRecoverySystem(RecoverySystemInfo system);
    int deleteRecoverySystem(@Param("systemId") Integer systemId);
    int updateRecoverySystemStatus(@Param("systemId") Integer systemId, @Param("status") String status);
    int startRecoverySystem(@Param("systemId") Integer systemId);
    int completeRecoverySystem(@Param("systemId") Integer systemId);
    StatInfo selectRecoverySystemStats(@Param("drillId") Integer drillId);

    List<BusinessCheckInfo> selectBusinessChecksByDrillId(@Param("drillId") Integer drillId);
    int insertBusinessCheck(BusinessCheckInfo check);
    int updateBusinessCheck(BusinessCheckInfo check);
    int deleteBusinessCheck(@Param("checkId") Integer checkId);
    int updateBusinessCheckStatus(@Param("checkId") Integer checkId, @Param("status") String status);
    StatInfo selectBusinessCheckStats(@Param("drillId") Integer drillId);
}