package com.infraReport.dr.controller;

import java.util.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.infraReport.auth.domain.CustomUserDetails;
import com.infraReport.dr.dto.DrDashboardDTO.*;
import com.infraReport.dr.service.DrDashboardService;

/**
 * DR 대시보드 컨트롤러
 */
@Controller
@RequestMapping("/dr")
public class DrDashboardController {

    @Autowired
    private DrDashboardService drDashboardService;

    // =====================================================
    // 페이지 이동
    // =====================================================

    /**
     * DR 현황판 페이지
     */
    @GetMapping("/dashboard")
    public String drDashboard(@RequestParam(required = false) Integer drillId, Model model) {
        if (drillId == null) {
            // 진행중인 훈련 조회
            DrillInfo activeDrill = drDashboardService.getActiveDrill();
            if (activeDrill != null) {
                drillId = activeDrill.getDrillId();
            }
        }
        model.addAttribute("drillId", drillId);
        return "dr/drDashboard";
    }

    /**
     * 모의훈련 상황판 페이지
     */
    @GetMapping("/drill")
    public String drillDashboard(@RequestParam(required = false) Integer drillId, Model model) {
        if (drillId == null) {
            DrillInfo activeDrill = drDashboardService.getActiveDrill();
            if (activeDrill != null) {
                drillId = activeDrill.getDrillId();
            }
        }
        model.addAttribute("drillId", drillId);
        return "dr/drillDashboard";
    }

    /**
     * 훈련 관리 페이지
     */
    @GetMapping("/manage")
    public String drillManage(Model model) {
        return "dr/drillManage";
    }

    // =====================================================
    // 훈련 마스터 API
    // =====================================================

    /**
     * 훈련 목록 조회
     */
    @GetMapping("/api/drills")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> getDrillList(
            @RequestParam(required = false) String drillType,
            @RequestParam(required = false) String status) {
        
        Map<String, Object> params = new HashMap<>();
        if (drillType != null) params.put("drillType", drillType);
        if (status != null) params.put("status", status);
        
        List<DrillInfo> drills = drDashboardService.getDrillList(params);
        
        Map<String, Object> result = new HashMap<>();
        result.put("success", true);
        result.put("data", drills);
        
        return ResponseEntity.ok(result);
    }

    /**
     * 훈련 상세 조회
     */
    @GetMapping("/api/drills/{drillId}")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> getDrill(@PathVariable Integer drillId) {
        Map<String, Object> result = new HashMap<>();
        
        DrillInfo drill = drDashboardService.getDrillById(drillId);
        result.put("success", drill != null);
        result.put("data", drill);
        
        return ResponseEntity.ok(result);
    }

    /**
     * 훈련 등록
     */
    @PostMapping("/api/drills")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> createDrill(
            @RequestBody DrillInfo drill,
            @AuthenticationPrincipal CustomUserDetails user) {
        
        if (user != null) {
            drill.setCreateUserId(user.getUsername());
        }
        
        int result = drDashboardService.createDrill(drill);
        
        Map<String, Object> response = new HashMap<>();
        response.put("success", result > 0);
        response.put("drillId", drill.getDrillId());
        
        return ResponseEntity.ok(response);
    }

    /**
     * 훈련 수정
     */
    @PutMapping("/api/drills/{drillId}")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> updateDrill(
            @PathVariable Integer drillId,
            @RequestBody DrillInfo drill,
            @AuthenticationPrincipal CustomUserDetails user) {
        
        drill.setDrillId(drillId);
        if (user != null) {
            drill.setUpdateUserId(user.getUsername());
        }
        
        int result = drDashboardService.updateDrill(drill);
        
        Map<String, Object> response = new HashMap<>();
        response.put("success", result > 0);
        
        return ResponseEntity.ok(response);
    }

    /**
     * 훈련 삭제
     */
    @DeleteMapping("/api/drills/{drillId}")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> deleteDrill(@PathVariable Integer drillId) {
        int result = drDashboardService.deleteDrill(drillId);
        
        Map<String, Object> response = new HashMap<>();
        response.put("success", result > 0);
        
        return ResponseEntity.ok(response);
    }

    /**
     * 훈련 시작
     */
    @PostMapping("/api/drills/{drillId}/start")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> startDrill(@PathVariable Integer drillId) {
        int result = drDashboardService.startDrill(drillId);
        
        Map<String, Object> response = new HashMap<>();
        response.put("success", result > 0);
        
        return ResponseEntity.ok(response);
    }

