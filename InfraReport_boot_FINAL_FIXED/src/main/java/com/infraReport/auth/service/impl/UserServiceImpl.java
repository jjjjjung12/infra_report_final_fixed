package com.infraReport.auth.service.impl;

import com.infraReport.auth.dao.UserDAO;
import com.infraReport.auth.domain.User;
import com.infraReport.auth.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * 사용자 서비스 구현체
 */
@Service
@Transactional
public class UserServiceImpl implements UserService {

    @Autowired
    private UserDAO userDAO;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @Override
    @Transactional(readOnly = true)
    public List<User> getAllUsers() {
        return userDAO.selectAllUsers();
    }

    @Override
    @Transactional(readOnly = true)
    public User getUserById(String userId) {
        return userDAO.selectUserById(userId);
    }

    @Override
    public void register(User user) throws Exception {
        // 아이디 중복 확인
        if (isUserIdDuplicate(user.getUserId())) {
            throw new Exception("이미 사용중인 아이디입니다.");
        }

        // 이메일 중복 확인 (이메일이 있는 경우)
        if (user.getEmail() != null && !user.getEmail().isEmpty()) {
            if (isEmailDuplicate(user.getEmail())) {
                throw new Exception("이미 사용중인 이메일입니다.");
            }
        }

        // 비밀번호 암호화
        user.setPassword(passwordEncoder.encode(user.getPassword()));

        // 기본값 설정
        if (user.getRole() == null || user.getRole().isEmpty()) {
            user.setRole("USER");
        }
        if (user.getStatus() == null || user.getStatus().isEmpty()) {
            user.setStatus("ACTIVE");
        }

        userDAO.insertUser(user);
    }

    @Override
    public void updateUser(User user) {
        userDAO.updateUser(user);
    }

    @Override
    public void changePassword(String userId, String oldPassword, String newPassword) throws Exception {
        User user = userDAO.selectUserById(userId);
        if (user == null) {
            throw new Exception("사용자를 찾을 수 없습니다.");
        }

        // 기존 비밀번호 확인
        if (!passwordEncoder.matches(oldPassword, user.getPassword())) {
            throw new Exception("현재 비밀번호가 일치하지 않습니다.");
        }

        // 새 비밀번호 암호화하여 저장
        String encodedPassword = passwordEncoder.encode(newPassword);
        userDAO.updatePassword(userId, encodedPassword);
    }

    @Override
    @Transactional(readOnly = true)
    public boolean isUserIdDuplicate(String userId) {
        return userDAO.countByUserId(userId) > 0;
    }

    @Override
    @Transactional(readOnly = true)
    public boolean isEmailDuplicate(String email) {
        return userDAO.countByEmail(email) > 0;
    }

    @Override
    public void updateLastLoginDate(String userId) {
        userDAO.updateLastLoginDate(userId);
    }

    @Override
    public void updateStatus(String userId, String status) {
        userDAO.updateStatus(userId, status);
    }

    @Override
    public void deleteUser(String userId) {
        userDAO.deleteUser(userId);
    }
}
