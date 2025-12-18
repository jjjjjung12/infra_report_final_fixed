package com.infraReport.dr.service.impl;

import java.util.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.infraReport.dr.dao.DrDashboardDAO;
import com.infraReport.dr.dto.DrDashboardDTO.*;
import com.infraReport.dr.service.DrDashboardService;

@Service
public class DrDashboardServiceImpl implements DrDashboardService {

    @Autowired
    private DrDashboardDAO drDashboardDAO;

    // ... 기존 훈련(Drill) 관련 메서드는 유지 ...
    @Override
    public List<DrillInfo> getDrillList(Map<String, Object> params) { return drDashboardDAO.selectDrillList(params); }
    @Override
    public DrillInfo getDrillById(Integer drillId) { return drDashboardDAO.selectDrillById(drillId); }
    @Override
    public DrillInfo getActiveDrill() { return drDashboardDAO.selectActiveDrill(); }
    @Override
    @Transactional
    public int createDrill(DrillInfo drill) { return drDashboardDAO.insertDrill(drill); }
    @Override
    @Transactional
    public int updateDrill(DrillInfo drill) { return drDashboardDAO.updateDrill(drill); }
    @Override
    @Transactional
    public int deleteDrill(Integer drillId) { return drDashboardDAO.deleteDrill(drillId); }
    @Override
    @Transactional
    public int startDrill(Integer drillId) {
        int result = drDashboardDAO.startDrill(drillId);
        TimelineEvent event = new TimelineEvent(); event.setDrillId(drillId); event.setEventTime(new Date()); event.setEventType("DRILL_START"); event.setEventTitle("훈련 시작"); event.setEventDesc("DR 훈련이 시작되었습니다."); drDashboardDAO.insertTimelineEvent(event);
        return result;
    }
    @Override
    @Transactional
    public int pauseDrill(Integer drillId) {
        int result = drDashboardDAO.pauseDrill(drillId);
        TimelineEvent event = new TimelineEvent(); event.setDrillId(drillId); event.setEventTime(new Date()); event.setEventType("DRILL_PAUSE"); event.setEventTitle("훈련 일시정지"); event.setEventDesc("DR 훈련이 일시정지되었습니다."); drDashboardDAO.insertTimelineEvent(event);
        return result;
    }
    @Override
    @Transactional
    public int resumeDrill(Integer drillId) {
        int result = drDashboardDAO.resumeDrill(drillId);
        TimelineEvent event = new TimelineEvent(); event.setDrillId(drillId); event.setEventTime(new Date()); event.setEventType("DRILL_RESUME"); event.setEventTitle("훈련 재개"); event.setEventDesc("DR 훈련이 재개되었습니다."); drDashboardDAO.insertTimelineEvent(event);
        return result;
    }
    @Override
    @Transactional
    public int restartDrill(Integer drillId) {
        drDashboardDAO.resetSubtasks(drillId); drDashboardDAO.resetTasks(drillId); drDashboardDAO.resetRecoverySystems(drillId); drDashboardDAO.resetBusinessChecks(drillId);
        int result = drDashboardDAO.restartDrill(drillId);
        TimelineEvent event = new TimelineEvent(); event.setDrillId(drillId); event.setEventTime(new Date()); event.setEventType("DRILL_RESTART"); event.setEventTitle("훈련 다시 시작"); event.setEventDesc("DR 훈련이 초기화되어 다시 시작되었습니다."); drDashboardDAO.insertTimelineEvent(event);
        return result;
    }
    @Override
    @Transactional
    public int endDrill(Integer drillId) {
        int result = drDashboardDAO.endDrill(drillId);
        TimelineEvent event = new TimelineEvent(); event.setDrillId(drillId); event.setEventTime(new Date()); event.setEventType("DRILL_END"); event.setEventTitle("훈련 종료"); event.setEventDesc("DR 훈련이 종료되었습니다."); drDashboardDAO.insertTimelineEvent(event);
        return result;
    }

