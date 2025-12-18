package com.infraReport.dr.dto;

import java.util.Date;
import java.util.List;
import com.fasterxml.jackson.annotation.JsonFormat;

/**
 * DR 대시보드 관련 DTO
 */
public class DrDashboardDTO {
    
    // =====================================================
    // 훈련 마스터 정보
    // =====================================================
    public static class DrillInfo {
        private Integer drillId;
        private String drillName;
        private String drillType;
        private String drillDesc;
        
        @JsonFormat(pattern = "yyyy-MM-dd", timezone = "Asia/Seoul")
        private Date drillDate;
        
        @JsonFormat(pattern = "yyyy-MM-dd'T'HH:mm:ss", timezone = "Asia/Seoul")
        private Date startTime;
        
        @JsonFormat(pattern = "yyyy-MM-dd'T'HH:mm:ss", timezone = "Asia/Seoul")
        private Date endTime;
        
        private Integer rtoHours;
        private Integer rtoMinutes;
        private String status;
        private String createUserId;
        private Date createDate;
        private String updateUserId;
        private Date updateDate;
        
        // 계산 필드
        private long remainingSeconds;  // RTO 잔여 시간(초)
        private int totalProgress;      // 전체 진척률
        
        // Getters and Setters
        public Integer getDrillId() { return drillId; }
        public void setDrillId(Integer drillId) { this.drillId = drillId; }
        public String getDrillName() { return drillName; }
        public void setDrillName(String drillName) { this.drillName = drillName; }
        public String getDrillType() { return drillType; }
        public void setDrillType(String drillType) { this.drillType = drillType; }
        public String getDrillDesc() { return drillDesc; }
        public void setDrillDesc(String drillDesc) { this.drillDesc = drillDesc; }
        public Date getDrillDate() { return drillDate; }
        public void setDrillDate(Date drillDate) { this.drillDate = drillDate; }
        public Date getStartTime() { return startTime; }
        public void setStartTime(Date startTime) { this.startTime = startTime; }
        public Date getEndTime() { return endTime; }
        public void setEndTime(Date endTime) { this.endTime = endTime; }
        public Integer getRtoHours() { return rtoHours; }
        public void setRtoHours(Integer rtoHours) { this.rtoHours = rtoHours; }
        public Integer getRtoMinutes() { return rtoMinutes; }
        public void setRtoMinutes(Integer rtoMinutes) { this.rtoMinutes = rtoMinutes; }
        public String getStatus() { return status; }
        public void setStatus(String status) { this.status = status; }
        public String getCreateUserId() { return createUserId; }
        public void setCreateUserId(String createUserId) { this.createUserId = createUserId; }
        public Date getCreateDate() { return createDate; }
        public void setCreateDate(Date createDate) { this.createDate = createDate; }
        public String getUpdateUserId() { return updateUserId; }
        public void setUpdateUserId(String updateUserId) { this.updateUserId = updateUserId; }
        public Date getUpdateDate() { return updateDate; }
        public void setUpdateDate(Date updateDate) { this.updateDate = updateDate; }
        public long getRemainingSeconds() { return remainingSeconds; }
        public void setRemainingSeconds(long remainingSeconds) { this.remainingSeconds = remainingSeconds; }
        public int getTotalProgress() { return totalProgress; }
        public void setTotalProgress(int totalProgress) { this.totalProgress = totalProgress; }

    }
    
    // =====================================================
    // 센터 정보
    // =====================================================
    public static class CenterInfo {
        private Integer centerId;
        private String centerName;
        private String centerCode;
        private Double latitude;
        private Double longitude;
        private String centerType;
        private String addr;
        private String useYn;
        private String roleType; // 훈련에서의 역할 (SOURCE/TARGET)
        
