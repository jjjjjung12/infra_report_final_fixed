package com.infraReport.hwsw.service.impl;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.infraReport.hwsw.dao.HwswDAO;
import com.infraReport.hwsw.dto.HwswDTO;
import com.infraReport.hwsw.service.HwswService;

@Service("hwswService")
public class HwswServiceImpl implements HwswService {
	
	@Resource(name="hwswDao")
	private HwswDAO hwswDao;

    /*
     * HW/SW 점검 결과 조회
     * */
    @Override
    public List<HwswDTO> getHwswCheckList(HashMap<String, Object> param) {
        return hwswDao.selectHwswCheckList(param);
    }
    
    /*
     * HW/SW 점검 결과 등록
     * */
    @Override
    public boolean addHwswCheck(HwswDTO dto) {
        int rows = hwswDao.insertHwswCheck(dto);
        return rows > 0;
    }
    
    /*
     * HW/SW 점검 결과 상세 조회 
     * */
    @Override
    public HwswDTO getHwswCheckById(int reportId) {
    	return hwswDao.selectHwswCheckById(reportId);
    }

    /*
     * HW/SW 점검 결과 수정
     * */
    @Override
    public boolean updateHwswCheck(HwswDTO dto) {
        int rows = hwswDao.updateHwswCheck(dto);
        return rows > 0;
    }
    
    /*
     * HW/SW 점검 결과 삭제
     * */
    @Override
    public boolean deleteHwswCheck(int reportId) {
    	int rows = hwswDao.deleteHwswCheck(reportId);
    	return rows > 0;
    }

}
