package com.infraReport.wizmig.scheduler;

import com.infraReport.wizmig.dto.ExecutionStepDTO;
import com.infraReport.wizmig.model.ConnectionInfo;
import com.infraReport.wizmig.model.ConnectionManager;
import com.infraReport.wizmig.model.ShellScriptManager;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * 스크립트 실행 서비스
 */
@Service
public class ScriptExecutionService {
    
    private static final Logger logger = LoggerFactory.getLogger(ScriptExecutionService.class);
    
    /**
     * 스크립트 실행
     */
    public boolean executeScript(String sessionName, ExecutionStepDTO step) {
        try {
            ConnectionInfo conn = ConnectionManager.getConnections().get(sessionName);
            if (conn == null) {
                logger.error("세션을 찾을 수 없습니다: {}", sessionName);
                step.setResult("세션을 찾을 수 없음");
                return false;
            }
            
            // 로그 파일 경로 생성
            String timestamp = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());
            String scriptNameOnly = step.getScriptName().endsWith(".sh") 
                ? step.getScriptName().substring(0, step.getScriptName().length() - 3)
                : step.getScriptName();
            String logFileName = scriptNameOnly + "_" + timestamp + "_PLAN.log";
            String logFilePath = "/tmp/" + logFileName;
            
            // 인자 파싱
            String[] arguments = {};
            if (step.getArguments() != null && !step.getArguments().trim().isEmpty()) {
                arguments = step.getArguments().trim().split("\\s+");
            }
            
            // 백그라운드로 스크립트 실행
            String execResult = ShellScriptManager.executeScriptWithLogBG(
                step.getScriptPath(), 
                arguments, 
                logFilePath, 
                conn
            );
            
            // PID 추출
            Matcher pidMatcher = Pattern.compile("PID:([0-9]+)").matcher(execResult);
            if (pidMatcher.find()) {
                step.setPid(pidMatcher.group(1));
            }
            
            // APID 추출
            Matcher apidMatcher = Pattern.compile("APID:([0-9]+)").matcher(execResult);
            if (apidMatcher.find()) {
                step.setApid(apidMatcher.group(1));
            }
            
            // 로그 파일 경로 추출
            Matcher logMatcher = Pattern.compile("LOG:([^\\s]+)").matcher(execResult);
            if (logMatcher.find()) {
                step.setLogFile(logMatcher.group(1));
            } else {
                step.setLogFile(logFilePath);
            }
            
            logger.info("스크립트 실행 시작: {} (PID: {}, APID: {})", 
                step.getScriptName(), step.getPid(), step.getApid());
            
            // 스크립트 완료 대기 및 모니터링
            return waitForCompletion(conn, step);
            
        } catch (Exception e) {
            logger.error("스크립트 실행 중 오류: {}", step.getScriptName(), e);
            step.setResult("실행 오류: " + e.getMessage());
            return false;
        }
    }
    
    /**
     * 스크립트 완료 대기
     */
    private boolean waitForCompletion(ConnectionInfo conn, ExecutionStepDTO step) {
        int checkCount = 0;
        int maxChecks = 3600; // 최대 1시간 (3600 * 1초)
        
        try {
            while (checkCount < maxChecks) {
                // 프로세스 존재 확인
                if (step.getPid() != null && !step.getPid().equals("-")) {
                    boolean processExists = ShellScriptManager.checkProcessExists(step.getPid(), conn);
                    
                    if (!processExists) {
                        // 프로세스가 종료됨 - 로그 파일에서 결과 확인
                        if (step.getLogFile() != null) {
                            String logTail = ShellScriptManager.readLogFile(step.getLogFile(), 50, conn);
                            
                            // 성공 패턴 확인
                            if (logTail.matches("(?s).*Complete Job.*|.*completed.*|.*SUCCESS.*|.*END.*")) {
                                step.setResult("정상 완료");
                                logger.info("스크립트 정상 완료: {}", step.getScriptName());
                                return true;
                            }
                            
                            // 에러 패턴 확인
                            if (logTail.matches("(?s).*error.*|.*실패.*|.*permission denied.*|.*not found.*")) {
                                step.setResult("실행 중 에러 발생");
                                logger.error("스크립트 실행 에러: {}", step.getScriptName());
                                return false;
                            }
                            
                            // 패턴이 없으면 정상 종료로 간주
                            step.setResult("완료");
                            return true;
                        }
                        
                        // 로그 파일이 없으면 정상 종료로 간주
                        step.setResult("완료");
                        return true;
                    }
                }
                
                // 1초 대기 후 재확인
                Thread.sleep(1000);
                checkCount++;
                
                // 10초마다 로그 확인
                if (checkCount % 10 == 0 && step.getLogFile() != null) {
                    String logTail = ShellScriptManager.readLogFile(step.getLogFile(), 30, conn);
                    
                    // APID 업데이트
                    Matcher apidMatcher = Pattern.compile("APID\\s*[:=]\\s*(\\d+)").matcher(logTail);
                    if (apidMatcher.find()) {
                        step.setApid(apidMatcher.group(1));
                    }
                    
                    logger.debug("스크립트 실행 중: {} ({}초 경과)", step.getScriptName(), checkCount);
                }
            }
            
            // 타임아웃
            logger.warn("스크립트 모니터링 타임아웃: {}", step.getScriptName());
            step.setResult("모니터링 타임아웃");
            return false;
            
        } catch (InterruptedException e) {
            logger.info("스크립트 모니터링 중단: {}", step.getScriptName());
            Thread.currentThread().interrupt();
            step.setResult("실행 중단됨");
            return false;
        } catch (Exception e) {
            logger.error("스크립트 모니터링 중 오류: {}", step.getScriptName(), e);
            step.setResult("모니터링 오류: " + e.getMessage());
            return false;
        }
    }
}