    /**
     * 훈련 일시정지
     */
    @PostMapping("/api/drills/{drillId}/pause")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> pauseDrill(@PathVariable Integer drillId) {
        int result = drDashboardService.pauseDrill(drillId);
        
        Map<String, Object> response = new HashMap<>();
        response.put("success", result > 0);
        
        return ResponseEntity.ok(response);
    }

    /**
     * 훈련 재개
     */
    @PostMapping("/api/drills/{drillId}/resume")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> resumeDrill(@PathVariable Integer drillId) {
        int result = drDashboardService.resumeDrill(drillId);
        
        Map<String, Object> response = new HashMap<>();
        response.put("success", result > 0);
        
        return ResponseEntity.ok(response);
    }

    /**
     * 훈련 다시 시작 (COMPLETED -> PROGRESS)
     */
    @PostMapping("/api/drills/{drillId}/restart")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> restartDrill(@PathVariable Integer drillId) {
        int result = drDashboardService.restartDrill(drillId);
        
        Map<String, Object> response = new HashMap<>();
        response.put("success", result > 0);
        
        return ResponseEntity.ok(response);
    }

    /**
     * 훈련 종료
     */
    @PostMapping("/api/drills/{drillId}/end")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> endDrill(@PathVariable Integer drillId) {
        int result = drDashboardService.endDrill(drillId);
        
        Map<String, Object> response = new HashMap<>();
        response.put("success", result > 0);
        
        return ResponseEntity.ok(response);
    }

    // =====================================================
    // DR 현황판 데이터 API
    // =====================================================

    /**
     * DR 현황판 전체 데이터
     */
    @GetMapping("/api/dashboard/{drillId}")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> getDashboardData(@PathVariable Integer drillId) {
        Map<String, Object> data = drDashboardService.getDrDashboardData(drillId);
        data.put("success", true);
        return ResponseEntity.ok(data);
    }

    /**
     * RTO 잔여시간 조회
     */
    @GetMapping("/api/drills/{drillId}/rto")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> getRtoRemaining(@PathVariable Integer drillId) {
        Map<String, Object> rto = drDashboardService.getRtoRemaining(drillId);
        rto.put("success", true);
        return ResponseEntity.ok(rto);
    }

    /**
     * RTO 잔여시간 조회 (대시보드 경로)
     */
    @GetMapping("/api/dashboard/{drillId}/rto-remaining")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> getRtoRemainingForDashboard(@PathVariable Integer drillId) {
        Map<String, Object> rto = drDashboardService.getRtoRemaining(drillId);
        Map<String, Object> response = new HashMap<>();
        response.put("success", true);
        response.put("data", rto);
        return ResponseEntity.ok(response);
    }

    // =====================================================
    // 센터 API
    // =====================================================

    /**
     * 전체 센터 목록
     */
    @GetMapping("/api/centers")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> getCenterList() {
        List<CenterInfo> centers = drDashboardService.getCenterList();
        
        Map<String, Object> result = new HashMap<>();
        result.put("success", true);
        result.put("data", centers);
        
        return ResponseEntity.ok(result);
    }

    /**
     * 훈련별 센터 목록
     */
    @GetMapping("/api/drills/{drillId}/centers")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> getCentersByDrill(@PathVariable Integer drillId) {
        List<CenterInfo> centers = drDashboardService.getCentersByDrillId(drillId);
        
        Map<String, Object> result = new HashMap<>();
        result.put("success", true);
        result.put("data", centers);
        
        return ResponseEntity.ok(result);
    }

    /**
     * 센터 상세 조회
     */
    @GetMapping("/api/centers/{centerId}")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> getCenter(@PathVariable Integer centerId) {
        CenterInfo center = drDashboardService.getCenterById(centerId);
        
        Map<String, Object> result = new HashMap<>();
        result.put("success", center != null);
        result.put("data", center);
        
        return ResponseEntity.ok(result);
    }

    /**
     * 센터 등록
     */
    @PostMapping("/api/centers")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> createCenter(@RequestBody CenterInfo center) {
        int result = drDashboardService.createCenter(center);
        
        Map<String, Object> response = new HashMap<>();
        response.put("success", result > 0);
        response.put("centerId", center.getCenterId());
        
        return ResponseEntity.ok(response);
    }

