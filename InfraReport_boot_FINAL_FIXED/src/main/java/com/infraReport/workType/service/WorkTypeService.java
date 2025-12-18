package com.infraReport.workType.service;

import java.util.HashMap;
import java.util.List;

import com.infraReport.workType.dto.WorkTypeDTO;

public interface WorkTypeService {
	
	/*
	 * 업무 목록 조회
	 * */
	List<WorkTypeDTO> getReportList(HashMap<String, Object> param);
	
	/*
	 * 업무 등록
	 * */
	boolean addDailyReport(WorkTypeDTO dto);
	
	/*
	 * 업무 상세 조회
	 * */
	WorkTypeDTO getDailyReportById(int reportId);

	/*
	 * 업무 수정
	 * */
	boolean updateDailyReport(WorkTypeDTO dto);
	
	/*
	 * 업무 삭제
	 * */
	boolean deleteDailyReport(int reportId);
	
}
