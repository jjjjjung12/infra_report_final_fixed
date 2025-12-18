package com.infraReport.auth.service;

import com.infraReport.auth.domain.User;

import java.util.List;

/**
 * 사용자 서비스 인터페이스
 */
public interface UserService {

    /**
     * 전체 사용자 조회
     */
    List<User> getAllUsers();

    /**
     * ID로 사용자 조회
     */
    User getUserById(String userId);

    /**
     * 회원가입
     */
    void register(User user) throws Exception;

    /**
     * 사용자 정보 수정
     */
    void updateUser(User user);

    /**
     * 비밀번호 변경
     */
    void changePassword(String userId, String oldPassword, String newPassword) throws Exception;

    /**
     * 사용자 ID 중복 확인
     */
    boolean isUserIdDuplicate(String userId);

    /**
     * 이메일 중복 확인
     */
    boolean isEmailDuplicate(String email);

    /**
     * 마지막 로그인 일시 업데이트
     */
    void updateLastLoginDate(String userId);

    /**
     * 사용자 상태 변경
     */
    void updateStatus(String userId, String status);

    /**
     * 사용자 삭제
     */
    void deleteUser(String userId);
}
