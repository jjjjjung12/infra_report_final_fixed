package com.infraReport.wizmig.controller;

import com.infraReport.wizmig.model.ConnectionInfo;
import com.infraReport.wizmig.model.ConnectionManager;
import com.infraReport.wizmig.model.SSHSessionManager;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * SSH 세션 관리 컨트롤러
 */
@Controller
@RequestMapping("/wizmig/session")
public class SessionController {
    
    /**
     * 세션 목록 화면
     */
    @GetMapping("/list")
    public String sessionList(Model model) {
        Map<String, ConnectionInfo> sessions = ConnectionManager.getConnections();
        model.addAttribute("sessions", sessions);
        return "wizmig/sessionList";
    }
    
    /**
     * 세션 등록 화면
     */
    @GetMapping("/new")
    public String sessionNew() {
        return "wizmig/sessionForm";
    }
    
    /**
     * 세션 수정 화면
     */
    @GetMapping("/edit/{sessionName}")
    public String sessionEdit(@PathVariable String sessionName, Model model) {
        ConnectionInfo connection = ConnectionManager.getConnection(sessionName);
        if (connection == null) {
            return "redirect:/wizmig/session/list";
        }
        model.addAttribute("session", connection);
        model.addAttribute("mode", "edit");
        return "wizmig/sessionForm";
    }
    
    /**
     * 세션 저장 (API)
     */
    @PostMapping("/api/save")
    @ResponseBody
    public Map<String, Object> saveSession(@RequestBody ConnectionInfo connectionInfo) {
        try {
            // 세션명 중복 체크 (신규 등록 시)
            if (ConnectionManager.hasConnection(connectionInfo.getSessionName())) {
                return Map.of("success", false, "message", "이미 존재하는 세션명입니다.");
            }
            
            ConnectionManager.addConnection(connectionInfo.getSessionName(), connectionInfo);
            
            return Map.of("success", true, "message", "세션이 저장되었습니다.");
        } catch (Exception e) {
            return Map.of("success", false, "message", "세션 저장 실패: " + e.getMessage());
        }
    }
    
    /**
     * 세션 수정 (API)
     */
    @PutMapping("/api/update/{sessionName}")
    @ResponseBody
    public Map<String, Object> updateSession(@PathVariable String sessionName, 
                                             @RequestBody ConnectionInfo connectionInfo) {
        try {
            if (!ConnectionManager.hasConnection(sessionName)) {
                return Map.of("success", false, "message", "세션을 찾을 수 없습니다.");
            }
            
            // 세션명 변경 시 기존 세션 삭제
            if (!sessionName.equals(connectionInfo.getSessionName())) {
                ConnectionManager.removeConnection(sessionName);
            }
            
            ConnectionManager.addConnection(connectionInfo.getSessionName(), connectionInfo);
            
            return Map.of("success", true, "message", "세션이 수정되었습니다.");
        } catch (Exception e) {
            return Map.of("success", false, "message", "세션 수정 실패: " + e.getMessage());
        }
    }
    
    /**
     * 세션 삭제 (API)
     */
    @DeleteMapping("/api/delete/{sessionName}")
    @ResponseBody
    public Map<String, Object> deleteSession(@PathVariable String sessionName) {
        try {
            if (!ConnectionManager.hasConnection(sessionName)) {
                return Map.of("success", false, "message", "세션을 찾을 수 없습니다.");
            }
            
            ConnectionManager.removeConnection(sessionName);
            
            return Map.of("success", true, "message", "세션이 삭제되었습니다.");
        } catch (Exception e) {
            return Map.of("success", false, "message", "세션 삭제 실패: " + e.getMessage());
        }
    }
    
    /**
     * 세션 연결 테스트 (API)
     */
    @PostMapping("/api/test")
    @ResponseBody
    public Map<String, Object> testConnection(@RequestBody ConnectionInfo connectionInfo) {
        SSHSessionManager sshManager = null;
        try {
            sshManager = new SSHSessionManager(connectionInfo);
            
            if (!sshManager.connect()) {
                return Map.of(
                    "success", false, 
                    "message", "SSH 연결 실패: 호스트, 포트, 인증 정보를 확인하세요."
                );
            }
            
            // 간단한 명령 실행 테스트
            String result = sshManager.executeCommand("echo 'SSH 연결 성공'");
            
            if (result != null && result.contains("SSH 연결 성공")) {
                return Map.of(
                    "success", true, 
                    "message", "SSH 연결 성공! 원격 서버와 정상적으로 통신됩니다."
                );
            } else {
                return Map.of(
                    "success", false, 
                    "message", "SSH 연결되었으나 명령 실행 실패"
                );
            }
            
        } catch (Exception e) {
            return Map.of(
                "success", false, 
                "message", "연결 테스트 실패: " + e.getMessage()
            );
        } finally {
            if (sshManager != null) {
                sshManager.disconnect();
            }
        }
    }
    
    /**
     * 세션 정보 조회 (API)
     */
    @GetMapping("/api/info/{sessionName}")
    @ResponseBody
    public Map<String, Object> getSessionInfo(@PathVariable String sessionName) {
        ConnectionInfo connection = ConnectionManager.getConnection(sessionName);
        
        if (connection == null) {
            return Map.of("success", false, "message", "세션을 찾을 수 없습니다.");
        }
        
        return Map.of(
            "success", true, 
            "session", connection
        );
    }
    
    /**
     * 전체 세션 목록 조회 (API)
     */
    @GetMapping("/api/list")
    @ResponseBody
    public Map<String, Object> getSessionList() {
        Map<String, ConnectionInfo> sessions = ConnectionManager.getConnections();
        List<ConnectionInfo> sessionList = new ArrayList<>(sessions.values());
        
        return Map.of(
            "success", true,
            "sessions", sessionList,
            "count", sessionList.size()
        );
    }
}