    /**
     * 센터 수정
     */
    @PutMapping("/api/centers/{centerId}")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> updateCenter(
            @PathVariable Integer centerId,
            @RequestBody CenterInfo center) {
        
        center.setCenterId(centerId);
        int result = drDashboardService.updateCenter(center);
        
        Map<String, Object> response = new HashMap<>();
        response.put("success", result > 0);
        
        return ResponseEntity.ok(response);
    }

    /**
     * 센터 삭제
     */
    @DeleteMapping("/api/centers/{centerId}")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> deleteCenter(@PathVariable Integer centerId) {
        int result = drDashboardService.deleteCenter(centerId);
        
        Map<String, Object> response = new HashMap<>();
        response.put("success", result > 0);
        
        return ResponseEntity.ok(response);
    }

    // =====================================================
    // 태스크 API
    // =====================================================

    /**
     * 훈련별 태스크 목록 (세부태스크 포함) - PathVariable
     */
    @GetMapping("/api/drills/{drillId}/tasks")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> getTasksByDrill(@PathVariable Integer drillId) {
        List<TaskInfo> tasks = drDashboardService.getTasksWithSubtasks(drillId);
        
        Map<String, Object> result = new HashMap<>();
        result.put("success", true);
        result.put("data", tasks);
        
        return ResponseEntity.ok(result);
    }

    /**
     * 훈련별 태스크 목록 (세부태스크 포함) - RequestParam
     */
    @GetMapping("/api/tasks")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> getTasks(@RequestParam Integer drillId) {
        List<TaskInfo> tasks = drDashboardService.getTasksWithSubtasks(drillId);
        
        Map<String, Object> result = new HashMap<>();
        result.put("success", true);
        result.put("data", tasks);
        
        return ResponseEntity.ok(result);
    }

    /**
     * 태스크 상세 조회
     */
    @GetMapping("/api/tasks/{taskId}")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> getTask(@PathVariable Integer taskId) {
        TaskInfo task = drDashboardService.getTaskById(taskId);
        
        Map<String, Object> result = new HashMap<>();
        result.put("success", task != null);
        result.put("data", task);
        
        return ResponseEntity.ok(result);
    }

    /**
     * 태스크 등록
     */
    @PostMapping("/api/tasks")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> createTask(
            @RequestBody TaskInfo task,
            @AuthenticationPrincipal CustomUserDetails user) {
        
        if (user != null) {
            task.setCreateUserId(user.getUsername());
        }
        
        int result = drDashboardService.createTask(task);
        
        Map<String, Object> response = new HashMap<>();
        response.put("success", result > 0);
        response.put("taskId", task.getTaskId());
        
        return ResponseEntity.ok(response);
    }

    /**
     * 태스크 수정
     */
    @PutMapping("/api/tasks/{taskId}")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> updateTask(
            @PathVariable Integer taskId,
            @RequestBody TaskInfo task,
            @AuthenticationPrincipal CustomUserDetails user) {
        
        task.setTaskId(taskId);
        if (user != null) {
            task.setUpdateUserId(user.getUsername());
        }
        
        int result = drDashboardService.updateTask(task);
        
        Map<String, Object> response = new HashMap<>();
        response.put("success", result > 0);
        
        return ResponseEntity.ok(response);
    }

    /**
     * 태스크 삭제
     */
    @DeleteMapping("/api/tasks/{taskId}")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> deleteTask(@PathVariable Integer taskId) {
        int result = drDashboardService.deleteTask(taskId);
        
        Map<String, Object> response = new HashMap<>();
        response.put("success", result > 0);
        
        return ResponseEntity.ok(response);
    }

    /**
     * 태스크 시작
     */
    @PostMapping("/api/tasks/{taskId}/start")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> startTask(@PathVariable Integer taskId) {
        int result = drDashboardService.startTask(taskId);
        
        Map<String, Object> response = new HashMap<>();
        response.put("success", result > 0);
        
        return ResponseEntity.ok(response);
    }

    /**
     * 태스크 완료
     */
    @PostMapping("/api/tasks/{taskId}/complete")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> completeTask(@PathVariable Integer taskId) {
        int result = drDashboardService.completeTask(taskId);
        
        Map<String, Object> response = new HashMap<>();
        response.put("success", result > 0);
        
        return ResponseEntity.ok(response);
    }

    // =====================================================
    // 세부 태스크 API
    // =====================================================