        // Getters and Setters
        public Integer getCenterId() { return centerId; }
        public void setCenterId(Integer centerId) { this.centerId = centerId; }
        public String getCenterName() { return centerName; }
        public void setCenterName(String centerName) { this.centerName = centerName; }
        public String getCenterCode() { return centerCode; }
        public void setCenterCode(String centerCode) { this.centerCode = centerCode; }
        public Double getLatitude() { return latitude; }
        public void setLatitude(Double latitude) { this.latitude = latitude; }
        public Double getLongitude() { return longitude; }
        public void setLongitude(Double longitude) { this.longitude = longitude; }
        public String getCenterType() { return centerType; }
        public void setCenterType(String centerType) { this.centerType = centerType; }
        public String getAddr() { return addr; }
        public void setAddr(String addr) { this.addr = addr; }
        public String getUseYn() { return useYn; }
        public void setUseYn(String useYn) { this.useYn = useYn; }
        public String getRoleType() { return roleType; }
        public void setRoleType(String roleType) { this.roleType = roleType; }
    }
    
    // =====================================================
    // 대분류 태스크
    // =====================================================
    public static class TaskInfo {
        private Integer taskId;
        private Integer drillId;
        private String taskName;
        private Integer taskOrder;
        private String taskType;
        private Date planStartTime;
        private Date planEndTime;
        private Date actualStartTime;
        private Date actualEndTime;
        private String assignTeam;
        private String status;
        private Integer progressRate;
        private String createUserId;
        private Date createDate;
        private String updateUserId;
        private Date updateDate;
        
        // 세부 태스크 목록
        private List<SubtaskInfo> subtasks;
        
        // 계산 필드
        private int totalSubtasks;
        private int completedSubtasks;
        
        // Getters and Setters
        public Integer getTaskId() { return taskId; }
        public void setTaskId(Integer taskId) { this.taskId = taskId; }
        public Integer getDrillId() { return drillId; }
        public void setDrillId(Integer drillId) { this.drillId = drillId; }
        public String getTaskName() { return taskName; }
        public void setTaskName(String taskName) { this.taskName = taskName; }
        public Integer getTaskOrder() { return taskOrder; }
        public void setTaskOrder(Integer taskOrder) { this.taskOrder = taskOrder; }
        public String getTaskType() { return taskType; }
        public void setTaskType(String taskType) { this.taskType = taskType; }
        public Date getPlanStartTime() { return planStartTime; }
        public void setPlanStartTime(Date planStartTime) { this.planStartTime = planStartTime; }
        public Date getPlanEndTime() { return planEndTime; }
        public void setPlanEndTime(Date planEndTime) { this.planEndTime = planEndTime; }
        public Date getActualStartTime() { return actualStartTime; }
        public void setActualStartTime(Date actualStartTime) { this.actualStartTime = actualStartTime; }
        public Date getActualEndTime() { return actualEndTime; }
        public void setActualEndTime(Date actualEndTime) { this.actualEndTime = actualEndTime; }
        public String getAssignTeam() { return assignTeam; }
        public void setAssignTeam(String assignTeam) { this.assignTeam = assignTeam; }
        public String getStatus() { return status; }
        public void setStatus(String status) { this.status = status; }
        public Integer getProgressRate() { return progressRate; }
        public void setProgressRate(Integer progressRate) { this.progressRate = progressRate; }
        public String getCreateUserId() { return createUserId; }
        public void setCreateUserId(String createUserId) { this.createUserId = createUserId; }
        public Date getCreateDate() { return createDate; }
        public void setCreateDate(Date createDate) { this.createDate = createDate; }
        public String getUpdateUserId() { return updateUserId; }
        public void setUpdateUserId(String updateUserId) { this.updateUserId = updateUserId; }
        public Date getUpdateDate() { return updateDate; }
        public void setUpdateDate(Date updateDate) { this.updateDate = updateDate; }
        public List<SubtaskInfo> getSubtasks() { return subtasks; }
        public void setSubtasks(List<SubtaskInfo> subtasks) { this.subtasks = subtasks; }
        public int getTotalSubtasks() { return totalSubtasks; }
        public void setTotalSubtasks(int totalSubtasks) { this.totalSubtasks = totalSubtasks; }
        public int getCompletedSubtasks() { return completedSubtasks; }
        public void setCompletedSubtasks(int completedSubtasks) { this.completedSubtasks = completedSubtasks; }
    }
    
