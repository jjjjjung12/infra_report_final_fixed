package com.infraReport.wizmig.dao;

import com.infraReport.wizmig.dto.ExecutionPlanDTO;
import com.infraReport.wizmig.dto.ExecutionStepDTO;
import org.apache.ibatis.annotations.Mapper;
import java.util.List;

@Mapper
public interface ExecutionPlanDAO {
    
    List<ExecutionPlanDTO> selectExecutionPlanList(String sessionName);
    
    ExecutionPlanDTO selectExecutionPlan(Long planId);
    
    void insertExecutionPlan(ExecutionPlanDTO plan);
    
    void updateExecutionPlan(ExecutionPlanDTO plan);
    
    void deleteExecutionPlan(Long planId);
    
    // 실행 계획에 포함된 단계 목록 조회
    List<ExecutionStepDTO> selectExecutionSteps(Long planId); 
    
    // [!!! 추가된 부분 !!!] 단일 단계 조회 (이게 없어서 에러가 났습니다)
    ExecutionStepDTO selectExecutionStep(Long stepId); 

    void insertExecutionStep(ExecutionStepDTO step);
    
    void updateExecutionStep(ExecutionStepDTO step);
    
    void deleteExecutionStep(Long stepId);
    
    void deleteExecutionStepsByPlanId(Long planId);
}