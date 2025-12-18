<!-- ========================================
시작 페이지
======================================== -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>일일업무보고서 시스템</title>
    
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    
    <style>
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            font-family: 'Malgun Gothic', 'Apple SD Gothic Neo', sans-serif;
        }
        
        .main-container {
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }
        
        .welcome-card {
            background: white;
            border-radius: 20px;
            box-shadow: 0 15px 40px rgba(0,0,0,0.3);
            overflow: hidden;
            max-width: 900px;
            width: 100%;
        }
        
        .welcome-header {
            background: linear-gradient(45deg, #667eea, #764ba2);
            color: white;
            padding: 40px 30px;
            text-align: center;
        }
        
        .welcome-body {
            padding: 40px 30px;
        }
        
        .logo-icon {
            font-size: 3rem;
            margin-bottom: 20px;
            animation: pulse 2s infinite;
        }
        
        @keyframes pulse {
            0% { transform: scale(1); }
            50% { transform: scale(1.05); }
            100% { transform: scale(1); }
        }
        
        .welcome-title {
            font-size: 2.2rem;
            font-weight: bold;
            margin-bottom: 10px;
        }
        
        .welcome-subtitle {
            opacity: 0.9;
            font-size: 1.1rem;
        }
        
        .features-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 20px;
            margin: 30px 0;
        }
        
        .feature-category {
            background: #f8f9fa;
            border-radius: 15px;
            padding: 25px;
            border-left: 5px solid #667eea;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }
        
        .feature-category:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 25px rgba(0,0,0,0.1);
        }
        
        .feature-category h5 {
            color: #667eea;
            font-weight: bold;
            margin-bottom: 15px;
            display: flex;
            align-items: center;
        }
        
        .feature-category h5 i {
            margin-right: 10px;
            font-size: 1.3rem;
        }
        
        .feature-list {
            list-style: none;
            padding: 0;
            margin: 0;
        }
        
        .feature-list li {
            padding: 8px 0;
            border-bottom: 1px solid #eee;
            display: flex;
            align-items: center;
        }
        
        .feature-list li:last-child {
            border-bottom: none;
        }
        
        .feature-icon {
            color: #667eea;
            margin-right: 12px;
            font-size: 0.9rem;
        }
        
        .feature-text {
            flex: 1;
            font-size: 0.95rem;
        }
        
        .start-button {
            background: linear-gradient(45deg, #667eea, #764ba2);
            border: none;
            padding: 18px 50px;
            font-size: 1.2rem;
            font-weight: bold;
            border-radius: 50px;
            transition: transform 0.2s, box-shadow 0.2s;
            color: white;
            text-decoration: none;
            display: inline-block;
            margin: 20px 0;
        }
        
        .start-button:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 25px rgba(0,0,0,0.3);
            color: white;
        }
        
        .system-info {
            background: #f8f9fa;
            padding: 25px;
            margin-top: 30px;
            border-radius: 15px;
            border-left: 4px solid #667eea;
        }
        
        .stats-row {
            display: flex;
            justify-content: space-around;
            margin: 25px 0;
            text-align: center;
        }
        
        .stat-item {
            flex: 1;
        }
        
        .stat-number {
            font-size: 2rem;
            font-weight: bold;
            color: #667eea;
            display: block;
        }
        
        .stat-label {
            font-size: 0.9rem;
            color: #666;
            margin-top: 5px;
        }
        
        .highlight-box {
            background: linear-gradient(135deg, #667eea10, #764ba210);
            border-radius: 10px;
            padding: 20px;
            margin: 20px 0;
            border: 1px solid #667eea30;
        }
        
        .highlight-box h6 {
            color: #667eea;
            font-weight: bold;
            margin-bottom: 10px;
        }
    </style>
</head>
<body>
    <div class="main-container">
        <div class="welcome-card">
            <div class="welcome-header">
                <i class="fas fa-chart-line logo-icon"></i>
                <h1 class="welcome-title">일일업무보고서</h1>
                <p class="welcome-subtitle">Daily Work Report System</p>
                <div class="stats-row">
                    <div class="stat-item">
                        <span class="stat-number">5</span>
                        <div class="stat-label">주요 모듈</div>
                    </div>
                    <div class="stat-item">
                        <span class="stat-number">15+</span>
                        <div class="stat-label">핵심 기능</div>
                    </div>
                    <div class="stat-item">
                        <span class="stat-number">24/7</span>
                        <div class="stat-label">실시간 모니터링</div>
                    </div>
                </div>
            </div>
            
            <div class="welcome-body">
                <div class="highlight-box">
                    <h6><i class="fas fa-star me-2"></i>시스템 특징</h6>
                    <p class="mb-0">통합된 업무관리, 실시간 현황 모니터링, 직관적인 사용자 인터페이스를 통해 
                    일일 업무 보고서 작성과 관리를 효율적으로 지원합니다.</p>
                </div>

                <div class="features-grid">
                    <!-- 업무 관리 기능 -->
                    <div class="feature-category">
                        <h5><i class="fas fa-tasks"></i>업무 관리</h5>
 <!--                       <ul class="feature-list">
                            <li>
                                <i class="fas fa-plus-circle feature-icon"></i>
                                <span class="feature-text">업무 등록 및 수정</span>
                            </li>
                            <li>
                                <i class="fas fa-filter feature-icon"></i>
                                <span class="feature-text">카테고리별 필터링</span>
                            </li>
                            <li>
                                <i class="fas fa-search feature-icon"></i>
                                <span class="feature-text">다중 조건 검색</span>
                            </li>
                            <li>
                                <i class="fas fa-sort feature-icon"></i>
                                <span class="feature-text">다양한 정렬 옵션</span>
                            </li>
                            <li>
                                <i class="fas fa-tag feature-icon"></i>
                                <span class="feature-text">우선순위 관리</span>
                            </li>
                        </ul> -->
                    </div>

                    <!-- 모니터링 기능 -->
                    <div class="feature-category">
                        <h5><i class="fas fa-chart-bar"></i>실시간 모니터링</h5>
 <!--                       <ul class="feature-list">
                            <li>
                                <i class="fas fa-server feature-icon"></i>
                                <span class="feature-text">서버 자원 사용률 모니터링</span>
                            </li>
                            <li>
                                <i class="fas fa-chart-line feature-icon"></i>
                                <span class="feature-text">실시간 그래프 표시</span>
                            </li>
                            <li>
                                <i class="fas fa-clock feature-icon"></i>
                                <span class="feature-text">시간별 모니터링 기록</span>
                            </li>
                            <li>
                                <i class="fas fa-exclamation-triangle feature-icon"></i>
                                <span class="feature-text">임계치 알림 시스템</span>
                            </li>
                            <li>
                                <i class="fas fa-tachometer-alt feature-icon"></i>
                                <span class="feature-text">CPU, 메모리, 디스크 통계</span>
                            </li>
                        </ul> -->
                    </div>

                    <!-- 보안 관리 기능 -->
                    <div class="feature-category">
                        <h5><i class="fas fa-shield-alt"></i>보안 관리</h5>
  <!--                     <ul class="feature-list">
                            <li>
                                <i class="fas fa-eye feature-icon"></i>
                                <span class="feature-text">보안관제 활동 추적</span>
                            </li>
                            <li>
                                <i class="fas fa-ban feature-icon"></i>
                                <span class="feature-text">위협 탐지 및 차단 현황</span>
                            </li>
                            <li>
                                <i class="fas fa-clipboard-check feature-icon"></i>
                                <span class="feature-text">HW/SW 점검 관리</span>
                            </li>
                            <li>
                                <i class="fas fa-history feature-icon"></i>
                                <span class="feature-text">보안 이벤트 이력 관리</span>
                            </li>
                            <li>
                                <i class="fas fa-tools feature-icon"></i>
                                <span class="feature-text">조치사항 추적</span>
                            </li>
                        </ul> -->   
                    </div>

                    <!-- 데이터 관리 기능 -->
                    <div class="feature-category">
                        <h5><i class="fas fa-database"></i>데이터 관리</h5>
 <!--                        <ul class="feature-list">
                            <li>
                                <i class="fas fa-download feature-icon"></i>
                                <span class="feature-text">백업 관리 및 모니터링</span>
                            </li>
                            <li>
                                <i class="fas fa-file-excel feature-icon"></i>
                                <span class="feature-text">엑셀 파일 일괄 업로드</span>
                            </li>
                            <li>
                                <i class="fas fa-file-export feature-icon"></i>
                                <span class="feature-text">보고서 내보내기</span>
                            </li>
                            <li>
                                <i class="fas fa-archive feature-icon"></i>
                                <span class="feature-text">백업 레벨별 관리</span>
                            </li>
                            <li>
                                <i class="fas fa-check-circle feature-icon"></i>
                                <span class="feature-text">백업 상태 추적</span>
                            </li>
                        </ul>--> 
                    </div>

                    <!-- 통계 및 분석 -->
                    <div class="feature-category">
                        <h5><i class="fas fa-analytics"></i>통계 및 분석</h5>
 <!--                      <ul class="feature-list">
                            <li>
                                <i class="fas fa-chart-pie feature-icon"></i>
                                <span class="feature-text">업무유형별 통계</span>
                            </li>
                            <li>
                                <i class="fas fa-percentage feature-icon"></i>
                                <span class="feature-text">정상률 및 장애 분석</span>
                            </li>
                            <li>
                                <i class="fas fa-calendar-alt feature-icon"></i>
                                <span class="feature-text">일별 성과 분석</span>
                            </li>
                            <li>
                                <i class="fas fa-trend-up feature-icon"></i>
                                <span class="feature-text">트렌드 분석</span>
                            </li>
                            <li>
                                <i class="fas fa-chart-area feature-icon"></i>
                                <span class="feature-text">시각적 대시보드</span>
                            </li>
                        </ul>  --> 
                    </div>

                    <!-- 사용자 편의 기능 -->
                    <div class="feature-category">
                        <h5><i class="fas fa-user-cog"></i>사용자 편의</h5>
 <!--                         <ul class="feature-list">
                            <li>
                                <i class="fas fa-mobile-alt feature-icon"></i>
                                <span class="feature-text">반응형 웹 디자인</span>
                            </li>
                            <li>
                                <i class="fas fa-palette feature-icon"></i>
                                <span class="feature-text">직관적인 UI/UX</span>
                            </li>
                            <li>
                                <i class="fas fa-keyboard feature-icon"></i>
                                <span class="feature-text">키보드 단축키 지원</span>
                            </li>
                            <li>
                                <i class="fas fa-undo feature-icon"></i>
                                <span class="feature-text">실시간 새로고침</span>
                            </li>
                            <li>
                                <i class="fas fa-cog feature-icon"></i>
                                <span class="feature-text">사용자 맞춤 설정</span>
                            </li>
                        </ul>  --> 
                    </div>
                </div>

                <div class="text-center">
                    <a href="report" class="start-button">
                        <i class="fas fa-rocket me-2"></i>시스템 시작하기
                    </a>
                </div>
                
                <div class="system-info">
                    <div class="row">
                        <div class="col-md-6">
                            <h6><i class="fas fa-info-circle me-2"></i>시스템 정보</h6>
                            <div class="mb-2"><strong>조직:</strong> 한국교육학술정보원</div>
                            <div class="mb-2"><strong>버전:</strong> 2.0.0</div>
                            <div class="mb-2"><strong>문의:</strong> 시스템관리팀</div>
                            <div><strong>지원:</strong> 24시간 모니터링</div>
                        </div>
                        <div class="col-md-6">
                            <h6><i class="fas fa-rocket me-2"></i>최신 업데이트</h6>
                            <div class="mb-2">✅ 자원 모니터링 시간 필드 추가</div>
                            <div class="mb-2">✅ 테이블 정렬 기능 개선</div>
                            <div class="mb-2">✅ 검색 인터페이스 가로 배치</div>
                            <div>✅ 실시간 그래프 차트 추가</div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
    
    <script>
        // 페이지 로드 애니메이션
        document.addEventListener('DOMContentLoaded', function() {
            const card = document.querySelector('.welcome-card');
            card.style.opacity = '0';
            card.style.transform = 'translateY(30px)';
            
            setTimeout(() => {
                card.style.transition = 'all 0.8s ease';
                card.style.opacity = '1';
                card.style.transform = 'translateY(0)';
            }, 200);

            // 기능 카테고리 순차 애니메이션
            const categories = document.querySelectorAll('.feature-category');
            categories.forEach((category, index) => {
                category.style.opacity = '0';
                category.style.transform = 'translateY(20px)';
                
                setTimeout(() => {
                    category.style.transition = 'all 0.6s ease';
                    category.style.opacity = '1';
                    category.style.transform = 'translateY(0)';
                }, 800 + (index * 200));
            });
        });
        
        // 키보드 단축키
        document.addEventListener('keydown', function(event) {
            if (event.key === 'Enter' && event.ctrlKey) {
                window.location.href = 'report';
            }
        });

        // 통계 숫자 카운트 애니메이션
        function animateStats() {
            const statNumbers = document.querySelectorAll('.stat-number');
            statNumbers.forEach(stat => {
                const target = stat.textContent;
                if (!isNaN(parseInt(target))) {
                    let current = 0;
                    const increment = parseInt(target) / 30;
                    const timer = setInterval(() => {
                        current += increment;
                        if (current >= parseInt(target)) {
                            current = parseInt(target);
                            clearInterval(timer);
                        }
                        stat.textContent = Math.floor(current);
                    }, 50);
                }
            });
        }

        // 3초 후 통계 애니메이션 시작
        setTimeout(animateStats, 1500);

        // 호버 효과 향상
        document.querySelectorAll('.feature-category').forEach(category => {
            category.addEventListener('mouseenter', function() {
                this.style.borderLeftColor = '#764ba2';
            });
            
            category.addEventListener('mouseleave', function() {
                this.style.borderLeftColor = '#667eea';
            });
        });
    </script>
</body>
</html>