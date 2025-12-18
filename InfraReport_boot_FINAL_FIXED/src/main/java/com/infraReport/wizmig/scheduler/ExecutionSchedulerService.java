package com.infraReport.wizmig.scheduler;

import com.infraReport.wizmig.dto.ExecutionPlanDTO;
import com.infraReport.wizmig.dto.ExecutionStepDTO;
import com.infraReport.wizmig.dao.ExecutionPlanDAO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.Duration;
import java.time.LocalDateTime;
import java.util.concurrent.*;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

/**
 * 실행 계획 스케줄러 서비스
 * 스크립트 실행 계획을 순차적으로 실행하고 관리
 */
@Service
public class ExecutionSchedulerService {
    
    private static final Logger logger = LoggerFactory.getLogger(ExecutionSchedulerService.class);
    
    @Autowired
    private ExecutionPlanDAO executionPlanDAO;
    
    @Autowired
    private ScriptExecutionService scriptExecutionService;
    
    // 현재 실행 중인 계획 추적
    private final Map<Long, Future<?>> runningPlans = new ConcurrentHashMap<>();
    private final ExecutorService executorService = Executors.newCachedThreadPool();
    
    /**
     * 실행 계획 시작
     */
    public void startExecutionPlan(Long planId) {
        if (runningPlans.containsKey(planId)) {
            throw new IllegalStateException("실행 계획이 이미 실행 중입니다: " + planId);
        }
        
        Future<?> future = executorService.submit(() -> executeplan(planId));
        runningPlans.put(planId, future);
    }
    
    /**
     * 실행 계획 중지
     */
    public void stopExecutionPlan(Long planId) {
        Future<?> future = runningPlans.get(planId);
        if (future != null) {
            future.cancel(true);
            runningPlans.remove(planId);
            
            // 계획 상태 업데이트
            ExecutionPlanDTO plan = executionPlanDAO.selectExecutionPlan(planId);
            plan.setStatus("PAUSED");
            plan.setUpdatedAt(LocalDateTime.now());
            executionPlanDAO.updateExecutionPlan(plan);
        }
    }
    
    /**
     * 실행 계획 실행
     */
    private void executeplan(Long planId) {
        ExecutionPlanDTO plan = null;
        try {
            plan = executionPlanDAO.selectExecutionPlan(planId);
            if (plan == null) {
                logger.error("실행 계획을 찾을 수 없습니다: {}", planId);
                return;
            }
            
            // 계획 상태를 실행 중으로 변경
            plan.setStatus("RUNNING");
            plan.setStartedAt(LocalDateTime.now());
            plan.setUpdatedAt(LocalDateTime.now());
            executionPlanDAO.updateExecutionPlan(plan);
            
            logger.info("실행 계획 시작: {} ({})", plan.getPlanName(), planId);
            
            // 단계별 실행
            for (ExecutionStepDTO step : plan.getSteps()) {
                if (Thread.currentThread().isInterrupted()) {
                    logger.info("실행 계획 중단됨: {}", planId);
                    break;
                }
                
                executeStep(plan, step);
            }
            
            // 모든 단계 완료 후 계획 상태 업데이트
            boolean allSuccess = plan.getSteps().stream()
                .allMatch(s -> "COMPLETED".equals(s.getStatus()));
            
            plan.setStatus(allSuccess ? "COMPLETED" : "FAILED");
            plan.setCompletedAt(LocalDateTime.now());
            plan.setUpdatedAt(LocalDateTime.now());
            executionPlanDAO.updateExecutionPlan(plan);
            
            logger.info("실행 계획 완료: {} - 상태: {}", plan.getPlanName(), plan.getStatus());
            
        } catch (Exception e) {
            logger.error("실행 계획 실행 중 오류 발생: {}", planId, e);
            if (plan != null) {
                plan.setStatus("FAILED");
                plan.setCompletedAt(LocalDateTime.now());
                plan.setUpdatedAt(LocalDateTime.now());
                executionPlanDAO.updateExecutionPlan(plan);
            }
        } finally {
            runningPlans.remove(planId);
        }
    }
    
