package com.infraReport.wizmig.model;

/**
 * SSH 연결 정보
 */
public class ConnectionInfo {
    private String sessionName;
    private String host;
    private int port = 22; // SSH 기본 포트
    private String username;
    private String password;
    private String privateKeyPath; // SSH 키 파일 경로 (선택사항)
    private String directory; // 스크립트 디렉토리
    private String dbProfile; // DB2 프로파일 경로 (선택사항)
    
    public ConnectionInfo() {}
    
    public ConnectionInfo(String sessionName, String host, int port, 
                         String username, String password, String directory) {
        this.sessionName = sessionName;
        this.host = host;
        this.port = port;
        this.username = username;
        this.password = password;
        this.directory = directory;
    }
    
    // Getters and Setters
    public String getSessionName() {
        return sessionName;
    }
    
    public void setSessionName(String sessionName) {
        this.sessionName = sessionName;
    }
    
    public String getHost() {
        return host;
    }
    
    public void setHost(String host) {
        this.host = host;
    }
    
    public int getPort() {
        return port;
    }
    
    public void setPort(int port) {
        this.port = port;
    }
    
    public String getUsername() {
        return username;
    }
    
    public void setUsername(String username) {
        this.username = username;
    }
    
    public String getPassword() {
        return password;
    }
    
    public void setPassword(String password) {
        this.password = password;
    }
    
    public String getPrivateKeyPath() {
        return privateKeyPath;
    }
    
    public void setPrivateKeyPath(String privateKeyPath) {
        this.privateKeyPath = privateKeyPath;
    }
    
    public String getDirectory() {
        return directory;
    }
    
    public void setDirectory(String directory) {
        this.directory = directory;
    }
    
    public String getDbProfile() {
        return dbProfile;
    }
    
    public void setDbProfile(String dbProfile) {
        this.dbProfile = dbProfile;
    }
    
    @Override
    public String toString() {
        return "ConnectionInfo{" +
                "sessionName='" + sessionName + '\'' +
                ", host='" + host + '\'' +
                ", port=" + port +
                ", username='" + username + '\'' +
                ", directory='" + directory + '\'' +
                '}';
    }
}