    /**
     * 세부 태스크 목록
     */
    @GetMapping("/api/tasks/{taskId}/subtasks")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> getSubtasks(@PathVariable Integer taskId) {
        List<SubtaskInfo> subtasks = drDashboardService.getSubtasksByTaskId(taskId);
        
        Map<String, Object> result = new HashMap<>();
        result.put("success", true);
        result.put("data", subtasks);
        
        return ResponseEntity.ok(result);
    }

    /**
     * 세부 태스크 상세 조회
     */
    @GetMapping("/api/subtasks/{subtaskId}")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> getSubtask(@PathVariable Integer subtaskId) {
        SubtaskInfo subtask = drDashboardService.getSubtaskById(subtaskId);
        
        Map<String, Object> result = new HashMap<>();
        result.put("success", subtask != null);
        result.put("data", subtask);
        
        return ResponseEntity.ok(result);
    }

    /**
     * 세부 태스크 등록
     */
    @PostMapping("/api/subtasks")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> createSubtask(
            @RequestBody SubtaskInfo subtask,
            @AuthenticationPrincipal CustomUserDetails user) {
        
        if (user != null) {
            subtask.setCreateUserId(user.getUsername());
        }
        
        int result = drDashboardService.createSubtask(subtask);
        
        Map<String, Object> response = new HashMap<>();
        response.put("success", result > 0);
        response.put("subtaskId", subtask.getSubtaskId());
        
        return ResponseEntity.ok(response);
    }

    /**
     * 세부 태스크 수정
     */
    @PutMapping("/api/subtasks/{subtaskId}")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> updateSubtask(
            @PathVariable Integer subtaskId,
            @RequestBody SubtaskInfo subtask,
            @AuthenticationPrincipal CustomUserDetails user) {
        
        subtask.setSubtaskId(subtaskId);
        if (user != null) {
            subtask.setUpdateUserId(user.getUsername());
        }
        
        int result = drDashboardService.updateSubtask(subtask);
        
        Map<String, Object> response = new HashMap<>();
        response.put("success", result > 0);
        
        return ResponseEntity.ok(response);
    }

    /**
     * 세부 태스크 삭제
     */
    @DeleteMapping("/api/subtasks/{subtaskId}")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> deleteSubtask(@PathVariable Integer subtaskId) {
        int result = drDashboardService.deleteSubtask(subtaskId);
        
        Map<String, Object> response = new HashMap<>();
        response.put("success", result > 0);
        
        return ResponseEntity.ok(response);
    }

    /**
     * 세부 태스크 시작
     */
    @PostMapping("/api/subtasks/{subtaskId}/start")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> startSubtask(@PathVariable Integer subtaskId) {
        int result = drDashboardService.startSubtask(subtaskId);
        
        Map<String, Object> response = new HashMap<>();
        response.put("success", result > 0);
        
        return ResponseEntity.ok(response);
    }

    /**
     * 세부 태스크 완료
     */
    @PostMapping("/api/subtasks/{subtaskId}/complete")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> completeSubtask(@PathVariable Integer subtaskId) {
        int result = drDashboardService.completeSubtask(subtaskId);
        
        Map<String, Object> response = new HashMap<>();
        response.put("success", result > 0);
        
        return ResponseEntity.ok(response);
    }

    /**
     * 세부 태스크 순서 변경
     */
    @PostMapping("/api/subtasks/reorder")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> reorderSubtasks(
            @RequestBody List<Map<String, Integer>> orderList) {
        
        int result = drDashboardService.reorderSubtasks(orderList);
        
        Map<String, Object> response = new HashMap<>();
        response.put("success", result > 0);
        
        return ResponseEntity.ok(response);
    }

    /**
     * 태스크 순서 변경
     */
    @PostMapping("/api/tasks/reorder")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> reorderTasks(
            @RequestBody List<Map<String, Integer>> orderList) {
        
        int result = drDashboardService.reorderTasks(orderList);
        
        Map<String, Object> response = new HashMap<>();
        response.put("success", result > 0);
        
        return ResponseEntity.ok(response);
    }

    // =====================================================
    // 타임라인 API
    // =====================================================

    /**
     * 타임라인 조회
     */
    @GetMapping("/api/drills/{drillId}/timeline")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> getTimeline(@PathVariable Integer drillId) {
        List<TimelineEvent> timeline = drDashboardService.getTimelineByDrillId(drillId);
        
        Map<String, Object> result = new HashMap<>();
        result.put("success", true);
        result.put("data", timeline);
        
        return ResponseEntity.ok(result);
    }

