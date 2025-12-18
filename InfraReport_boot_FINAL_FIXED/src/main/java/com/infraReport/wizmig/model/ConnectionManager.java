package com.infraReport.wizmig.model;

import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

/**
 * 연결 관리자
 * 모든 SSH 연결 정보를 관리
 */
public class ConnectionManager {
    
    private static final Map<String, ConnectionInfo> connections = new ConcurrentHashMap<>();
    
    /**
     * 연결 정보 추가
     */
    public static void addConnection(String sessionName, ConnectionInfo connectionInfo) {
        connections.put(sessionName, connectionInfo);
    }
    
    /**
     * 연결 정보 조회
     */
    public static ConnectionInfo getConnection(String sessionName) {
        return connections.get(sessionName);
    }
    
    /**
     * 연결 정보 삭제
     */
    public static void removeConnection(String sessionName) {
        connections.remove(sessionName);
    }
    
    /**
     * 모든 연결 정보 조회
     */
    public static Map<String, ConnectionInfo> getConnections() {
        return connections;
    }
    
    /**
     * 연결 존재 확인
     */
    public static boolean hasConnection(String sessionName) {
        return connections.containsKey(sessionName);
    }
    
    /**
     * 모든 연결 초기화
     */
    public static void clearAll() {
        connections.clear();
    }
}
