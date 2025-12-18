package com.infraReport.wizmig.model;

/**
 * 스크립트 정보
 */
public class ScriptInfo {
    private String name;
    private String path;
    
    public ScriptInfo() {}
    
    public ScriptInfo(String name, String path) {
        this.name = name;
        this.path = path;
    }
    
    public String getName() {
        return name;
    }
    
    public void setName(String name) {
        this.name = name;
    }
    
    public String getPath() {
        return path;
    }
    
    public void setPath(String path) {
        this.path = path;
    }
    
    @Override
    public String toString() {
        return "ScriptInfo{" +
                "name='" + name + '\'' +
                ", path='" + path + '\'' +
                '}';
    }
}
