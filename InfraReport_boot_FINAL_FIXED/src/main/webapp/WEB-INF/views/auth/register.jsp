<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원가입 - 일일업무보고서 통합관리 시스템</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 30px 15px;
        }
        .register-container {
            background: white;
            border-radius: 20px;
            box-shadow: 0 20px 60px rgba(0,0,0,0.3);
            overflow: hidden;
            width: 100%;
            max-width: 500px;
        }
        .register-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 30px;
            text-align: center;
        }
        .register-header h1 {
            font-size: 1.5rem;
            margin-bottom: 5px;
        }
        .register-body {
            padding: 30px;
        }
        .form-floating {
            margin-bottom: 15px;
        }
        .form-floating .form-control {
            border-radius: 10px;
            border: 2px solid #e9ecef;
        }
        .form-floating .form-control:focus {
            border-color: #667eea;
            box-shadow: 0 0 0 0.2rem rgba(102, 126, 234, 0.25);
        }
        .form-floating .form-control.is-valid {
            border-color: #198754;
        }
        .form-floating .form-control.is-invalid {
            border-color: #dc3545;
        }
        .btn-register {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border: none;
            border-radius: 10px;
            padding: 15px;
            font-size: 1.1rem;
            font-weight: 600;
            width: 100%;
            transition: transform 0.3s, box-shadow 0.3s;
        }
        .btn-register:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 30px rgba(102, 126, 234, 0.4);
        }
        .login-link {
            text-align: center;
            margin-top: 20px;
            color: #6c757d;
        }
        .login-link a {
            color: #667eea;
            text-decoration: none;
            font-weight: 600;
        }
        .validation-message {
            font-size: 0.85rem;
            margin-top: 5px;
        }
        .required-mark {
            color: #dc3545;
        }
    </style>
</head>
<body>
    <div class="register-container">
        <div class="register-header">
            <i class="fas fa-user-plus fa-3x mb-3"></i>
            <h1>회원가입</h1>
            <p>새 계정을 만드세요</p>
        </div>
        <div class="register-body">
            <form id="registerForm">
                <div class="form-floating">
                    <input type="text" class="form-control" id="userId" name="userId" 
                           placeholder="아이디" required pattern="^[a-zA-Z0-9]{4,20}$">
                    <label for="userId"><i class="fas fa-user me-2"></i>아이디 <span class="required-mark">*</span></label>
                    <div id="userIdFeedback" class="validation-message"></div>
                </div>
                
                <div class="form-floating">
                    <input type="password" class="form-control" id="password" name="password" 
                           placeholder="비밀번호" required minlength="6">
                    <label for="password"><i class="fas fa-lock me-2"></i>비밀번호 <span class="required-mark">*</span></label>
                    <div class="validation-message text-muted">6자 이상 입력해주세요</div>
                </div>
                
                <div class="form-floating">
                    <input type="password" class="form-control" id="passwordConfirm" 
                           placeholder="비밀번호 확인" required>
                    <label for="passwordConfirm"><i class="fas fa-lock me-2"></i>비밀번호 확인 <span class="required-mark">*</span></label>
                    <div id="passwordConfirmFeedback" class="validation-message"></div>
                </div>
                
                <div class="form-floating">
                    <input type="text" class="form-control" id="userName" name="userName" 
                           placeholder="이름" required>
                    <label for="userName"><i class="fas fa-id-card me-2"></i>이름 <span class="required-mark">*</span></label>
                </div>
                
                <div class="form-floating">
                    <input type="email" class="form-control" id="email" name="email" 
                           placeholder="이메일">
                    <label for="email"><i class="fas fa-envelope me-2"></i>이메일</label>
                </div>
                
                <div class="form-floating">
                    <input type="tel" class="form-control" id="phone" name="phone" 
                           placeholder="연락처">
                    <label for="phone"><i class="fas fa-phone me-2"></i>연락처</label>
                </div>
                
                <div class="form-floating">
                    <input type="text" class="form-control" id="companyName" name="companyName" 
                           placeholder="소속회사">
                    <label for="companyName"><i class="fas fa-building me-2"></i>소속회사</label>
                </div>
                
                <div class="form-floating">
                    <input type="text" class="form-control" id="department" name="department" 
                           placeholder="부서">
                    <label for="department"><i class="fas fa-sitemap me-2"></i>부서</label>
                </div>
                
                <button type="submit" class="btn btn-primary btn-register mt-3">
                    <i class="fas fa-user-plus me-2"></i>회원가입
                </button>
            </form>
            
            <div class="login-link">
                이미 계정이 있으신가요? <a href="/login">로그인</a>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        let userIdValid = false;
        
        // 아이디 중복 확인
        document.getElementById('userId').addEventListener('blur', function() {
            const userId = this.value;
            const feedback = document.getElementById('userIdFeedback');
            
            if (userId.length < 4) {
                this.classList.remove('is-valid');
                this.classList.add('is-invalid');
                feedback.className = 'validation-message text-danger';
                feedback.textContent = '아이디는 4자 이상이어야 합니다.';
                userIdValid = false;
                return;
            }
            
            fetch('/api/auth/check-userid?userId=' + encodeURIComponent(userId))
                .then(response => response.json())
                .then(data => {
                    if (data.duplicate) {
                        this.classList.remove('is-valid');
                        this.classList.add('is-invalid');
                        feedback.className = 'validation-message text-danger';
                        feedback.textContent = data.message;
                        userIdValid = false;
                    } else {
                        this.classList.remove('is-invalid');
                        this.classList.add('is-valid');
                        feedback.className = 'validation-message text-success';
                        feedback.textContent = data.message;
                        userIdValid = true;
                    }
                });
        });
        
        // 비밀번호 확인
        document.getElementById('passwordConfirm').addEventListener('input', function() {
            const password = document.getElementById('password').value;
            const passwordConfirm = this.value;
            const feedback = document.getElementById('passwordConfirmFeedback');
            
            if (password !== passwordConfirm) {
                this.classList.remove('is-valid');
                this.classList.add('is-invalid');
                feedback.className = 'validation-message text-danger';
                feedback.textContent = '비밀번호가 일치하지 않습니다.';
            } else {
                this.classList.remove('is-invalid');
                this.classList.add('is-valid');
                feedback.className = 'validation-message text-success';
                feedback.textContent = '비밀번호가 일치합니다.';
            }
        });
        
        // 폼 제출
        document.getElementById('registerForm').addEventListener('submit', function(e) {
            e.preventDefault();
            
            const password = document.getElementById('password').value;
            const passwordConfirm = document.getElementById('passwordConfirm').value;
            
            if (!userIdValid) {
                alert('아이디를 확인해주세요.');
                return;
            }
            
            if (password !== passwordConfirm) {
                alert('비밀번호가 일치하지 않습니다.');
                return;
            }
            
            const formData = {
                userId: document.getElementById('userId').value,
                password: password,
                userName: document.getElementById('userName').value,
                email: document.getElementById('email').value,
                phone: document.getElementById('phone').value,
                companyName: document.getElementById('companyName').value,
                department: document.getElementById('department').value
            };
            
            fetch('/register', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify(formData)
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    alert(data.message);
                    location.href = '/login';
                } else {
                    alert(data.message);
                }
            })
            .catch(error => {
                alert('오류가 발생했습니다.');
                console.error(error);
            });
        });
    </script>
</body>
</html>
