package com.infraReport.hwsw.service;

import java.util.HashMap;
import java.util.List;

import com.infraReport.hwsw.dto.HwswDTO;

public interface HwswService {
	
	/*
	 * HW/SW 점검 결과 조회
	 * */
	List<HwswDTO> getHwswCheckList(HashMap<String, Object> param);
	
	/*
	 * HW/SW 점검 결과 등록
	 * */
	boolean addHwswCheck(HwswDTO dto);
	
	/*
	 * HW/SW 점검 결과 상세 조회
	 * */
	HwswDTO getHwswCheckById(int reportId);

	/*
	 * HW/SW 점검 결과 수정
	 * */
	boolean updateHwswCheck(HwswDTO dto);
	
	/*
	 * HW/SW 점검 결과 삭제
	 * */
	boolean deleteHwswCheck(int reportId);
	
}