    /**
     * 단계 실행
     */
    private void executeStep(ExecutionPlanDTO plan, ExecutionStepDTO step) {
        logger.info("단계 실행 시작: {} - {}", step.getStepOrder(), step.getScriptName());
        
        // 단계 상태를 실행 중으로 변경
        step.setStatus("RUNNING");
        step.setStartedAt(LocalDateTime.now());
        step.setCurrentRetry(0);
        executionPlanDAO.updateExecutionStep(step);
        
        int retryCount = 0;
        int maxRetries = step.getMaxRetries() != null ? step.getMaxRetries() : 0;
        boolean success = false;
        
        while (!success && retryCount <= maxRetries) {
            try {
                if (retryCount > 0) {
                    logger.info("재시도 중: {}/{}", retryCount, maxRetries);
                    step.setCurrentRetry(retryCount);
                    executionPlanDAO.updateExecutionStep(step);
                    Thread.sleep(5000); // 재시도 전 5초 대기
                }
                
                // 타임아웃 설정
                int timeoutMinutes = step.getTimeoutMinutes() != null ? step.getTimeoutMinutes() : 60;
                
                // 스크립트 실행
                ExecutorService executor = Executors.newSingleThreadExecutor();
                Future<Boolean> future = executor.submit(() -> 
                    scriptExecutionService.executeScript(plan.getSessionName(), step)
                );
                
                try {
                    success = future.get(timeoutMinutes, TimeUnit.MINUTES);
                } catch (TimeoutException e) {
                    logger.warn("단계 타임아웃: {} - {} ({}분)", 
                        step.getStepOrder(), step.getScriptName(), timeoutMinutes);
                    future.cancel(true);
                    handleTimeout(step);
                    return;
                } finally {
                    executor.shutdown();
                }
                
                if (success) {
                    step.setStatus("COMPLETED");
                    logger.info("단계 완료: {} - {}", step.getStepOrder(), step.getScriptName());
                } else {
                    throw new Exception("스크립트 실행 실패");
                }
                
            } catch (Exception e) {
                logger.error("단계 실행 중 오류: {} - {}", step.getScriptName(), e.getMessage());
                retryCount++;
                
                if (retryCount > maxRetries) {
                    handleError(step);
                    return;
                }
            }
        }
        
        // 실행 시간 계산
        if (step.getStartedAt() != null) {
            Duration duration = Duration.between(step.getStartedAt(), LocalDateTime.now());
            step.setExecutionTime(duration.getSeconds());
        }
        
        step.setCompletedAt(LocalDateTime.now());
        executionPlanDAO.updateExecutionStep(step);
    }
    
    /**
     * 타임아웃 처리
     */
    private void handleTimeout(ExecutionStepDTO step) {
        String onTimeout = step.getOnTimeout() != null ? step.getOnTimeout() : "FAIL";
        
        switch (onTimeout) {
            case "SKIP":
                step.setStatus("SKIPPED");
                step.setResult("타임아웃으로 인한 스킵");
                logger.info("타임아웃 - 다음 단계로 진행: {}", step.getScriptName());
                break;
            case "CONTINUE":
                step.setStatus("TIMEOUT");
                step.setResult("타임아웃 발생 (계속 진행)");
                logger.warn("타임아웃 - 계속 진행: {}", step.getScriptName());
                break;
            case "FAIL":
            default:
                step.setStatus("FAILED");
                step.setResult("타임아웃으로 인한 실패");
                logger.error("타임아웃 - 실행 중단: {}", step.getScriptName());
                throw new RuntimeException("타임아웃으로 인한 실행 중단");
        }
        
        step.setCompletedAt(LocalDateTime.now());
        executionPlanDAO.updateExecutionStep(step);
    }
    
    /**
     * 에러 처리
     */
    private void handleError(ExecutionStepDTO step) {
        String onError = step.getOnError() != null ? step.getOnError() : "FAIL";
        
        switch (onError) {
            case "SKIP":
                step.setStatus("SKIPPED");
                step.setResult("에러로 인한 스킵");
                logger.info("에러 발생 - 다음 단계로 진행: {}", step.getScriptName());
                break;
            case "CONTINUE":
                step.setStatus("FAILED");
                step.setResult("에러 발생 (계속 진행)");
                logger.warn("에러 발생 - 계속 진행: {}", step.getScriptName());
                break;
            case "FAIL":
            default:
                step.setStatus("FAILED");
                step.setResult("에러로 인한 실패");
                logger.error("에러 발생 - 실행 중단: {}", step.getScriptName());
                throw new RuntimeException("에러로 인한 실행 중단");
        }
        
        step.setCompletedAt(LocalDateTime.now());
        executionPlanDAO.updateExecutionStep(step);
    }
    
    /**
     * 실행 중인 계획 확인
     */
    public boolean isRunning(Long planId) {
        return runningPlans.containsKey(planId);
    }
    
    /**
     * 서비스 종료
     */
    public void shutdown() {
        executorService.shutdownNow();
    }
}
