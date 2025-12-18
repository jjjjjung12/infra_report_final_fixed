package com.infraReport.auth.handler;

import com.infraReport.auth.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy; // [중요] Lazy 임포트 추가
import org.springframework.security.core.Authentication;
import org.springframework.security.core.authority.AuthorityUtils;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.stereotype.Component;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Set;

/**
 * 로그인 성공 처리
 */
@Component
public class LoginSuccessHandler implements AuthenticationSuccessHandler {

    // [수정 포인트] @Lazy 어노테이션 추가
    // UserService를 지금 당장 생성하지 않고, 실제 로그인이 성공해서 
    // 메서드가 호출될 때까지 로딩을 미룹니다. -> 순환 참조 고리가 끊어짐
    @Autowired
    @Lazy
    private UserService userService;

    @Override
    public void onAuthenticationSuccess(HttpServletRequest request, 
                                        HttpServletResponse response,
                                        Authentication authentication) throws IOException, ServletException {
        
        // 마지막 로그인 일시 업데이트
        String userId = authentication.getName();
        userService.updateLastLoginDate(userId);
        
        Set<String> roles = AuthorityUtils.authorityListToSet(authentication.getAuthorities());
        
        // 역할에 따라 다른 페이지로 리다이렉트
        if (roles.contains("ROLE_ADMIN")) {
            response.sendRedirect("/report/main");
        } else {
            response.sendRedirect("/work/process/user");
        }
    }
}