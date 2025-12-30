package com.infraReport.tasks.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.stereotype.Repository;

import com.infraReport.tasks.dto.TasksDTO;
import com.infraReport.tasks.dto.TasksFileDTO;

@Repository("tasksDao")
public interface TasksDAO {
	
	/*
	 * 작업 조회
	 * */
	List<TasksDTO> selectTasksInfoAllList();
	
	/*
	 * 작업 파일 조회
	 * */
	List<TasksFileDTO> selectTasksFileUploadAllList();
	
	/*
	 * 의뢰서 등록
	 * */
	int insertTasksRequest(TasksDTO dto);
	
	/*
	 * 작업파일 등록
	 * */
	int insertTasksFileUpload(TasksFileDTO dto);
	
	/*
	 * 작업 수정
	 * */
	int updateTasks(TasksDTO dto);

	/*
	 * 파일 조회
	 * */
	TasksFileDTO selectTasksFileByIdx(int idx);

	/*
	 * 파일 삭제
	 * */
	int deleteFile(int idx);

	/*
	 * 단계별 승인
	 * */
	int updateApproved(HashMap<String, Object> param);
    
}