package com.infraReport.wizmig.model;

import com.jcraft.jsch.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.*;
import java.util.Properties;

/**
 * SSH 세션 관리자
 * JSch를 사용하여 원격 서버에 SSH 연결
 */
public class SSHSessionManager {
    
    private static final Logger logger = LoggerFactory.getLogger(SSHSessionManager.class);
    
    private Session session;
    private ConnectionInfo connectionInfo;
    
    public SSHSessionManager(ConnectionInfo connectionInfo) {
        this.connectionInfo = connectionInfo;
    }
    
    /**
     * SSH 연결
     */
    public boolean connect() {
        try {
            JSch jsch = new JSch();
            
            // SSH 키 파일이 있으면 추가
            if (connectionInfo.getPrivateKeyPath() != null && 
                !connectionInfo.getPrivateKeyPath().isEmpty()) {
                jsch.addIdentity(connectionInfo.getPrivateKeyPath());
            }
            
            // 세션 생성
            session = jsch.getSession(
                connectionInfo.getUsername(),
                connectionInfo.getHost(),
                connectionInfo.getPort()
            );
            
            // 비밀번호 설정 (키 파일이 없는 경우)
            if (connectionInfo.getPassword() != null && 
                !connectionInfo.getPassword().isEmpty()) {
                session.setPassword(connectionInfo.getPassword());
            }
            
            // SSH 설정
            Properties config = new Properties();
            config.put("StrictHostKeyChecking", "no"); // 호스트 키 검증 비활성화
            config.put("PreferredAuthentications", "publickey,password");
            session.setConfig(config);
            
            // 타임아웃 설정
            session.setTimeout(30000); // 30초
            
            // 연결
            session.connect();
            
            logger.info("SSH 연결 성공: {}@{}:{}", 
                connectionInfo.getUsername(), 
                connectionInfo.getHost(), 
                connectionInfo.getPort());
            
            return true;
            
        } catch (JSchException e) {
            logger.error("SSH 연결 실패: {}", e.getMessage(), e);
            return false;
        }
    }
    
    /**
     * SSH 연결 확인
     */
    public boolean isConnected() {
        return session != null && session.isConnected();
    }
    
    /**
     * SSH 연결 종료
     */
    public void disconnect() {
        if (session != null && session.isConnected()) {
            session.disconnect();
            logger.info("SSH 연결 종료");
        }
    }
    
    /**
     * 명령 실행 (동기)
     */
    public String executeCommand(String command) throws IOException {
        if (!isConnected()) {
            throw new IOException("SSH 세션이 연결되지 않았습니다.");
        }
        
        Channel channel = null;
        try {
            channel = session.openChannel("exec");
            ((ChannelExec) channel).setCommand(command);
            
            // 출력 스트림 설정
            channel.setInputStream(null);
            ((ChannelExec) channel).setErrStream(System.err);
            
            InputStream in = channel.getInputStream();
            channel.connect();
            
            // 출력 읽기
            StringBuilder output = new StringBuilder();
            byte[] buffer = new byte[1024];
            while (true) {
                while (in.available() > 0) {
                    int i = in.read(buffer, 0, 1024);
                    if (i < 0) break;
                    output.append(new String(buffer, 0, i));
                }
                
                if (channel.isClosed()) {
                    if (in.available() > 0) continue;
                    logger.debug("종료 상태: {}", channel.getExitStatus());
                    break;
                }
                
                try {
                    Thread.sleep(100);
                } catch (InterruptedException e) {
                    Thread.currentThread().interrupt();
                    break;
                }
            }
            
            return output.toString();
            
        } catch (JSchException e) {
            logger.error("명령 실행 실패: {}", e.getMessage(), e);
            throw new IOException("명령 실행 실패: " + e.getMessage(), e);
        } finally {
            if (channel != null && channel.isConnected()) {
                channel.disconnect();
            }
        }
    }
    
