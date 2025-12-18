package com.infraReport.wizmig.model;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

/**
 * SSH 기반 스크립트 관리자
 * 원격 서버에 SSH로 연결하여 스크립트 실행
 */
public class ShellScriptManager {
    
    private static final Logger logger = LoggerFactory.getLogger(ShellScriptManager.class);
    
    /**
     * 디렉토리의 쉘 스크립트 목록 조회
     */
    public static List<String> getShellScripts(ConnectionInfo connection, String directory) {
        SSHSessionManager sshManager = null;
        try {
            sshManager = new SSHSessionManager(connection);
            if (!sshManager.connect()) {
                logger.error("SSH 연결 실패");
                return Collections.emptyList();
            }
            
            String result = sshManager.listShellScripts(directory);
            List<String> scripts = new ArrayList<>();
            
            if (result != null && !result.isEmpty()) {
                String[] lines = result.split("\n");
                for (String line : lines) {
                    line = line.trim();
                    if (!line.isEmpty()) {
                        scripts.add(line);
                    }
                }
            }
            
            return scripts;
            
        } catch (IOException e) {
            logger.error("스크립트 목록 조회 실패: {}", e.getMessage(), e);
            return Collections.emptyList();
        } finally {
            if (sshManager != null) {
                sshManager.disconnect();
            }
        }
    }
    
    /**
     * 스크립트 실행 (포그라운드)
     */
    public static String executeScriptWithLogFG(String param, ConnectionInfo connection) {
        SSHSessionManager sshManager = null;
        try {
            // param 형식: "scriptPath args ::: logFile ::: stdin"
            String[] parts = param.split(":::");
            String scriptAndArgs = parts[0].trim();
            String logFile = parts.length > 1 ? parts[1].trim() : "/tmp/fg_script.log";
            
            // 스크립트 경로와 인자 분리
            String[] cmdParts = scriptAndArgs.split("\\s+");
            String scriptPath = cmdParts[0];
            String[] arguments = new String[cmdParts.length - 1];
            System.arraycopy(cmdParts, 1, arguments, 0, cmdParts.length - 1);
            
            sshManager = new SSHSessionManager(connection);
            if (!sshManager.connect()) {
                return "SSH 연결 실패";
            }
            
            return sshManager.executeScriptWithLog(scriptPath, arguments, logFile, false);
            
        } catch (IOException e) {
            logger.error("스크립트 실행 실패: {}", e.getMessage(), e);
            return "실행 오류: " + e.getMessage();
        } finally {
            if (sshManager != null) {
                sshManager.disconnect();
            }
        }
    }
    
    /**
     * 스크립트 실행 (백그라운드)
     */
    public static String executeScriptWithLogBG(String scriptPath, String[] arguments, 
                                               String logFilePath, ConnectionInfo connection) {
        SSHSessionManager sshManager = null;
        try {
            sshManager = new SSHSessionManager(connection);
            if (!sshManager.connect()) {
                return "SSH 연결 실패";
            }
            
            String result = sshManager.executeScriptWithLog(scriptPath, arguments, logFilePath, true);
            
            // 결과 포맷팅: PID와 로그 파일 경로 추출
            String[] lines = result.split("\n");
            String pid = null;
            String logFile = null;
            
            for (String line : lines) {
                line = line.trim();
                if (line.matches("\\d+")) {
                    pid = line;
                } else if (line.startsWith("/")) {
                    logFile = line;
                }
            }
            
            if (pid != null && logFile != null) {
                return "PID:" + pid + " LOG:" + logFile;
            }
            
            return result;
            
        } catch (IOException e) {
            logger.error("백그라운드 스크립트 실행 실패: {}", e.getMessage(), e);
            return "백그라운드 실행 오류: " + e.getMessage();
        } finally {
            if (sshManager != null) {
                sshManager.disconnect();
            }
        }
    }
    
