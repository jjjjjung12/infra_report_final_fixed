package com.infraReport.wizmig.service.impl;

import com.infraReport.wizmig.dao.ExecutionPlanDAO;
import com.infraReport.wizmig.dto.ExecutionPlanDTO;
import com.infraReport.wizmig.dto.ExecutionStepDTO;
import com.infraReport.wizmig.scheduler.ExecutionSchedulerService;
import com.infraReport.wizmig.service.ExecutionPlanService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;

@Service
public class ExecutionPlanServiceImpl implements ExecutionPlanService {
    
    @Autowired
    private ExecutionPlanDAO executionPlanDAO;
    
    @Autowired
    private ExecutionSchedulerService executionSchedulerService;
    
    @Override
    public List<ExecutionPlanDTO> getExecutionPlanList(String sessionName) {
        return executionPlanDAO.selectExecutionPlanList(sessionName);
    }
    
    @Override
    public ExecutionPlanDTO getExecutionPlan(Long planId) {
        ExecutionPlanDTO plan = executionPlanDAO.selectExecutionPlan(planId);
        if (plan != null) {
            List<ExecutionStepDTO> steps = executionPlanDAO.selectExecutionSteps(planId);
            plan.setSteps(steps);
        }
        return plan;
    }
    
    @Override
    public List<ExecutionStepDTO> getExecutionSteps(Long planId) {
        return executionPlanDAO.selectExecutionSteps(planId);
    }
    
    // [!!! 정상 작동 !!!] 이제 DAO에 메서드가 있어서 에러가 나지 않습니다.
    @Override
    public ExecutionStepDTO getExecutionStep(Long stepId) {
        return executionPlanDAO.selectExecutionStep(stepId);
    }
    
    @Override
    @Transactional
    public Long createExecutionPlan(ExecutionPlanDTO plan) {
        plan.setStatus("READY");
        plan.setCreatedAt(LocalDateTime.now());
        plan.setUpdatedAt(LocalDateTime.now());
        executionPlanDAO.insertExecutionPlan(plan);
        
        if (plan.getSteps() != null && !plan.getSteps().isEmpty()) {
            int order = 1;
            for (ExecutionStepDTO step : plan.getSteps()) {
                step.setPlanId(plan.getPlanId());
                step.setStepOrder(order++);
                step.setStatus("PENDING");
                executionPlanDAO.insertExecutionStep(step);
            }
        }
        
        return plan.getPlanId();
    }
    
    @Override
    @Transactional
    public void updateExecutionPlan(ExecutionPlanDTO plan) {
        plan.setUpdatedAt(LocalDateTime.now());
        executionPlanDAO.updateExecutionPlan(plan);
    }
    
    @Override
    @Transactional
    public void deleteExecutionPlan(Long planId) {
        if (executionSchedulerService.isRunning(planId)) {
            throw new IllegalStateException("실행 중인 계획은 삭제할 수 없습니다.");
        }
        
        executionPlanDAO.deleteExecutionStepsByPlanId(planId);
        executionPlanDAO.deleteExecutionPlan(planId);
    }
    
    @Override
    @Transactional
    public void addExecutionStep(ExecutionStepDTO step) {
        step.setStatus("PENDING");
        executionPlanDAO.insertExecutionStep(step);
    }
    
    @Override
    @Transactional
    public void updateExecutionStep(ExecutionStepDTO step) {
        executionPlanDAO.updateExecutionStep(step);
    }
    
    @Override
    @Transactional
    public void deleteExecutionStep(Long stepId) {
        executionPlanDAO.deleteExecutionStep(stepId);
    }
    
    @Override
    @Transactional
    public void reorderExecutionSteps(Long planId, List<Long> stepIds) {
        int order = 1;
        for (Long stepId : stepIds) {
            ExecutionStepDTO step = new ExecutionStepDTO();
            step.setStepId(stepId);
            step.setStepOrder(order++);
            executionPlanDAO.updateExecutionStep(step);
        }
    }
    
    @Override
    public void startExecutionPlan(Long planId) {
        ExecutionPlanDTO plan = getExecutionPlan(planId);
        
        if (plan == null) {
            throw new IllegalArgumentException("실행 계획을 찾을 수 없습니다: " + planId);
        }
        
        if (!"READY".equals(plan.getStatus()) && !"PAUSED".equals(plan.getStatus())) {
            throw new IllegalStateException("실행할 수 없는 상태입니다: " + plan.getStatus());
        }
        
        executionSchedulerService.startExecutionPlan(planId);
    }
    
    @Override
    public void stopExecutionPlan(Long planId) {
        executionSchedulerService.stopExecutionPlan(planId);
    }
    
    @Override
    public String getExecutionPlanStatus(Long planId) {
        ExecutionPlanDTO plan = executionPlanDAO.selectExecutionPlan(planId);
        return plan != null ? plan.getStatus() : null;
    }
}