<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>로그인 - 일일업무보고서 통합관리 시스템</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .login-container {
            background: white;
            border-radius: 20px;
            box-shadow: 0 20px 60px rgba(0,0,0,0.3);
            overflow: hidden;
            width: 100%;
            max-width: 400px;
        }
        .login-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 40px 30px;
            text-align: center;
        }
        .login-header h1 {
            font-size: 1.5rem;
            margin-bottom: 10px;
        }
        .login-header p {
            opacity: 0.9;
            margin: 0;
            font-size: 0.9rem;
        }
        .login-body {
            padding: 40px 30px;
        }
        .form-floating {
            margin-bottom: 20px;
        }
        .form-floating .form-control {
            border-radius: 10px;
            border: 2px solid #e9ecef;
            height: 58px;
        }
        .form-floating .form-control:focus {
            border-color: #667eea;
            box-shadow: 0 0 0 0.2rem rgba(102, 126, 234, 0.25);
        }
        .btn-login {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border: none;
            border-radius: 10px;
            padding: 15px;
            font-size: 1.1rem;
            font-weight: 600;
            width: 100%;
            transition: transform 0.3s, box-shadow 0.3s;
        }
        .btn-login:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 30px rgba(102, 126, 234, 0.4);
        }
        .register-link {
            text-align: center;
            margin-top: 25px;
            color: #6c757d;
        }
        .register-link a {
            color: #667eea;
            text-decoration: none;
            font-weight: 600;
        }
        .register-link a:hover {
            text-decoration: underline;
        }
        .alert {
            border-radius: 10px;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
    <div class="login-container">
        <div class="login-header">
            <i class="fas fa-chart-line fa-3x mb-3"></i>
            <h1>일일업무보고서 통합관리</h1>
            <p>시스템에 로그인하세요</p>
        </div>
        <div class="login-body">
            <c:if test="${not empty errorMessage}">
                <div class="alert alert-danger" role="alert">
                    <i class="fas fa-exclamation-circle me-2"></i>${errorMessage}
                </div>
            </c:if>
            <c:if test="${not empty logoutMessage}">
                <div class="alert alert-success" role="alert">
                    <i class="fas fa-check-circle me-2"></i>${logoutMessage}
                </div>
            </c:if>
            
            <form action="/login" method="post">
                <div class="form-floating">
                    <input type="text" class="form-control" id="userId" name="userId" 
                           placeholder="아이디" required autofocus>
                    <label for="userId"><i class="fas fa-user me-2"></i>아이디</label>
                </div>
                <div class="form-floating">
                    <input type="password" class="form-control" id="password" name="password" 
                           placeholder="비밀번호" required>
                    <label for="password"><i class="fas fa-lock me-2"></i>비밀번호</label>
                </div>
                <button type="submit" class="btn btn-primary btn-login">
                    <i class="fas fa-sign-in-alt me-2"></i>로그인
                </button>
            </form>
            
            <div class="register-link">
                계정이 없으신가요? <a href="/register">회원가입</a>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
