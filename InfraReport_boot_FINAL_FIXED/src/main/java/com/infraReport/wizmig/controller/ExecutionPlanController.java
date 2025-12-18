package com.infraReport.wizmig.controller;

import com.infraReport.wizmig.dto.ExecutionPlanDTO;
import com.infraReport.wizmig.dto.ExecutionStepDTO;
import com.infraReport.wizmig.model.ConnectionInfo;
import com.infraReport.wizmig.model.ConnectionManager;
import com.infraReport.wizmig.model.ShellScriptManager;
import com.infraReport.wizmig.service.ExecutionPlanService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 실행 계획 컨트롤러
 */
@Controller
@RequestMapping("/wizmig/execution-plan")
public class ExecutionPlanController {
    
    @Autowired
    private ExecutionPlanService executionPlanService;
    
    /**
     * 실행 계획 목록 페이지
     */
    @GetMapping("/list")
    public String executionPlanList(
            @RequestParam(required = false) String sessionName,
            Model model) {
        List<ExecutionPlanDTO> plans = executionPlanService.getExecutionPlanList(sessionName);
        model.addAttribute("plans", plans);
        model.addAttribute("sessionName", sessionName);
        return "wizmig/executionPlanList";
    }
    
    /**
     * 실행 계획 상세 페이지
     */
    @GetMapping("/{planId}")
    public String executionPlanDetail(
            @PathVariable Long planId,
            Model model) {
        ExecutionPlanDTO plan = executionPlanService.getExecutionPlan(planId);
        // [수정완료] Service 인터페이스에 메서드가 추가되어 에러가 사라집니다.
        List<ExecutionStepDTO> steps = executionPlanService.getExecutionSteps(planId);
        model.addAttribute("plan", plan);
        model.addAttribute("steps", steps);
        return "wizmig/executionPlanDetail";
    }
    
    /**
     * 실행 계획 생성 페이지
     */
    @GetMapping("/create")
    public String createExecutionPlanForm(
            @RequestParam(required = false) String sessionName,
            Model model) {
        model.addAttribute("sessionName", sessionName);
        return "wizmig/executionPlanForm";
    }
    
    /**
     * 실행 계획 수정 페이지
     */
    @GetMapping("/{planId}/edit")
    public String editExecutionPlanForm(
            @PathVariable Long planId,
            Model model) {
        ExecutionPlanDTO plan = executionPlanService.getExecutionPlan(planId);
        model.addAttribute("plan", plan);
        return "wizmig/executionPlanForm";
    }
    
    // --- API 메서드 ---
    
    @PostMapping("/api/create")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> createExecutionPlan(
            @RequestBody ExecutionPlanDTO plan) {
        Map<String, Object> result = new HashMap<>();
        try {
            Long planId = executionPlanService.createExecutionPlan(plan);
            result.put("success", true);
            result.put("planId", planId);
            result.put("message", "실행 계획이 생성되었습니다.");
            return ResponseEntity.ok(result);
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", "실행 계획 생성 중 오류가 발생했습니다: " + e.getMessage());
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(result);
        }
    }
    
    @PutMapping("/api/{planId}")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> updateExecutionPlan(
            @PathVariable Long planId,
            @RequestBody ExecutionPlanDTO plan) {
        Map<String, Object> result = new HashMap<>();
        try {
            plan.setPlanId(planId);
            executionPlanService.updateExecutionPlan(plan);
            result.put("success", true);
            result.put("message", "실행 계획이 수정되었습니다.");
            return ResponseEntity.ok(result);
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", "실행 계획 수정 중 오류가 발생했습니다: " + e.getMessage());
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(result);
        }
    }
    
    @DeleteMapping("/api/{planId}")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> deleteExecutionPlan(
            @PathVariable Long planId) {
        Map<String, Object> result = new HashMap<>();
        try {
            executionPlanService.deleteExecutionPlan(planId);
            result.put("success", true);
            result.put("message", "실행 계획이 삭제되었습니다.");
            return ResponseEntity.ok(result);
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", "실행 계획 삭제 중 오류가 발생했습니다: " + e.getMessage());
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(result);
        }
    }
    
