package com.infraReport.config;

import com.infraReport.auth.handler.LoginFailureHandler;
import com.infraReport.auth.handler.LoginSuccessHandler;
import com.infraReport.auth.service.CustomUserDetailsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.context.annotation.Bean;

/**
 * Spring Security 설정
 */
@Configuration
@EnableWebSecurity
public class SecurityConfig {

    @Autowired
    private CustomUserDetailsService customUserDetailsService;

    @Autowired
    private LoginSuccessHandler loginSuccessHandler;

    @Autowired
    private LoginFailureHandler loginFailureHandler;

    // 🔥 PasswordEncoder는 별도 Config에서 @Bean 등록하고 여기서는 주입만 받음
    @Autowired
    private PasswordEncoder passwordEncoder;

    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
        http
            .csrf(csrf -> csrf.disable())
            .authorizeHttpRequests(auth -> auth
                // 정적 리소스 허용
                .antMatchers("/css/**", "/js/**", "/images/**", "/fonts/**", "/uploads/**", "/webjars/**").permitAll()
                // 로그인, 회원가입 허용
                .antMatchers("/", "/login", "/register", "/api/auth/**").permitAll()
                // TV 대시보드 허용 (로그인 없이)
                .antMatchers("/dashboard/tv").permitAll()
                // 관리자 페이지
                .antMatchers("/admin/**", "/work/process/admin/**", "/work/admin/**").hasRole("ADMIN")
                .antMatchers("/api/work/admin/**").hasRole("ADMIN")
                // 작업 관리 페이지
                .antMatchers("/work/**", "/api/work/**").hasAnyRole("USER", "ADMIN")
                // DR 훈련 관리 페이지
                .antMatchers("/dr/**", "/api/dr/**").hasAnyRole("USER", "ADMIN")
                // 나머지는 인증 필요
                .anyRequest().authenticated()
            )
            .formLogin(form -> form
                .loginPage("/login")
                .loginProcessingUrl("/login")
                .usernameParameter("userId")
                .passwordParameter("password")
                .successHandler(loginSuccessHandler)
                .failureHandler(loginFailureHandler)
                .permitAll()
            )
            .logout(logout -> logout
                .logoutUrl("/logout")
                .logoutSuccessUrl("/login?logout")
                .invalidateHttpSession(true)
                .deleteCookies("JSESSIONID")
                .permitAll()
            )
            .exceptionHandling(ex -> ex
                .accessDeniedPage("/error/403")
            );

        return http.build();
    }

    @Autowired
    public void configureGlobal(AuthenticationManagerBuilder auth) throws Exception {
        auth.userDetailsService(customUserDetailsService)
            // 🔥 여기서도 메서드 호출이 아니라, 주입받은 빈 사용
            .passwordEncoder(passwordEncoder);
    }
}