    // 센터, 태스크 관련
    @Override
    public List<CenterInfo> getCenterList() { return drDashboardDAO.selectCenterList(); }
    @Override
    public List<CenterInfo> getCentersByDrillId(Integer drillId) { return drDashboardDAO.selectCentersByDrillId(drillId); }
    @Override
    public CenterInfo getCenterById(Integer centerId) { return drDashboardDAO.selectCenterById(centerId); }
    @Override
    @Transactional
    public int createCenter(CenterInfo center) { return drDashboardDAO.insertCenter(center); }
    @Override
    @Transactional
    public int updateCenter(CenterInfo center) { return drDashboardDAO.updateCenter(center); }
    @Override
    @Transactional
    public int deleteCenter(Integer centerId) { return drDashboardDAO.deleteCenter(centerId); }
    @Override
    @Transactional
    public int addCenterToDrill(Integer drillId, Integer centerId, String roleType) { return drDashboardDAO.insertDrillCenter(drillId, centerId, roleType); }

    @Override
    public List<TaskInfo> getTasksWithSubtasks(Integer drillId) {
        List<TaskInfo> tasks = drDashboardDAO.selectTasksByDrillId(drillId);
        for (TaskInfo task : tasks) {
            List<SubtaskInfo> subtasks = drDashboardDAO.selectSubtasksByTaskId(task.getTaskId());
            task.setSubtasks(subtasks);
            task.setTotalSubtasks(subtasks.size());
            int completed = 0;
            for (SubtaskInfo subtask : subtasks) {
                if ("COMPLETED".equals(subtask.getStatus())) {
                    completed++;
                }
            }
            task.setCompletedSubtasks(completed);
            // 진척률은 DB에 저장된 값을 우선하되, 계산 로직도 유지
            // task.setProgressRate() -> DB에서 가져온 값이 이미 있음
        }
        return tasks;
    }

    @Override
    public TaskInfo getTaskById(Integer taskId) {
        TaskInfo task = drDashboardDAO.selectTaskById(taskId);
        if (task != null) {
            task.setSubtasks(drDashboardDAO.selectSubtasksByTaskId(taskId));
        }
        return task;
    }

    @Override
    @Transactional
    public int createTask(TaskInfo task) { return drDashboardDAO.insertTask(task); }
    @Override
    @Transactional
    public int updateTask(TaskInfo task) { return drDashboardDAO.updateTask(task); }
    @Override
    @Transactional
    public int deleteTask(Integer taskId) { return drDashboardDAO.deleteTask(taskId); }
    @Override
    @Transactional
    public int updateTaskOrder(Integer taskId, Integer taskOrder) { return drDashboardDAO.updateTaskOrder(taskId, taskOrder); }

    @Override
    @Transactional
    public int startTask(Integer taskId) {
        TaskInfo task = drDashboardDAO.selectTaskById(taskId);
        int result = drDashboardDAO.startTask(taskId);
        if (task != null) {
            TimelineEvent event = new TimelineEvent();
            event.setDrillId(task.getDrillId());
            event.setEventTime(new Date());
            event.setEventType("TASK_START");
            event.setEventTitle(task.getTaskName() + " 시작");
            drDashboardDAO.insertTimelineEvent(event);
        }
        return result;
    }

    @Override
    @Transactional
    public int completeTask(Integer taskId) {
        TaskInfo task = drDashboardDAO.selectTaskById(taskId);
        int result = drDashboardDAO.completeTask(taskId);
        if (task != null) {
            TimelineEvent event = new TimelineEvent();
            event.setDrillId(task.getDrillId());
            event.setEventTime(new Date());
            event.setEventType("TASK_COMPLETE");
            event.setEventTitle(task.getTaskName() + " 완료");
            drDashboardDAO.insertTimelineEvent(event);
        }
        return result;
    }

    @Override
    public List<SubtaskInfo> getSubtasksByTaskId(Integer taskId) { return drDashboardDAO.selectSubtasksByTaskId(taskId); }
    @Override
    public SubtaskInfo getSubtaskById(Integer subtaskId) { return drDashboardDAO.selectSubtaskById(subtaskId); }
    
    // [수정] Subtask 생성 시 진척률 상태 동기화
    @Override
    @Transactional
    public int createSubtask(SubtaskInfo subtask) {
        syncStatusWithProgress(subtask); // 상태 동기화
        int result = drDashboardDAO.insertSubtask(subtask);
        updateTaskProgressRate(subtask.getTaskId()); // 상위 태스크 갱신
        return result;
    }

