package com.infraReport.wizmig.controller;

import com.infraReport.wizmig.model.ConnectionInfo;
import com.infraReport.wizmig.model.ConnectionManager;
import com.infraReport.wizmig.model.ScriptInfo;
import com.infraReport.wizmig.model.ShellScriptManager;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 스크립트 관리 컨트롤러
 */
@Controller
@RequestMapping("/wizmig/script")
public class ScriptController {
    
    /**
     * 스크립트 목록 화면
     */
    @GetMapping("/list")
    public String scriptList() {
        return "wizmig/scriptList";
    }
    
    /**
     * 스크립트 목록 조회 (API)
     */
    @GetMapping("/api/list")
    @ResponseBody
    public Map<String, Object> getScriptList(@RequestParam String session) {
        try {
            ConnectionInfo connection = ConnectionManager.getConnection(session);
            if (connection == null) {
                return Map.of("success", false, "message", "세션을 찾을 수 없습니다.");
            }
            
            List<String> scriptPaths = ShellScriptManager.getShellScripts(connection, connection.getDirectory());
            
            List<ScriptInfo> scripts = new ArrayList<>();
            for (String path : scriptPaths) {
                String name = path.substring(path.lastIndexOf('/') + 1);
                scripts.add(new ScriptInfo(name, path));
            }
            
            return Map.of(
                "success", true,
                "scripts", scripts
            );
        } catch (Exception e) {
            return Map.of("success", false, "message", e.getMessage());
        }
    }
    
    /**
     * 스크립트 내용 조회 (API)
     */
    @GetMapping("/api/content")
    @ResponseBody
    public Map<String, Object> getScriptContent(@RequestParam String session, 
                                                @RequestParam String path) {
        try {
            ConnectionInfo connection = ConnectionManager.getConnection(session);
            if (connection == null) {
                return Map.of("success", false, "message", "세션을 찾을 수 없습니다.");
            }
            
            String content = ShellScriptManager.getScriptContent(path, connection);
            
            return Map.of(
                "success", true,
                "content", content
            );
        } catch (Exception e) {
            return Map.of("success", false, "message", e.getMessage());
        }
    }
    
    /**
     * 스크립트 생성 (API)
     */
    @PostMapping("/api/create")
    @ResponseBody
    public Map<String, Object> createScript(@RequestBody Map<String, String> request) {
        try {
            String sessionName = request.get("sessionName");
            String scriptName = request.get("scriptName");
            String content = request.get("content");
            
            ConnectionInfo connection = ConnectionManager.getConnection(sessionName);
            if (connection == null) {
                return Map.of("success", false, "message", "세션을 찾을 수 없습니다.");
            }
            
            String fullPath = connection.getDirectory() + "/" + scriptName;
            
            boolean success = ShellScriptManager.createScriptFile(fullPath, content, connection);
            
            if (success) {
                return Map.of("success", true, "message", "스크립트가 생성되었습니다.");
            } else {
                return Map.of("success", false, "message", "스크립트 생성에 실패했습니다.");
            }
        } catch (Exception e) {
            return Map.of("success", false, "message", e.getMessage());
        }
    }
    
    /**
     * 스크립트 수정 (API)
     */
    @PostMapping("/api/update")
    @ResponseBody
    public Map<String, Object> updateScript(@RequestBody Map<String, String> request) {
        try {
            String sessionName = request.get("sessionName");
            String scriptName = request.get("scriptName");
            String content = request.get("content");
            
            ConnectionInfo connection = ConnectionManager.getConnection(sessionName);
            if (connection == null) {
                return Map.of("success", false, "message", "세션을 찾을 수 없습니다.");
            }
            
            String fullPath = connection.getDirectory() + "/" + scriptName;
            
            boolean success = ShellScriptManager.updateScriptFile(fullPath, content, connection);
            
            if (success) {
                return Map.of("success", true, "message", "스크립트가 수정되었습니다.");
            } else {
                return Map.of("success", false, "message", "스크립트 수정에 실패했습니다.");
            }
        } catch (Exception e) {
            return Map.of("success", false, "message", e.getMessage());
        }
    }
    
    /**
     * 스크립트 삭제 (API)
     */
    @DeleteMapping("/api/delete")
    @ResponseBody
    public Map<String, Object> deleteScript(@RequestBody Map<String, String> request) {
        try {
            String sessionName = request.get("sessionName");
            String scriptPath = request.get("scriptPath");
            
            ConnectionInfo connection = ConnectionManager.getConnection(sessionName);
            if (connection == null) {
                return Map.of("success", false, "message", "세션을 찾을 수 없습니다.");
            }
            
            boolean success = ShellScriptManager.deleteScriptFile(scriptPath, connection);
            
            if (success) {
                return Map.of("success", true, "message", "스크립트가 삭제되었습니다.");
            } else {
                return Map.of("success", false, "message", "스크립트 삭제에 실패했습니다.");
            }
        } catch (Exception e) {
            return Map.of("success", false, "message", e.getMessage());
        }
    }
    
    /**
     * 스크립트 즉시 실행 (API)
     */
    @PostMapping("/api/execute")
    @ResponseBody
    public Map<String, Object> executeScript(@RequestBody Map<String, String> request) {
        try {
            String sessionName = request.get("sessionName");
            String scriptPath = request.get("scriptPath");
            
            ConnectionInfo connection = ConnectionManager.getConnection(sessionName);
            if (connection == null) {
                return Map.of("success", false, "message", "세션을 찾을 수 없습니다.");
            }
            
            // 포그라운드 실행
            String param = scriptPath + " ::: /tmp/manual_" + System.currentTimeMillis() + ".log";
            String output = ShellScriptManager.executeScriptWithLogFG(param, connection);
            
            return Map.of(
                "success", true,
                "message", "스크립트가 실행되었습니다.",
                "output", output
            );
        } catch (Exception e) {
            return Map.of("success", false, "message", e.getMessage());
        }
    }
}
