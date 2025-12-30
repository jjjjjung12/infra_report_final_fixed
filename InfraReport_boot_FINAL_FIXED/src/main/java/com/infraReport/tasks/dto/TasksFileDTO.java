package com.infraReport.tasks.dto;

import java.sql.Timestamp;

public class TasksFileDTO {
	
	private int idx;            
    private int tasksIdx;       
    private String tasksStage;   
    private String filePath;    
    private String fileName;    
    private String orgFileName; 
    private Timestamp createdDate;
    private String createdBy;
    
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public int getTasksIdx() {
		return tasksIdx;
	}
	public void setTasksIdx(int tasksIdx) {
		this.tasksIdx = tasksIdx;
	}
	public String getTasksStage() {
		return tasksStage;
	}
	public void setTasksStage(String tasksStage) {
		this.tasksStage = tasksStage;
	}
	public String getFilePath() {
		return filePath;
	}
	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	public String getOrgFileName() {
		return orgFileName;
	}
	public void setOrgFileName(String orgFileName) {
		this.orgFileName = orgFileName;
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
}