    // [수정] Subtask 수정 시 진척률 상태 동기화
    @Override
    @Transactional
    public int updateSubtask(SubtaskInfo subtask) {
        syncStatusWithProgress(subtask); // 상태 동기화
        int result = drDashboardDAO.updateSubtask(subtask);
        updateTaskProgressRate(subtask.getTaskId()); // 상위 태스크 갱신
        return result;
    }
    
    // [추가] 진척률에 따른 상태 자동 변경 로직
    private void syncStatusWithProgress(SubtaskInfo subtask) {
        int rate = subtask.getProgressRate() != null ? subtask.getProgressRate() : 0;
        
        if (rate >= 100) {
            subtask.setStatus("COMPLETED");
            subtask.setProgressRate(100);
            if(subtask.getActualEndTime() == null) subtask.setActualEndTime(new Date());
        } else if (rate > 0) {
            subtask.setStatus("PROGRESS");
            if(subtask.getActualStartTime() == null) subtask.setActualStartTime(new Date());
        } else {
            subtask.setStatus("WAITING");
            subtask.setProgressRate(0);
        }
    }

    @Override
    @Transactional
    public int deleteSubtask(Integer subtaskId) {
        SubtaskInfo subtask = drDashboardDAO.selectSubtaskById(subtaskId);
        int result = drDashboardDAO.deleteSubtask(subtaskId);
        if(subtask != null) {
            updateTaskProgressRate(subtask.getTaskId());
        }
        return result;
    }
    
    @Override
    @Transactional
    public int updateSubtaskOrder(Integer subtaskId, Integer subtaskOrder) { return drDashboardDAO.updateSubtaskOrder(subtaskId, subtaskOrder); }
    
    @Override
    @Transactional
    public int startSubtask(Integer subtaskId) {
        int result = drDashboardDAO.startSubtask(subtaskId);
        SubtaskInfo subtask = drDashboardDAO.selectSubtaskById(subtaskId);
        if (subtask != null) {
            updateTaskProgressRate(subtask.getTaskId());
        }
        return result;
    }

    @Override
    @Transactional
    public int completeSubtask(Integer subtaskId) {
        SubtaskInfo subtask = drDashboardDAO.selectSubtaskById(subtaskId);
        int result = drDashboardDAO.completeSubtask(subtaskId);
        if (subtask != null) {
            updateTaskProgressRate(subtask.getTaskId());
        }
        return result;
    }

    @Override
    @Transactional
    public int reorderSubtasks(List<Map<String, Integer>> orderList) {
        int result = 0;
        for (Map<String, Integer> item : orderList) {
            result += drDashboardDAO.updateSubtaskOrder(item.get("subtaskId"), item.get("subtaskOrder"));
        }
        return result;
    }

    @Override
    @Transactional
    public int reorderTasks(List<Map<String, Integer>> orderList) {
        int result = 0;
        for (Map<String, Integer> item : orderList) {
            result += drDashboardDAO.updateTaskOrder(item.get("taskId"), item.get("taskOrder"));
        }
        return result;
    }

    // [수정] 상위 태스크 진척률 계산 로직 변경 (평균값 사용)
    private void updateTaskProgressRate(Integer taskId) {
        int total = drDashboardDAO.countTotalSubtasks(taskId);
        int progressRate = 0;
        
        if (total > 0) {
            // 하위 태스크들의 진척률 평균 계산
            progressRate = drDashboardDAO.calculateTaskProgressRate(taskId);
        }
        
        drDashboardDAO.updateTaskProgress(taskId, progressRate);
        
        // 100%면 상위 태스크도 완료 처리
        if (total > 0 && progressRate >= 100) {
            drDashboardDAO.completeTask(taskId);
        }
    }

    @Override
    public List<TimelineEvent> getTimelineByDrillId(Integer drillId) { return drDashboardDAO.selectTimelineByDrillId(drillId); }
    @Override
    @Transactional
    public int addTimelineEvent(TimelineEvent event) { return drDashboardDAO.insertTimelineEvent(event); }