    /**
     * 스크립트 파일 생성
     */
    public static boolean createScriptFile(String fullPath, String content, ConnectionInfo connection) {
        SSHSessionManager sshManager = null;
        try {
            sshManager = new SSHSessionManager(connection);
            if (!sshManager.connect()) {
                return false;
            }
            
            return sshManager.createFile(fullPath, content);
            
        } catch (IOException e) {
            logger.error("스크립트 파일 생성 실패: {}", e.getMessage(), e);
            return false;
        } finally {
            if (sshManager != null) {
                sshManager.disconnect();
            }
        }
    }
    
    /**
     * 스크립트 파일 수정
     */
    public static boolean updateScriptFile(String fullPath, String newContent, ConnectionInfo connection) {
        // 기존 파일 삭제 후 재생성
        return deleteScriptFile(fullPath, connection) && createScriptFile(fullPath, newContent, connection);
    }
    
    /**
     * 스크립트 파일 삭제
     */
    public static boolean deleteScriptFile(String fullPath, ConnectionInfo connection) {
        SSHSessionManager sshManager = null;
        try {
            sshManager = new SSHSessionManager(connection);
            if (!sshManager.connect()) {
                return false;
            }
            
            return sshManager.deleteFile(fullPath);
            
        } catch (IOException e) {
            logger.error("스크립트 파일 삭제 실패: {}", e.getMessage(), e);
            return false;
        } finally {
            if (sshManager != null) {
                sshManager.disconnect();
            }
        }
    }
    
    /**
     * 스크립트 내용 읽기
     */
    public static String getScriptContent(String fullPath, ConnectionInfo connection) {
        SSHSessionManager sshManager = null;
        try {
            sshManager = new SSHSessionManager(connection);
            if (!sshManager.connect()) {
                return "";
            }
            
            return sshManager.readFile(fullPath);
            
        } catch (IOException e) {
            logger.error("스크립트 내용 읽기 실패: {}", e.getMessage(), e);
            return "";
        } finally {
            if (sshManager != null) {
                sshManager.disconnect();
            }
        }
    }
    
    /**
     * 로그 파일 읽기
     */
    public static String readLogFile(String logFilePath, int lines, ConnectionInfo connection) {
        SSHSessionManager sshManager = null;
        try {
            sshManager = new SSHSessionManager(connection);
            if (!sshManager.connect()) {
                return "";
            }
            
            return sshManager.readLogFile(logFilePath, lines);
            
        } catch (IOException e) {
            logger.error("로그 파일 읽기 실패: {}", e.getMessage(), e);
            return "";
        } finally {
            if (sshManager != null) {
                sshManager.disconnect();
            }
        }
    }
    
    /**
     * 프로세스 종료
     */
    public static void killProcessByPid(String pid, ConnectionInfo connection) throws IOException {
        SSHSessionManager sshManager = null;
        try {
            sshManager = new SSHSessionManager(connection);
            if (!sshManager.connect()) {
                throw new IOException("SSH 연결 실패");
            }
            
            sshManager.killProcess(pid);
            
        } finally {
            if (sshManager != null) {
                sshManager.disconnect();
            }
        }
    }
    
    /**
     * 프로세스 존재 확인
     */
    public static boolean checkProcessExists(String pid, ConnectionInfo connection) {
        SSHSessionManager sshManager = null;
        try {
            sshManager = new SSHSessionManager(connection);
            if (!sshManager.connect()) {
                return false;
            }
            
            return sshManager.checkProcessExists(pid);
            
        } catch (IOException e) {
            logger.error("프로세스 확인 실패: {}", e.getMessage(), e);
            return false;
        } finally {
            if (sshManager != null) {
                sshManager.disconnect();
            }
        }
    }
    
    /**
     * 쉘 인자 이스케이프
     */
    private static String shellEscape(String arg) {
        if (arg == null) return "''";
        return "'" + arg.replace("'", "'\\''") + "'";
    }
}