    // =====================================================
    // 세부 태스크
    // =====================================================
    public static class SubtaskInfo {
        private Integer subtaskId;
        private Integer taskId;
        private String subtaskName;
        private Integer subtaskOrder;
        private Date planStartTime;
        private Date planEndTime;
        private Date actualStartTime;
        private Date actualEndTime;
        private String assignUser;
        private String assignUserId;
        private String status;
        private Integer progressRate; // [수정] 진척률 필드 추가
        private String remark;
        private String createUserId;
        private Date createDate;
        private String updateUserId;
        private Date updateDate;
        
        // Getters and Setters
        public Integer getSubtaskId() { return subtaskId; }
        public void setSubtaskId(Integer subtaskId) { this.subtaskId = subtaskId; }
        public Integer getTaskId() { return taskId; }
        public void setTaskId(Integer taskId) { this.taskId = taskId; }
        public String getSubtaskName() { return subtaskName; }
        public void setSubtaskName(String subtaskName) { this.subtaskName = subtaskName; }
        public Integer getSubtaskOrder() { return subtaskOrder; }
        public void setSubtaskOrder(Integer subtaskOrder) { this.subtaskOrder = subtaskOrder; }
        public Date getPlanStartTime() { return planStartTime; }
        public void setPlanStartTime(Date planStartTime) { this.planStartTime = planStartTime; }
        public Date getPlanEndTime() { return planEndTime; }
        public void setPlanEndTime(Date planEndTime) { this.planEndTime = planEndTime; }
        public Date getActualStartTime() { return actualStartTime; }
        public void setActualStartTime(Date actualStartTime) { this.actualStartTime = actualStartTime; }
        public Date getActualEndTime() { return actualEndTime; }
        public void setActualEndTime(Date actualEndTime) { this.actualEndTime = actualEndTime; }
        public String getAssignUser() { return assignUser; }
        public void setAssignUser(String assignUser) { this.assignUser = assignUser; }
        public String getAssignUserId() { return assignUserId; }
        public void setAssignUserId(String assignUserId) { this.assignUserId = assignUserId; }
        public String getStatus() { return status; }
        public void setStatus(String status) { this.status = status; }
        public Integer getProgressRate() { return progressRate; } // Getter 추가
        public void setProgressRate(Integer progressRate) { this.progressRate = progressRate; } // Setter 추가
        public String getRemark() { return remark; }
        public void setRemark(String remark) { this.remark = remark; }
        public String getCreateUserId() { return createUserId; }
        public void setCreateUserId(String createUserId) { this.createUserId = createUserId; }
        public Date getCreateDate() { return createDate; }
        public void setCreateDate(Date createDate) { this.createDate = createDate; }
        public String getUpdateUserId() { return updateUserId; }
        public void setUpdateUserId(String updateUserId) { this.updateUserId = updateUserId; }
        public Date getUpdateDate() { return updateDate; }
        public void setUpdateDate(Date updateDate) { this.updateDate = updateDate; }
    }
    
    // =====================================================
    // 타임라인 이벤트
    // =====================================================
    public static class TimelineEvent {
        private Integer timelineId;
        private Integer drillId;
        private Date eventTime;
        private String eventType;
        private String eventTitle;
        private String eventDesc;
        private Date createDate;
        
        // Getters and Setters
        public Integer getTimelineId() { return timelineId; }
        public void setTimelineId(Integer timelineId) { this.timelineId = timelineId; }
        public Integer getDrillId() { return drillId; }
        public void setDrillId(Integer drillId) { this.drillId = drillId; }
        public Date getEventTime() { return eventTime; }
        public void setEventTime(Date eventTime) { this.eventTime = eventTime; }
        public String getEventType() { return eventType; }
        public void setEventType(String eventType) { this.eventType = eventType; }
        public String getEventTitle() { return eventTitle; }
        public void setEventTitle(String eventTitle) { this.eventTitle = eventTitle; }
        public String getEventDesc() { return eventDesc; }
        public void setEventDesc(String eventDesc) { this.eventDesc = eventDesc; }
        public Date getCreateDate() { return createDate; }
        public void setCreateDate(Date createDate) { this.createDate = createDate; }
    }
    