    @PostMapping("/api/{planId}/steps")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> addExecutionStep(
            @PathVariable Long planId,
            @RequestBody ExecutionStepDTO step) {
        Map<String, Object> result = new HashMap<>();
        try {
            step.setPlanId(planId);
            executionPlanService.addExecutionStep(step);
            result.put("success", true);
            result.put("message", "실행 단계가 추가되었습니다.");
            return ResponseEntity.ok(result);
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", "실행 단계 추가 중 오류가 발생했습니다: " + e.getMessage());
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(result);
        }
    }
    
    @PutMapping("/api/steps/{stepId}")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> updateExecutionStep(
            @PathVariable Long stepId,
            @RequestBody ExecutionStepDTO step) {
        Map<String, Object> result = new HashMap<>();
        try {
            step.setStepId(stepId);
            executionPlanService.updateExecutionStep(step);
            result.put("success", true);
            result.put("message", "실행 단계가 수정되었습니다.");
            return ResponseEntity.ok(result);
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", "실행 단계 수정 중 오류가 발생했습니다: " + e.getMessage());
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(result);
        }
    }
    
    @DeleteMapping("/api/steps/{stepId}")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> deleteExecutionStep(
            @PathVariable Long stepId) {
        Map<String, Object> result = new HashMap<>();
        try {
            executionPlanService.deleteExecutionStep(stepId);
            result.put("success", true);
            result.put("message", "실행 단계가 삭제되었습니다.");
            return ResponseEntity.ok(result);
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", "실행 단계 삭제 중 오류가 발생했습니다: " + e.getMessage());
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(result);
        }
    }
    
    @PutMapping("/api/{planId}/steps/reorder")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> reorderExecutionSteps(
            @PathVariable Long planId,
            @RequestBody List<Long> stepIds) {
        Map<String, Object> result = new HashMap<>();
        try {
            executionPlanService.reorderExecutionSteps(planId, stepIds);
            result.put("success", true);
            result.put("message", "실행 순서가 변경되었습니다.");
            return ResponseEntity.ok(result);
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", "실행 순서 변경 중 오류가 발생했습니다: " + e.getMessage());
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(result);
        }
    }
    
    @PostMapping("/api/{planId}/start")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> startExecutionPlan(
            @PathVariable Long planId) {
        Map<String, Object> result = new HashMap<>();
        try {
            executionPlanService.startExecutionPlan(planId);
            result.put("success", true);
            result.put("message", "실행 계획이 시작되었습니다.");
            return ResponseEntity.ok(result);
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", "실행 계획 시작 중 오류가 발생했습니다: " + e.getMessage());
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(result);
        }
    }
    
    @PostMapping("/api/{planId}/stop")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> stopExecutionPlan(
            @PathVariable Long planId) {
        Map<String, Object> result = new HashMap<>();
        try {
            executionPlanService.stopExecutionPlan(planId);
            result.put("success", true);
            result.put("message", "실행 계획이 중지되었습니다.");
            return ResponseEntity.ok(result);
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", "실행 계획 중지 중 오류가 발생했습니다: " + e.getMessage());
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(result);
        }
    }
    
    @GetMapping("/api/{planId}/status")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> getExecutionPlanStatus(
            @PathVariable Long planId) {
        Map<String, Object> result = new HashMap<>();
        try {
            ExecutionPlanDTO plan = executionPlanService.getExecutionPlan(planId);
            result.put("success", true);
            result.put("status", plan.getStatus());
            result.put("plan", plan);
            return ResponseEntity.ok(result);
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", "상태 조회 중 오류가 발생했습니다: " + e.getMessage());
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(result);
        }
    }
    
    @GetMapping("/api/log")
    @ResponseBody
    public Map<String, Object> getStepLog(
            @RequestParam Long stepId,
            @RequestParam String logPath) {
        try {
            ExecutionStepDTO step = executionPlanService.getExecutionStep(stepId);
            if (step == null) {
                return Map.of("success", false, "message", "단계를 찾을 수 없습니다.");
            }
            
            ExecutionPlanDTO plan = executionPlanService.getExecutionPlan(step.getPlanId());
            ConnectionInfo connection = ConnectionManager.getConnection(plan.getSessionName());
            
            if (connection == null) {
                return Map.of("success", false, "message", "세션을 찾을 수 없습니다.");
            }
            
            String log = ShellScriptManager.readLogFile(logPath, 100, connection);
            
            return Map.of(
                "success", true,
                "log", log != null ? log : ""
            );
        } catch (Exception e) {
            return Map.of("success", false, "message", e.getMessage());
        }
    }
}