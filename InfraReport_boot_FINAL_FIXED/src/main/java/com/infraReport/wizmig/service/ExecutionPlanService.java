package com.infraReport.wizmig.service;

import com.infraReport.wizmig.dto.ExecutionPlanDTO;
import com.infraReport.wizmig.dto.ExecutionStepDTO;

import java.util.List;

/**
 * 실행 계획 서비스 인터페이스
 */
public interface ExecutionPlanService {
    
    List<ExecutionPlanDTO> getExecutionPlanList(String sessionName);
    
    ExecutionPlanDTO getExecutionPlan(Long planId);
    
    // [!!!추가됨!!!] 이 부분이 없어서 "undefined" 에러가 났던 것입니다.
    List<ExecutionStepDTO> getExecutionSteps(Long planId); 
    
    Long createExecutionPlan(ExecutionPlanDTO plan);
    
    void updateExecutionPlan(ExecutionPlanDTO plan);
    
    void deleteExecutionPlan(Long planId);
    
    void addExecutionStep(ExecutionStepDTO step);
    
    void updateExecutionStep(ExecutionStepDTO step);
    
    void deleteExecutionStep(Long stepId);
    
    void reorderExecutionSteps(Long planId, List<Long> stepIds);
    
    void startExecutionPlan(Long planId);
    
    void stopExecutionPlan(Long planId);
    
    String getExecutionPlanStatus(Long planId);
    
    // 개별 단계 조회용 메서드도 필요시 사용 (Controller에서 호출함)
    ExecutionStepDTO getExecutionStep(Long stepId); 
}