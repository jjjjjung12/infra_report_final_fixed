package com.infraReport.report.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.infraReport.report.dto.CommonCodeDTO;
import com.infraReport.report.dto.DailyReportStatDTO;

@Repository("reportDao")
public interface ReportDAO {
	
	/*
	 * 업무 유형 별 통계 조회
	 * */
	DailyReportStatDTO selectDailyReportStats();
	
	/*
	 * 공통 코드 조회
	 * */
	List<CommonCodeDTO> selectCodeListByType(String cdType);
}