    // ... RecoverySystemInfo, BusinessCheckInfo, StatInfo는 변경 없음 (기존 코드 유지) ...
    public static class RecoverySystemInfo {
        private Integer systemId;
        private Integer drillId;
        private String systemName;
        private String systemGroup;
        private Integer recoveryOrder;
        private String status;
        private Date startTime;
        private Date endTime;
        private String assignUser;
        private String remark;
        // Getters and Setters 생략 (기존과 동일)
        public Integer getSystemId() { return systemId; }
        public void setSystemId(Integer systemId) { this.systemId = systemId; }
        public Integer getDrillId() { return drillId; }
        public void setDrillId(Integer drillId) { this.drillId = drillId; }
        public String getSystemName() { return systemName; }
        public void setSystemName(String systemName) { this.systemName = systemName; }
        public String getSystemGroup() { return systemGroup; }
        public void setSystemGroup(String systemGroup) { this.systemGroup = systemGroup; }
        public Integer getRecoveryOrder() { return recoveryOrder; }
        public void setRecoveryOrder(Integer recoveryOrder) { this.recoveryOrder = recoveryOrder; }
        public String getStatus() { return status; }
        public void setStatus(String status) { this.status = status; }
        public Date getStartTime() { return startTime; }
        public void setStartTime(Date startTime) { this.startTime = startTime; }
        public Date getEndTime() { return endTime; }
        public void setEndTime(Date endTime) { this.endTime = endTime; }
        public String getAssignUser() { return assignUser; }
        public void setAssignUser(String assignUser) { this.assignUser = assignUser; }
        public String getRemark() { return remark; }
        public void setRemark(String remark) { this.remark = remark; }
    }
    
    public static class BusinessCheckInfo {
        private Integer checkId;
        private Integer drillId;
        private String checkName;
        private String checkGroup;
        private Integer checkOrder;
        private String checkType;
        private String status;
        private Date checkTime;
        private String assignUser;
        private String remark;
        // Getters and Setters 생략
        public Integer getCheckId() { return checkId; }
        public void setCheckId(Integer checkId) { this.checkId = checkId; }
        public Integer getDrillId() { return drillId; }
        public void setDrillId(Integer drillId) { this.drillId = drillId; }
        public String getCheckName() { return checkName; }
        public void setCheckName(String checkName) { this.checkName = checkName; }
        public String getCheckGroup() { return checkGroup; }
        public void setCheckGroup(String checkGroup) { this.checkGroup = checkGroup; }
        public Integer getCheckOrder() { return checkOrder; }
        public void setCheckOrder(Integer checkOrder) { this.checkOrder = checkOrder; }
        public String getCheckType() { return checkType; }
        public void setCheckType(String checkType) { this.checkType = checkType; }
        public String getStatus() { return status; }
        public void setStatus(String status) { this.status = status; }
        public Date getCheckTime() { return checkTime; }
        public void setCheckTime(Date checkTime) { this.checkTime = checkTime; }
        public String getAssignUser() { return assignUser; }
        public void setAssignUser(String assignUser) { this.assignUser = assignUser; }
        public String getRemark() { return remark; }
        public void setRemark(String remark) { this.remark = remark; }
    }
    
    public static class StatInfo {
        private int total;
        private int completed;
        private int inProgress;
        private int waiting;
        private int failed;
        private double progressRate;
        // Getters and Setters 생략
        public int getTotal() { return total; }
        public void setTotal(int total) { this.total = total; }
        public int getCompleted() { return completed; }
        public void setCompleted(int completed) { this.completed = completed; }
        public int getInProgress() { return inProgress; }
        public void setInProgress(int inProgress) { this.inProgress = inProgress; }
        public int getWaiting() { return waiting; }
        public void setWaiting(int waiting) { this.waiting = waiting; }
        public int getFailed() { return failed; }
        public void setFailed(int failed) { this.failed = failed; }
        public double getProgressRate() { return progressRate; }
        public void setProgressRate(double progressRate) { this.progressRate = progressRate; }
    }
}