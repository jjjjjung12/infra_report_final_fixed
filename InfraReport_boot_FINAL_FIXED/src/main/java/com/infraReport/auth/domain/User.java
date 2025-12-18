package com.infraReport.auth.domain;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

/**
 * 사용자 도메인
 */
public class User {

    private static final DateTimeFormatter FORMATTER = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");

    private String userId;
    private String password;
    private String userName;
    private String email;
    private String phone;
    private String companyName;
    private String department;
    private String role;
    private String status;
    private LocalDateTime createdDate;
    private LocalDateTime lastLoginDate;

    // Getters and Setters
    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getCompanyName() {
        return companyName;
    }

    public void setCompanyName(String companyName) {
        this.companyName = companyName;
    }

    public String getDepartment() {
        return department;
    }

    public void setDepartment(String department) {
        this.department = department;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public LocalDateTime getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(LocalDateTime createdDate) {
        this.createdDate = createdDate;
    }

    public LocalDateTime getLastLoginDate() {
        return lastLoginDate;
    }

    public void setLastLoginDate(LocalDateTime lastLoginDate) {
        this.lastLoginDate = lastLoginDate;
    }

    public String getFormattedCreatedDate() {
        return createdDate != null ? createdDate.format(FORMATTER) : "";
    }

    public String getFormattedLastLoginDate() {
        return lastLoginDate != null ? lastLoginDate.format(FORMATTER) : "";
    }

    public String getRoleName() {
        return "ADMIN".equals(role) ? "관리자" : "작업자";
    }

    public String getStatusName() {
        return "ACTIVE".equals(status) ? "활성" : "비활성";
    }

    public boolean isActive() {
        return "ACTIVE".equals(status);
    }

    public boolean isAdmin() {
        return "ADMIN".equals(role);
    }
}
