<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>실행 계획 상세 - WIZMIG Scheduler</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f5f5f5;
            padding: 20px;
        }
        
        .container {
            max-width: 1400px;
            margin: 0 auto;
        }
        
        .plan-header {
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            padding: 30px;
            margin-bottom: 20px;
        }
        
        .plan-title {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }
        
        .plan-title h1 {
            font-size: 28px;
            color: #333;
        }
        
        .plan-actions {
            display: flex;
            gap: 10px;
        }
        
        .plan-info {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            margin-top: 20px;
            padding-top: 20px;
            border-top: 2px solid #e0e0e0;
        }
        
        .info-item {
            display: flex;
            flex-direction: column;
        }
        
        .info-label {
            font-size: 12px;
            color: #6c757d;
            margin-bottom: 5px;
            font-weight: 600;
            text-transform: uppercase;
        }
        
        .info-value {
            font-size: 16px;
            color: #333;
        }
        
        .status-badge {
            display: inline-block;
            padding: 6px 16px;
            border-radius: 20px;
            font-size: 14px;
            font-weight: 600;
            text-transform: uppercase;
        }
        
        .status-ready {
            background-color: #e7f3ff;
            color: #0056b3;
        }
        
        .status-running {
            background-color: #fff3cd;
            color: #856404;
        }
        
        .status-completed {
            background-color: #d4edda;
            color: #155724;
        }
        
        .status-failed {
            background-color: #f8d7da;
            color: #721c24;
        }
        
        .status-paused {
            background-color: #d1ecf1;
            color: #0c5460;
        }
        
        .steps-container {
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            padding: 30px;
        }
        
        .steps-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
            padding-bottom: 15px;
            border-bottom: 2px solid #e0e0e0;
        }
        
        .step-card {
            border: 2px solid #e0e0e0;
            border-radius: 8px;
            padding: 20px;
            margin-bottom: 15px;
            transition: all 0.3s;
        }
        
        .step-card.running {
            border-color: #ffc107;
            background-color: #fffbf0;
        }
        
        .step-card.completed {
            border-color: #28a745;
            background-color: #f0f8f3;
        }
        
        .step-card.failed {
            border-color: #dc3545;
            background-color: #fdf5f6;
        }
        
        .step-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 15px;
        }
        
        .step-title {
            display: flex;
            align-items: center;
            gap: 15px;
        }
        
        .step-number {
            font-size: 24px;
            font-weight: 700;
            color: #007bff;
        }
        
        .step-name {
            font-size: 18px;
            font-weight: 600;
            color: #333;
        }
        
        .step-status {
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .step-info {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(150px, 1fr));
            gap: 15px;
            font-size: 14px;
            color: #666;
        }
        
        .step-log {
            margin-top: 15px;
            padding: 15px;
            background-color: #2d2d2d;
            border-radius: 4px;
            color: #00ff00;
            font-family: 'Courier New', monospace;
            font-size: 12px;
            max-height: 300px;
            overflow-y: auto;
            white-space: pre-wrap;
            word-wrap: break-word;
        }
        
        .step-log-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 10px;
        }
        
        .step-log-title {
            font-weight: 600;
            color: #333;
        }
        
        .btn {
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 14px;
            text-decoration: none;
            display: inline-block;
            transition: background-color 0.3s;
        }
        
        .btn-primary {
            background-color: #007bff;
            color: white;
        }
        
        .btn-success {
            background-color: #28a745;
            color: white;
        }
        
        .btn-danger {
            background-color: #dc3545;
            color: white;
        }
        
        .btn-secondary {
            background-color: #6c757d;
            color: white;
        }
        
        .btn-sm {
            padding: 6px 12px;
            font-size: 12px;
        }
        
        .progress-bar {
            width: 100%;
            height: 8px;
            background-color: #e9ecef;
            border-radius: 4px;
            overflow: hidden;
            margin-top: 10px;
        }
        
        .progress-fill {
            height: 100%;
            background-color: #007bff;
            transition: width 0.3s;
        }
        
        .spinner {
            display: inline-block;
            width: 16px;
            height: 16px;
            border: 3px solid rgba(0,0,0,.1);
            border-radius: 50%;
            border-top-color: #007bff;
            animation: spin 1s ease-in-out infinite;
        }
        
        @keyframes spin {
            to { transform: rotate(360deg); }
        }
    </style>