    // ... 나머지 Recovery, Check, Dashboard 조회 로직 등은 기존과 동일 ...
    @Override
    public List<RecoverySystemInfo> getRecoverySystems(Integer drillId) { return drDashboardDAO.selectRecoverySystemsByDrillId(drillId); }
    @Override
    @Transactional
    public int createRecoverySystem(RecoverySystemInfo system) { return drDashboardDAO.insertRecoverySystem(system); }
    @Override
    @Transactional
    public int updateRecoverySystem(RecoverySystemInfo system) { return drDashboardDAO.updateRecoverySystem(system); }
    @Override
    @Transactional
    public int deleteRecoverySystem(Integer systemId) { return drDashboardDAO.deleteRecoverySystem(systemId); }
    @Override
    @Transactional
    public int startRecoverySystem(Integer systemId) { return drDashboardDAO.startRecoverySystem(systemId); }
    @Override
    @Transactional
    public int completeRecoverySystem(Integer systemId) { return drDashboardDAO.completeRecoverySystem(systemId); }
    @Override
    public StatInfo getRecoverySystemStats(Integer drillId) { return drDashboardDAO.selectRecoverySystemStats(drillId); }

    @Override
    public List<BusinessCheckInfo> getBusinessChecks(Integer drillId) { return drDashboardDAO.selectBusinessChecksByDrillId(drillId); }
    @Override
    @Transactional
    public int createBusinessCheck(BusinessCheckInfo check) { return drDashboardDAO.insertBusinessCheck(check); }
    @Override
    @Transactional
    public int updateBusinessCheck(BusinessCheckInfo check) { return drDashboardDAO.updateBusinessCheck(check); }
    @Override
    @Transactional
    public int deleteBusinessCheck(Integer checkId) { return drDashboardDAO.deleteBusinessCheck(checkId); }
    @Override
    @Transactional
    public int updateBusinessCheckStatus(Integer checkId, String status) { return drDashboardDAO.updateBusinessCheckStatus(checkId, status); }
    @Override
    public StatInfo getBusinessCheckStats(Integer drillId) { return drDashboardDAO.selectBusinessCheckStats(drillId); }

    @Override
    public Map<String, Object> getDrDashboardData(Integer drillId) {
        Map<String, Object> result = new HashMap<>();
        DrillInfo drill = drDashboardDAO.selectDrillById(drillId);
        result.put("drill", drill);
        result.put("centers", drDashboardDAO.selectCentersByDrillId(drillId));
        result.put("tasks", getTasksWithSubtasks(drillId));
        result.put("timeline", drDashboardDAO.selectTimelineByDrillId(drillId));
        result.put("recoverySystems", drDashboardDAO.selectRecoverySystemsByDrillId(drillId));
        result.put("recoveryStats", drDashboardDAO.selectRecoverySystemStats(drillId));
        result.put("businessChecks", drDashboardDAO.selectBusinessChecksByDrillId(drillId));
        result.put("checkStats", drDashboardDAO.selectBusinessCheckStats(drillId));
        result.put("rtoRemaining", getRtoRemaining(drillId));
        return result;
    }

    @Override
    public Map<String, Object> getRtoRemaining(Integer drillId) {
        Map<String, Object> result = new HashMap<>();
        DrillInfo drill = drDashboardDAO.selectDrillById(drillId);
        if (drill == null || drill.getStartTime() == null) {
            result.put("hours", 0); result.put("minutes", 0); result.put("seconds", 0); result.put("totalSeconds", 0);
            return result;
        }
        long rtoSeconds = (drill.getRtoHours() * 3600) + (drill.getRtoMinutes() * 60);
        long elapsedSeconds = (System.currentTimeMillis() - drill.getStartTime().getTime()) / 1000;
        long remainingSeconds = rtoSeconds - elapsedSeconds;
        if (remainingSeconds < 0) remainingSeconds = 0;
        long hours = remainingSeconds / 3600;
        long minutes = (remainingSeconds % 3600) / 60;
        long seconds = remainingSeconds % 60;
        result.put("hours", hours); result.put("minutes", minutes); result.put("seconds", seconds); result.put("totalSeconds", remainingSeconds); result.put("exceeded", elapsedSeconds > rtoSeconds);
        return result;
    }
}