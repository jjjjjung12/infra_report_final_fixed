package com.infraReport.tasks.dto;

import java.sql.Timestamp;

public class TasksDTO {
	
	private int idx;
    private String tasksName;
    private Timestamp requestDate;
    private Timestamp requestApprovedDate;
    private String requestStatus;
    private Timestamp planRequestDate;
    private Timestamp planApprovedDate;
    private Timestamp planStartDate;
    private Timestamp planEndDate;
    private String planStatus;
    private Timestamp resultRequestDate;
    private Timestamp resultApprovedDate;
    private String resultStatus;
    private Timestamp createdDate;
    private String createdBy;
    private Timestamp updatedDate;
    private String updatedBy;
    
    private String tasksStage;
    private String taskStatus;
    
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public String getTasksName() {
		return tasksName;
	}
	public void setTasksName(String tasksName) {
		this.tasksName = tasksName;
	}
	public Timestamp getRequestDate() {
		return requestDate;
	}
	public void setRequestDate(Timestamp requestDate) {
		this.requestDate = requestDate;
	}
	public Timestamp getRequestApprovedDate() {
		return requestApprovedDate;
	}
	public void setRequestApprovedDate(Timestamp requestApprovedDate) {
		this.requestApprovedDate = requestApprovedDate;
	}
	public String getRequestStatus() {
		return requestStatus;
	}
	public void setRequestStatus(String requestStatus) {
		this.requestStatus = requestStatus;
	}
	public Timestamp getPlanRequestDate() {
		return planRequestDate;
	}
	public void setPlanRequestDate(Timestamp planRequestDate) {
		this.planRequestDate = planRequestDate;
	}
	public Timestamp getPlanApprovedDate() {
		return planApprovedDate;
	}
	public void setPlanApprovedDate(Timestamp planApprovedDate) {
		this.planApprovedDate = planApprovedDate;
	}
	public Timestamp getPlanStartDate() {
		return planStartDate;
	}
	public void setPlanStartDate(Timestamp planStartDate) {
		this.planStartDate = planStartDate;
	}
	public Timestamp getPlanEndDate() {
		return planEndDate;
	}
	public void setPlanEndDate(Timestamp planEndDate) {
		this.planEndDate = planEndDate;
	}
	public String getPlanStatus() {
		return planStatus;
	}
	public void setPlanStatus(String planStatus) {
		this.planStatus = planStatus;
	}
	public Timestamp getResultRequestDate() {
		return resultRequestDate;
	}
	public void setResultRequestDate(Timestamp resultRequestDate) {
		this.resultRequestDate = resultRequestDate;
	}
	public Timestamp getResultApprovedDate() {
		return resultApprovedDate;
	}
	public void setResultApprovedDate(Timestamp resultApprovedDate) {
		this.resultApprovedDate = resultApprovedDate;
	}
	public String getResultStatus() {
		return resultStatus;
	}
	public void setResultStatus(String resultStatus) {
		this.resultStatus = resultStatus;
	}
	public Timestamp getCreatedDate() {
		return createdDate;
	}
	public void setCreatedDate(Timestamp createdDate) {
		this.createdDate = createdDate;
	}
	public String getCreatedBy() {
		return createdBy;
	}
	public void setCreatedBy(String createdBy) {
		this.createdBy = createdBy;
	}
	public Timestamp getUpdatedDate() {
		return updatedDate;
	}
	public void setUpdatedDate(Timestamp updatedDate) {
		this.updatedDate = updatedDate;
	}
	public String getUpdatedBy() {
		return updatedBy;
	}
	public void setUpdatedBy(String updatedBy) {
		this.updatedBy = updatedBy;
	}
	
	public String getTasksStage() {
		return tasksStage;
	}
	public void setTasksStage(String tasksStage) {
		this.tasksStage = tasksStage;
	}
	
	public String getTaskStatus() {
		return taskStatus;
	}
	public void setTaskStatus(String taskStatus) {
		this.taskStatus = taskStatus;
	}
}
