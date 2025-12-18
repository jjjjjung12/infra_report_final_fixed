package com.infraReport.auth.controller;

import com.infraReport.auth.domain.CustomUserDetails;
import com.infraReport.auth.domain.User;
import com.infraReport.auth.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;

/**
 * 인증 컨트롤러
 */
@Controller
public class AuthController {

    @Autowired
    private UserService userService;

    /**
     * 메인 페이지 (로그인 페이지로 리다이렉트)
     */
    @GetMapping("/")
    public String index() {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        if (auth != null && auth.isAuthenticated() && !"anonymousUser".equals(auth.getPrincipal())) {
            CustomUserDetails userDetails = (CustomUserDetails) auth.getPrincipal();
            if (userDetails.isAdmin()) {
                return "redirect:/report/main";
            } else {
                return "redirect:/work/process/user";
            }
        }
        return "redirect:/login";
    }

    /**
     * 로그인 페이지
     */
    @GetMapping("/login")
    public String loginPage(@RequestParam(value = "error", required = false) String error,
                           @RequestParam(value = "logout", required = false) String logout,
                           Model model) {
        if (error != null) {
            model.addAttribute("errorMessage", error);
        }
        if (logout != null) {
            model.addAttribute("logoutMessage", "로그아웃되었습니다.");
        }
        return "auth/login";
    }

    /**
     * 회원가입 페이지
     */
    @GetMapping("/register")
    public String registerPage() {
        return "auth/register";
    }

    /**
     * 회원가입 처리
     */
    @PostMapping("/register")
    @ResponseBody
    public Map<String, Object> register(@RequestBody User user) {
        Map<String, Object> result = new HashMap<>();
        
        try {
            userService.register(user);
            result.put("success", true);
            result.put("message", "회원가입이 완료되었습니다. 로그인해주세요.");
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", e.getMessage());
        }
        
        return result;
    }

    /**
     * 아이디 중복 확인
     */
    @GetMapping("/api/auth/check-userid")
    @ResponseBody
    public Map<String, Object> checkUserId(@RequestParam String userId) {
        Map<String, Object> result = new HashMap<>();
        
        boolean isDuplicate = userService.isUserIdDuplicate(userId);
        result.put("duplicate", isDuplicate);
        result.put("message", isDuplicate ? "이미 사용중인 아이디입니다." : "사용 가능한 아이디입니다.");
        
        return result;
    }

    /**
     * 이메일 중복 확인
     */
    @GetMapping("/api/auth/check-email")
    @ResponseBody
    public Map<String, Object> checkEmail(@RequestParam String email) {
        Map<String, Object> result = new HashMap<>();
        
        boolean isDuplicate = userService.isEmailDuplicate(email);
        result.put("duplicate", isDuplicate);
        result.put("message", isDuplicate ? "이미 사용중인 이메일입니다." : "사용 가능한 이메일입니다.");
        
        return result;
    }

    /**
     * 내 정보 페이지
     */
    @GetMapping("/mypage")
    public String myPage(Model model, Authentication authentication) {
        CustomUserDetails userDetails = (CustomUserDetails) authentication.getPrincipal();
        User user = userService.getUserById(userDetails.getUsername());
        model.addAttribute("user", user);
        return "auth/mypage";
    }

    /**
     * 내 정보 수정
     */
    @PostMapping("/mypage")
    @ResponseBody
    public Map<String, Object> updateMyInfo(@RequestBody User user, Authentication authentication) {
        Map<String, Object> result = new HashMap<>();
        
        try {
            CustomUserDetails userDetails = (CustomUserDetails) authentication.getPrincipal();
            user.setUserId(userDetails.getUsername());
            userService.updateUser(user);
            result.put("success", true);
            result.put("message", "정보가 수정되었습니다.");
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", e.getMessage());
        }
        
        return result;
    }

    /**
     * 비밀번호 변경
     */
    @PostMapping("/api/auth/change-password")
    @ResponseBody
    public Map<String, Object> changePassword(@RequestBody Map<String, String> params, 
                                              Authentication authentication) {
        Map<String, Object> result = new HashMap<>();
        
        try {
            CustomUserDetails userDetails = (CustomUserDetails) authentication.getPrincipal();
            String oldPassword = params.get("oldPassword");
            String newPassword = params.get("newPassword");
            
            userService.changePassword(userDetails.getUsername(), oldPassword, newPassword);
            result.put("success", true);
            result.put("message", "비밀번호가 변경되었습니다.");
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", e.getMessage());
        }
        
        return result;
    }

    /**
     * 접근 거부 페이지
     */
    @GetMapping("/error/403")
    public String accessDenied() {
        return "common/403";
    }
}
