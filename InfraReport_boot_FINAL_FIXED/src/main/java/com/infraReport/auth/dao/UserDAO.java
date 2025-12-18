package com.infraReport.auth.dao;

import com.infraReport.auth.domain.User;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * 사용자 DAO 인터페이스
 */
@Mapper
public interface UserDAO {

    /**
     * 전체 사용자 조회
     */
    List<User> selectAllUsers();

    /**
     * ID로 사용자 조회
     */
    User selectUserById(@Param("userId") String userId);

    /**
     * 이메일로 사용자 조회
     */
    User selectUserByEmail(@Param("email") String email);

    /**
     * 사용자 등록
     */
    int insertUser(User user);

    /**
     * 사용자 수정
     */
    int updateUser(User user);

    /**
     * 비밀번호 변경
     */
    int updatePassword(@Param("userId") String userId, @Param("password") String password);

    /**
     * 마지막 로그인 일시 업데이트
     */
    int updateLastLoginDate(@Param("userId") String userId);

    /**
     * 사용자 상태 변경
     */
    int updateStatus(@Param("userId") String userId, @Param("status") String status);

    /**
     * 사용자 삭제
     */
    int deleteUser(@Param("userId") String userId);

    /**
     * 사용자 ID 존재 여부 확인
     */
    int countByUserId(@Param("userId") String userId);

    /**
     * 이메일 존재 여부 확인
     */
    int countByEmail(@Param("email") String email);
}
