<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>내 정보 - 일일업무보고서 통합관리 시스템</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        :root {
            --primary-color: #667eea;
            --secondary-color: #764ba2;
        }
        body { background-color: #f8f9fa; }
        .navbar {
            background: linear-gradient(135deg, var(--primary-color) 0%, var(--secondary-color) 100%);
        }
        .card {
            border: none;
            border-radius: 15px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.08);
        }
        .profile-header {
            background: linear-gradient(135deg, var(--primary-color) 0%, var(--secondary-color) 100%);
            color: white;
            border-radius: 15px 15px 0 0;
            padding: 30px;
            text-align: center;
        }
        .profile-avatar {
            width: 100px;
            height: 100px;
            border-radius: 50%;
            background: white;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 15px;
            font-size: 2.5rem;
            color: var(--primary-color);
        }
        .btn-gradient {
            background: linear-gradient(135deg, var(--primary-color) 0%, var(--secondary-color) 100%);
            border: none;
            color: white;
        }
        .btn-gradient:hover {
            background: linear-gradient(135deg, #5a6fd6 0%, #6a4190 100%);
            color: white;
        }
        .nav-pills .nav-link.active {
            background: linear-gradient(135deg, var(--primary-color) 0%, var(--secondary-color) 100%);
        }
    </style>
</head>
<body>
    <!-- 네비게이션 -->
    <nav class="navbar navbar-expand-lg navbar-dark">
        <div class="container">
            <a class="navbar-brand" href="#">
                <i class="fas fa-chart-line me-2"></i>일일업무보고서 통합관리
            </a>
            <div class="d-flex align-items-center">
                <sec:authorize access="hasRole('ADMIN')">
                    <a href="/report/main" class="btn btn-outline-light btn-sm me-2">
                        <i class="fas fa-home"></i> 메인
                    </a>
                </sec:authorize>
                <sec:authorize access="hasRole('USER') and !hasRole('ADMIN')">
                    <a href="/work/process/user" class="btn btn-outline-light btn-sm me-2">
                        <i class="fas fa-home"></i> 메인
                    </a>
                </sec:authorize>
                <a href="/logout" class="btn btn-outline-light btn-sm">
                    <i class="fas fa-sign-out-alt"></i> 로그아웃
                </a>
            </div>
        </div>
    </nav>

    <div class="container py-4">
        <div class="row justify-content-center">
            <div class="col-lg-8">
                <div class="card">
                    <div class="profile-header">
                        <div class="profile-avatar">
                            <i class="fas fa-user"></i>
                        </div>
                        <h4 class="mb-1">${user.userName}</h4>
                        <p class="mb-0 opacity-75">${user.roleName}</p>
                    </div>
                    <div class="card-body p-4">
                        <!-- 탭 -->
                        <ul class="nav nav-pills mb-4" role="tablist">
                            <li class="nav-item">
                                <button class="nav-link active" data-bs-toggle="pill" data-bs-target="#infoTab">
                                    <i class="fas fa-user me-1"></i>기본 정보
                                </button>
                            </li>
                            <li class="nav-item">
                                <button class="nav-link" data-bs-toggle="pill" data-bs-target="#passwordTab">
                                    <i class="fas fa-lock me-1"></i>비밀번호 변경
                                </button>
                            </li>
                        </ul>

                        <div class="tab-content">
                            <!-- 기본 정보 탭 -->
                            <div class="tab-pane fade show active" id="infoTab">
                                <form id="infoForm">
                                    <div class="row">
                                        <div class="col-md-6 mb-3">
                                            <label class="form-label">아이디</label>
                                            <input type="text" class="form-control" value="${user.userId}" readonly>
                                        </div>
                                        <div class="col-md-6 mb-3">
                                            <label class="form-label">이름 <span class="text-danger">*</span></label>
                                            <input type="text" class="form-control" id="userName" value="${user.userName}" required>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-6 mb-3">
                                            <label class="form-label">이메일</label>
                                            <input type="email" class="form-control" id="email" value="${user.email}">
                                        </div>
                                        <div class="col-md-6 mb-3">
                                            <label class="form-label">연락처</label>
                                            <input type="tel" class="form-control" id="phone" value="${user.phone}">
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-6 mb-3">
                                            <label class="form-label">소속회사</label>
                                            <input type="text" class="form-control" id="companyName" value="${user.companyName}">
                                        </div>
                                        <div class="col-md-6 mb-3">
                                            <label class="form-label">부서</label>
                                            <input type="text" class="form-control" id="department" value="${user.department}">
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-6 mb-3">
                                            <label class="form-label">가입일</label>
                                            <input type="text" class="form-control" value="${user.formattedCreatedDate}" readonly>
                                        </div>
                                        <div class="col-md-6 mb-3">
                                            <label class="form-label">마지막 로그인</label>
                                            <input type="text" class="form-control" value="${user.formattedLastLoginDate}" readonly>
                                        </div>
                                    </div>
                                    <div class="text-end">
                                        <button type="submit" class="btn btn-gradient">
                                            <i class="fas fa-save me-1"></i>저장
                                        </button>
                                    </div>
                                </form>
                            </div>

                            <!-- 비밀번호 변경 탭 -->
                            <div class="tab-pane fade" id="passwordTab">
                                <form id="passwordForm">
                                    <div class="mb-3">
                                        <label class="form-label">현재 비밀번호 <span class="text-danger">*</span></label>
                                        <input type="password" class="form-control" id="oldPassword" required>
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label">새 비밀번호 <span class="text-danger">*</span></label>
                                        <input type="password" class="form-control" id="newPassword" required minlength="6">
                                        <div class="form-text">6자 이상 입력해주세요.</div>
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label">새 비밀번호 확인 <span class="text-danger">*</span></label>
                                        <input type="password" class="form-control" id="newPasswordConfirm" required>
                                    </div>
                                    <div class="text-end">
                                        <button type="submit" class="btn btn-gradient">
                                            <i class="fas fa-key me-1"></i>비밀번호 변경
                                        </button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // 정보 수정
        document.getElementById('infoForm').addEventListener('submit', function(e) {
            e.preventDefault();
            
            const data = {
                userName: document.getElementById('userName').value,
                email: document.getElementById('email').value,
                phone: document.getElementById('phone').value,
                companyName: document.getElementById('companyName').value,
                department: document.getElementById('department').value
            };
            
            fetch('/mypage', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify(data)
            })
            .then(res => res.json())
            .then(result => {
                alert(result.message);
                if (result.success) {
                    location.reload();
                }
            });
        });
        
        // 비밀번호 변경
        document.getElementById('passwordForm').addEventListener('submit', function(e) {
            e.preventDefault();
            
            const newPassword = document.getElementById('newPassword').value;
            const newPasswordConfirm = document.getElementById('newPasswordConfirm').value;
            
            if (newPassword !== newPasswordConfirm) {
                alert('새 비밀번호가 일치하지 않습니다.');
                return;
            }
            
            const data = {
                oldPassword: document.getElementById('oldPassword').value,
                newPassword: newPassword
            };
            
            fetch('/api/auth/change-password', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify(data)
            })
            .then(res => res.json())
            .then(result => {
                alert(result.message);
                if (result.success) {
                    document.getElementById('passwordForm').reset();
                }
            });
        });
    </script>
</body>
</html>