</head>
<body>
    <div class="container">
        <!-- 계획 헤더 -->
        <div class="plan-header">
            <div class="plan-title">
                <h1>📋 ${plan.planName}</h1>
                <div class="plan-actions">
                    <c:choose>
                        <c:when test="${plan.status == 'READY' || plan.status == 'PAUSED'}">
                            <button onclick="startPlan()" class="btn btn-success">
                                ▶ 실행
                            </button>
                        </c:when>
                        <c:when test="${plan.status == 'RUNNING'}">
                            <button onclick="stopPlan()" class="btn btn-danger">
                                ⏸ 중지
                            </button>
                        </c:when>
                    </c:choose>
                    <a href="${pageContext.request.contextPath}/wizmig/execution-plan/list" class="btn btn-secondary">
                        ◀ 목록
                    </a>
                </div>
            </div>
            
            <c:if test="${not empty plan.description}">
                <p style="color: #666; margin-top: 10px;">${plan.description}</p>
            </c:if>
            
            <div class="plan-info">
                <div class="info-item">
                    <div class="info-label">상태</div>
                    <div class="info-value">
                        <span class="status-badge status-${fn:toLowerCase(plan.status)}">
                            ${plan.status}
                        </span>
                    </div>
                </div>
                <div class="info-item">
                    <div class="info-label">세션</div>
                    <div class="info-value">${plan.sessionName}</div>
                </div>
                <div class="info-item">
                    <div class="info-label">생성일시</div>
                    <div class="info-value">
                        <fmt:formatDate value="${plan.createdAt}" pattern="yyyy-MM-dd HH:mm:ss" />
                    </div>
                </div>
                <div class="info-item">
                    <div class="info-label">시작일시</div>
                    <div class="info-value">
                        <c:choose>
                            <c:when test="${not empty plan.startedAt}">
                                <fmt:formatDate value="${plan.startedAt}" pattern="yyyy-MM-dd HH:mm:ss" />
                            </c:when>
                            <c:otherwise>-</c:otherwise>
                        </c:choose>
                    </div>
                </div>
                <div class="info-item">
                    <div class="info-label">완료일시</div>
                    <div class="info-value">
                        <c:choose>
                            <c:when test="${not empty plan.completedAt}">
                                <fmt:formatDate value="${plan.completedAt}" pattern="yyyy-MM-dd HH:mm:ss" />
                            </c:when>
                            <c:otherwise>-</c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
            
            <!-- 진행률 -->
            <c:if test="${plan.status == 'RUNNING' || plan.status == 'COMPLETED'}">
                <div class="progress-bar">
                    <div class="progress-fill" id="progressBar" style="width: 0%"></div>
                </div>
            </c:if>
        </div>
        
        <!-- 실행 단계 -->
        <div class="steps-container">
            <div class="steps-header">
                <h2>🔢 실행 단계</h2>
                <button onclick="refreshSteps()" class="btn btn-primary btn-sm">
                    🔄 새로고침
                </button>
            </div>
            
            <div id="stepsContainer">
                <c:forEach items="${steps}" var="step">
                    <div class="step-card ${fn:toLowerCase(step.status)}" id="step-${step.stepId}">
                        <div class="step-header">
                            <div class="step-title">
                                <div class="step-number">${step.stepOrder}</div>
                                <div class="step-name">📄 ${step.scriptName}</div>
                            </div>
                            <div class="step-status">
                                <c:if test="${step.status == 'RUNNING'}">
                                    <div class="spinner"></div>
                                </c:if>
                                <span class="status-badge status-${fn:toLowerCase(step.status)}">
                                    ${step.status}
                                </span>
                            </div>
                        </div>
                        
                        <div class="step-info">
                            <div>📂 경로: ${step.scriptPath}</div>
                            <div>⏱️ 타임아웃: ${step.timeoutMinutes}분</div>
                            <div>❌ 에러 시: ${step.onError}</div>
                            <c:if test="${step.onError == 'RETRY'}">
                                <div>🔄 재시도: ${step.maxRetries}회</div>
                            </c:if>
                        </div>
                        
                        <c:if test="${not empty step.startedAt}">
                            <div class="step-info" style="margin-top: 10px; padding-top: 10px; border-top: 1px solid #e0e0e0;">
                                <div>▶ 시작: <fmt:formatDate value="${step.startedAt}" pattern="HH:mm:ss" /></div>
                                <c:if test="${not empty step.completedAt}">
                                    <div>⏹ 완료: <fmt:formatDate value="${step.completedAt}" pattern="HH:mm:ss" /></div>
                                </c:if>
                                <c:if test="${not empty step.errorMessage}">
                                    <div style="color: #dc3545;">⚠️ ${step.errorMessage}</div>
                                </c:if>
                            </div>
                        </c:if>
                        
                        <!-- 로그 -->
                        <c:if test="${step.status == 'RUNNING' || step.status == 'COMPLETED' || step.status == 'FAILED'}">
                            <div style="margin-top: 15px;">
                                <div class="step-log-header">
                                    <div class="step-log-title">📝 실행 로그</div>
                                    <button onclick="loadLog(${step.stepId}, '${step.logFilePath}')" class="btn btn-primary btn-sm">
                                        🔄 로그 새로고침
                                    </button>
                                </div>
                                <div class="step-log" id="log-${step.stepId}">
                                    로그를 불러오는 중...
                                </div>
                            </div>
                        </c:if>
                    </div>
                </c:forEach>
            </div>
        </div>
    </div>
    
    <script>
        const planId = ${plan.planId};
        
        // 페이지 로드 시 로그 자동 로드
        window.onload = function() {
            <c:forEach items="${steps}" var="step">
                <c:if test="${step.status == 'RUNNING' || step.status == 'COMPLETED' || step.status == 'FAILED'}">
                    loadLog(${step.stepId}, '${step.logFilePath}');
                </c:if>
            </c:forEach>
            
            // 실행 중이면 자동 새로고침
            <c:if test="${plan.status == 'RUNNING'}">
                setInterval(refreshSteps, 3000);
            </c:if>
            
            updateProgress();
        };
        
        // 실행 시작
        function startPlan() {
            if (!confirm('실행 계획을 시작하시겠습니까?')) {
                return;
            }
            
            fetch('${pageContext.request.contextPath}/wizmig/execution-plan/api/' + planId + '/start', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                }
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    alert('✅ 실행이 시작되었습니다.');
                    location.reload();
                } else {
                    alert('❌ 오류: ' + data.message);
                }
            })
            .catch(error => {
                alert('실행 오류: ' + error);
            });
        }
        
        // 실행 중지
        function stopPlan() {
            if (!confirm('실행을 중지하시겠습니까?')) {
                return;
            }
            
            fetch('${pageContext.request.contextPath}/wizmig/execution-plan/api/' + planId + '/stop', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                }
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    alert('✅ 실행이 중지되었습니다.');
                    location.reload();
                } else {
                    alert('❌ 오류: ' + data.message);
                }
            })
            .catch(error => {
                alert('중지 오류: ' + error);
            });
        }
        
        // 단계 상태 새로고침
        function refreshSteps() {
            location.reload();
        }
        
        // 로그 로드
        function loadLog(stepId, logFilePath) {
            const logElement = document.getElementById('log-' + stepId);
            
            fetch('${pageContext.request.contextPath}/wizmig/execution-plan/api/log?stepId=' + stepId + '&logPath=' + encodeURIComponent(logFilePath))
                .then(response => response.json())
                .then(data => {
                    if (data.success) {
                        logElement.textContent = data.log || '로그가 비어있습니다.';
                        // 자동 스크롤
                        logElement.scrollTop = logElement.scrollHeight;
                    } else {
                        logElement.textContent = '로그를 불러올 수 없습니다: ' + data.message;
                    }
                })
                .catch(error => {
                    logElement.textContent = '로그 로드 오류: ' + error;
                });
        }
        
        // 진행률 업데이트
        function updateProgress() {
            const totalSteps = ${steps.size()};
            let completedSteps = 0;
            
            <c:forEach items="${steps}" var="step">
                <c:if test="${step.status == 'COMPLETED'}">
                    completedSteps++;
                </c:if>
            </c:forEach>
            
            const progress = totalSteps > 0 ? (completedSteps / totalSteps * 100) : 0;
            const progressBar = document.getElementById('progressBar');
            if (progressBar) {
                progressBar.style.width = progress + '%';
            }
        }
    </script>
</body>
</html>
