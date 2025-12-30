package com.infraReport.tasks.service;

import java.util.HashMap;
import java.util.List;

import com.infraReport.tasks.dto.TasksDTO;
import com.infraReport.tasks.dto.TasksFileDTO;

public interface TasksService {
	
	/*
	 * 작업 조회
	 * */
	List<TasksDTO> getTasksInfoAllList();
	
	/*
	 * 작업 파일 조회
	 * */
	List<TasksFileDTO> getTasksFileUploadAllList();
	
	/*
	 * 의뢰서 등록
	 * */
	int addTasksRequest(TasksDTO dto);
	
	/*
	 * 작업 파일 등록
	 * */
	boolean addTasksFileUpload(TasksFileDTO dto);
	
	/*
	 * 작업 수정
	 * */
	boolean updateTasks(TasksDTO dto);
	
	/*
	 * 파일 조회
	 * */
	TasksFileDTO getTasksFileByIdx(int idx);

	/*
	 * 파일 삭제
	 * */
	boolean deleteFile(int idx);

	/*
	 * 단계별 승인
	 * */
	boolean updateApproved(HashMap<String, Object> param);
}