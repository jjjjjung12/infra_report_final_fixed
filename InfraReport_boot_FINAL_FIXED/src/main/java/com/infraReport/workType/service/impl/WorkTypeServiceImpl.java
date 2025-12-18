package com.infraReport.workType.service.impl;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.infraReport.workType.dao.WorkTypeDAO;
import com.infraReport.workType.dto.WorkTypeDTO;
import com.infraReport.workType.service.WorkTypeService;

@Service("workTypeService")
public class WorkTypeServiceImpl implements WorkTypeService {

    @Resource(name="workTypeDao")
	private WorkTypeDAO workTypeDao;

    /*
     * 업무 목록 조회
     * */
    @Override
    public List<WorkTypeDTO> getReportList(HashMap<String, Object> param) {
        return workTypeDao.selectReportList(param);
    }
    
    /*
     * 업무 등록
     * */
    @Override
    public boolean addDailyReport(WorkTypeDTO dto) {
        int rows = workTypeDao.insertDailyReport(dto);
        return rows > 0;
    }
    
    /*
     * 업무 상세 조회 
     * */
    @Override
    public WorkTypeDTO getDailyReportById(int reportId) {
    	return workTypeDao.selectDailyReportById(reportId);
    }

    /*
     * 업무 수정
     * */
    @Override
    public boolean updateDailyReport(WorkTypeDTO dto) {
        int rows = workTypeDao.updateDailyReport(dto);
        return rows > 0;
    }
    
    /*
     * 업무 삭제
     * */
    @Override
    public boolean deleteDailyReport(int reportId) {
    	int rows = workTypeDao.deleteDailyReport(reportId);
    	return rows > 0;
    }
    
}
