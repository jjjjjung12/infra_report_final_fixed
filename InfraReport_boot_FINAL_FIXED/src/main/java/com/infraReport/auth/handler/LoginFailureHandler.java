package com.infraReport.auth.handler;

import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.DisabledException;
import org.springframework.security.authentication.LockedException;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;
import org.springframework.stereotype.Component;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;

/**
 * 로그인 실패 처리
 */
@Component
public class LoginFailureHandler implements AuthenticationFailureHandler {

    @Override
    public void onAuthenticationFailure(HttpServletRequest request, 
                                        HttpServletResponse response,
                                        AuthenticationException exception) throws IOException, ServletException {
        
        String errorMessage;
        
        if (exception instanceof UsernameNotFoundException) {
            errorMessage = "존재하지 않는 사용자입니다.";
        } else if (exception instanceof BadCredentialsException) {
            errorMessage = "아이디 또는 비밀번호가 일치하지 않습니다.";
        } else if (exception instanceof DisabledException) {
            errorMessage = "비활성화된 계정입니다. 관리자에게 문의하세요.";
        } else if (exception instanceof LockedException) {
            errorMessage = "잠긴 계정입니다. 관리자에게 문의하세요.";
        } else {
            errorMessage = "로그인에 실패했습니다.";
        }
        
        String encodedMessage = URLEncoder.encode(errorMessage, StandardCharsets.UTF_8);
        response.sendRedirect("/login?error=" + encodedMessage);
    }
}
