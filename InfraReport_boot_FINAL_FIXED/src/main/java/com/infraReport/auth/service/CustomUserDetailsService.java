package com.infraReport.auth.service;

import com.infraReport.auth.dao.UserDAO;
import com.infraReport.auth.domain.CustomUserDetails;
import com.infraReport.auth.domain.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

/**
 * 사용자 인증 서비스
 */
@Service
public class CustomUserDetailsService implements UserDetailsService {

    @Autowired
    private UserDAO userDAO;

    @Override
    public UserDetails loadUserByUsername(String userId) throws UsernameNotFoundException {
        User user = userDAO.selectUserById(userId);
        
        if (user == null) {
            throw new UsernameNotFoundException("사용자를 찾을 수 없습니다: " + userId);
        }
        
        return new CustomUserDetails(user);
    }
}
