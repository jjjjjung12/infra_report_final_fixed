package com.infraReport.tasks.service.impl;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.infraReport.tasks.dao.TasksDAO;
import com.infraReport.tasks.dto.TasksDTO;
import com.infraReport.tasks.dto.TasksFileDTO;
import com.infraReport.tasks.service.TasksService;

@Service("tasksService")
public class TasksServiceImpl implements TasksService {
	
	@Resource(name="tasksDao")
	private TasksDAO tasksDao;
	
	/*
     * 작업 조회
     * */
    @Override
    public List<TasksDTO> getTasksInfoAllList() {
        return tasksDao.selectTasksInfoAllList();
    }
    
    /*
     * 작업 파일 조회
     * */
    @Override
    public List<TasksFileDTO> getTasksFileUploadAllList() {
        return tasksDao.selectTasksFileUploadAllList();
    }

	/*
     * 의뢰서 등록
     * */
    @Override
    public int addTasksRequest(TasksDTO dto) {
    	tasksDao.insertTasksRequest(dto);
        return dto.getIdx();
    }
    
    /*
     * 작업 파일 등록
     * */
    @Override
    public boolean addTasksFileUpload(TasksFileDTO dto) {
    	int rows = tasksDao.insertTasksFileUpload(dto);
    	return rows > 0;
    }
    
    /*
	 * 작업 수정
	 * */
    @Override
    public boolean updateTasks(TasksDTO dto) {
    	int rows = tasksDao.updateTasks(dto);
    	return rows > 0;
    }
    
    /*
     * 파일 조회
     * */
    @Override
    public TasksFileDTO getTasksFileByIdx(int idx) {
        return tasksDao.selectTasksFileByIdx(idx);
    }

    /*
	 * 파일 삭제
	 * */
    @Override
    public boolean deleteFile(int idx) {
    	int rows = tasksDao.deleteFile(idx);
    	return rows > 0;
    }

    /*
	 * 단계별 승인
	 * */
    @Override
    public boolean updateApproved(HashMap<String, Object> param) {
    	int rows = tasksDao.updateApproved(param);
    	return rows > 0;
    }
}