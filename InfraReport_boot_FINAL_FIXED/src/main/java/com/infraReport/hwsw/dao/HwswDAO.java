package com.infraReport.hwsw.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.stereotype.Repository;

import com.infraReport.hwsw.dto.HwswDTO;

@Repository("hwswDao")
public interface HwswDAO {
	
	/*
	 * HW/SW 점검 결과 조회
	 * */
	List<HwswDTO> selectHwswCheckList(HashMap<String, Object> param);
	
	/*
	 * HW/SW 점검 결과 등록
	 * */
	int insertHwswCheck(HwswDTO dto);
	
	/*
	 * HW/SW 점검 결과 상세 조회 
	 * */
	HwswDTO selectHwswCheckById(int reportId);

	/*
	 * HW/SW 점검 결과 수정
	 * */
	int updateHwswCheck(HwswDTO dto);
	
	/*
	 * HW/SW 점검 결과 삭제
	 * */
	int deleteHwswCheck(int reportId);
    
}