    /**
     * 스크립트 실행 (백그라운드, 로그 파일 지정)
     */
    public String executeScriptWithLog(String scriptPath, String[] arguments, 
                                      String logFilePath, boolean background) throws IOException {
        StringBuilder command = new StringBuilder();
        
        // DB2 프로파일 설정 (필요한 경우)
        if (connectionInfo.getDbProfile() != null && !connectionInfo.getDbProfile().isEmpty()) {
            command.append("source ").append(connectionInfo.getDbProfile()).append(" && ");
        }
        
        // 로그 파일 생성
        command.append("touch ").append(logFilePath).append(" && ");
        
        if (background) {
            // 백그라운드 실행
            command.append("nohup ").append(scriptPath);
            
            // 인자 추가
            if (arguments != null && arguments.length > 0) {
                for (String arg : arguments) {
                    command.append(" ").append(escapeShellArgument(arg));
                }
            }
            
            command.append(" >> ").append(logFilePath).append(" 2>&1 & ");
            command.append("echo $! && "); // PID 출력
            command.append("echo ").append(logFilePath); // 로그 파일 경로 출력
            
        } else {
            // 포그라운드 실행
            command.append("(").append(scriptPath);
            
            // 인자 추가
            if (arguments != null && arguments.length > 0) {
                for (String arg : arguments) {
                    command.append(" ").append(escapeShellArgument(arg));
                }
            }
            
            command.append(" >> ").append(logFilePath).append(" 2>&1; ");
            command.append("echo PID:$$ LOG:").append(logFilePath).append(")");
        }
        
        logger.debug("실행 명령: {}", command.toString());
        return executeCommand(command.toString());
    }
    
    /**
     * 파일 내용 읽기
     */
    public String readFile(String filePath) throws IOException {
        String command = "cat " + filePath;
        return executeCommand(command);
    }
    
    /**
     * 로그 파일 읽기 (tail)
     */
    public String readLogFile(String logFilePath, int lines) throws IOException {
        String command = "tail -n " + lines + " " + logFilePath;
        return executeCommand(command);
    }
    
    /**
     * 디렉토리의 쉘 스크립트 목록 조회
     */
    public String listShellScripts(String directory) throws IOException {
        String command = "find " + directory + " -maxdepth 1 -name '*.sh' -type f";
        return executeCommand(command);
    }
    
    /**
     * 파일 생성
     */
    public boolean createFile(String filePath, String content) throws IOException {
        Channel channel = null;
        try {
            channel = session.openChannel("exec");
            ((ChannelExec) channel).setCommand("cat > " + filePath + " && chmod +x " + filePath);
            
            OutputStream out = channel.getOutputStream();
            channel.connect();
            
            out.write(content.getBytes());
            out.flush();
            out.close();
            
            // 결과 대기
            while (!channel.isClosed()) {
                try {
                    Thread.sleep(100);
                } catch (InterruptedException e) {
                    Thread.currentThread().interrupt();
                    break;
                }
            }
            
            int exitStatus = channel.getExitStatus();
            logger.debug("파일 생성 종료 상태: {}", exitStatus);
            return exitStatus == 0;
            
        } catch (JSchException e) {
            logger.error("파일 생성 실패: {}", e.getMessage(), e);
            throw new IOException("파일 생성 실패: " + e.getMessage(), e);
        } finally {
            if (channel != null && channel.isConnected()) {
                channel.disconnect();
            }
        }
    }
    
    /**
     * 파일 삭제
     */
    public boolean deleteFile(String filePath) throws IOException {
        String command = "rm -f " + filePath;
        String result = executeCommand(command);
        return result != null;
    }
    
    /**
     * 프로세스 종료
     */
    public boolean killProcess(String pid) throws IOException {
        String command = "kill -9 " + pid;
        String result = executeCommand(command);
        return result != null;
    }
    
    /**
     * 프로세스 존재 확인
     */
    public boolean checkProcessExists(String pid) throws IOException {
        String command = "ps -p " + pid;
        String result = executeCommand(command);
        return result != null && result.contains(pid);
    }
    
    /**
     * 쉘 인자 이스케이프
     */
    private String escapeShellArgument(String arg) {
        if (arg == null || arg.isEmpty()) {
            return "''";
        }
        
        // 특수 문자가 없으면 그대로 반환
        if (arg.matches("^[a-zA-Z0-9_./:-]+$")) {
            return arg;
        }
        
        // 작은따옴표로 감싸고 내부의 작은따옴표는 이스케이프
        return "'" + arg.replace("'", "'\\''") + "'";
    }
}
