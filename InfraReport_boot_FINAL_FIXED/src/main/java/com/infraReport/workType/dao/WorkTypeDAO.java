package com.infraReport.workType.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.stereotype.Repository;

import com.infraReport.workType.dto.WorkTypeDTO;

@Repository("workTypeDao")
public interface WorkTypeDAO {
	
	/*
	 * 업무 목록 조회
	 * */
	List<WorkTypeDTO> selectReportList(HashMap<String, Object> param);
	
	/*
	 * 업무 등록
	 * */
	int insertDailyReport(WorkTypeDTO dto);
	
	/*
	 * 업무 상세 조회 
	 * */
	WorkTypeDTO selectDailyReportById(int reportId);

	/*
	 * 업무 수정
	 * */
	int updateDailyReport(WorkTypeDTO dto);
	
	/*
	 * 업무 삭제
	 * */
	int deleteDailyReport(int reportId);
	
}