    /**
     * 타임라인 이벤트 추가
     */
    @PostMapping("/api/timeline")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> addTimelineEvent(@RequestBody TimelineEvent event) {
        if (event.getEventTime() == null) {
            event.setEventTime(new Date());
        }
        
        int result = drDashboardService.addTimelineEvent(event);
        
        Map<String, Object> response = new HashMap<>();
        response.put("success", result > 0);
        
        return ResponseEntity.ok(response);
    }

    // =====================================================
    // 시스템 복구 API
    // =====================================================

    /**
     * 복구 시스템 목록
     */
    @GetMapping("/api/drills/{drillId}/recovery-systems")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> getRecoverySystems(@PathVariable Integer drillId) {
        List<RecoverySystemInfo> systems = drDashboardService.getRecoverySystems(drillId);
        StatInfo stats = drDashboardService.getRecoverySystemStats(drillId);
        
        Map<String, Object> result = new HashMap<>();
        result.put("success", true);
        result.put("data", systems);
        result.put("stats", stats);
        
        return ResponseEntity.ok(result);
    }

    /**
     * 복구 시스템 추가
     */
    @PostMapping("/api/recovery-systems")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> createRecoverySystem(@RequestBody RecoverySystemInfo system) {
        int result = drDashboardService.createRecoverySystem(system);
        
        Map<String, Object> response = new HashMap<>();
        response.put("success", result > 0);
        response.put("systemId", system.getSystemId());
        
        return ResponseEntity.ok(response);
    }

    /**
     * 복구 시스템 삭제
     */
    @DeleteMapping("/api/recovery-systems/{systemId}")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> deleteRecoverySystem(@PathVariable Integer systemId) {
        int result = drDashboardService.deleteRecoverySystem(systemId);
        
        Map<String, Object> response = new HashMap<>();
        response.put("success", result > 0);
        
        return ResponseEntity.ok(response);
    }

    /**
     * 복구 시스템 시작
     */
    @PostMapping("/api/recovery-systems/{systemId}/start")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> startRecoverySystem(@PathVariable Integer systemId) {
        int result = drDashboardService.startRecoverySystem(systemId);
        
        Map<String, Object> response = new HashMap<>();
        response.put("success", result > 0);
        
        return ResponseEntity.ok(response);
    }

    /**
     * 복구 시스템 완료
     */
    @PostMapping("/api/recovery-systems/{systemId}/complete")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> completeRecoverySystem(@PathVariable Integer systemId) {
        int result = drDashboardService.completeRecoverySystem(systemId);
        
        Map<String, Object> response = new HashMap<>();
        response.put("success", result > 0);
        
        return ResponseEntity.ok(response);
    }

    // =====================================================
    // 업무 점검 API
    // =====================================================

    /**
     * 업무 점검 목록
     */
    @GetMapping("/api/drills/{drillId}/business-checks")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> getBusinessChecks(@PathVariable Integer drillId) {
        List<BusinessCheckInfo> checks = drDashboardService.getBusinessChecks(drillId);
        StatInfo stats = drDashboardService.getBusinessCheckStats(drillId);
        
        Map<String, Object> result = new HashMap<>();
        result.put("success", true);
        result.put("data", checks);
        result.put("stats", stats);
        
        return ResponseEntity.ok(result);
    }

    /**
     * 업무 점검 추가
     */
    @PostMapping("/api/business-checks")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> createBusinessCheck(@RequestBody BusinessCheckInfo check) {
        int result = drDashboardService.createBusinessCheck(check);
        
        Map<String, Object> response = new HashMap<>();
        response.put("success", result > 0);
        response.put("checkId", check.getCheckId());
        
        return ResponseEntity.ok(response);
    }

    /**
     * 업무 점검 삭제
     */
    @DeleteMapping("/api/business-checks/{checkId}")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> deleteBusinessCheck(@PathVariable Integer checkId) {
        int result = drDashboardService.deleteBusinessCheck(checkId);
        
        Map<String, Object> response = new HashMap<>();
        response.put("success", result > 0);
        
        return ResponseEntity.ok(response);
    }

    /**
     * 업무 점검 상태 변경
     */
    @PostMapping("/api/business-checks/{checkId}/status")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> updateCheckStatus(
            @PathVariable Integer checkId,
            @RequestParam String status) {
        
        int result = drDashboardService.updateBusinessCheckStatus(checkId, status);
        
        Map<String, Object> response = new HashMap<>();
        response.put("success", result > 0);
        
        return ResponseEntity.ok(response);
    }
}
