<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>실행 계획 생성 - WIZMIG Scheduler</title>
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
            max-width: 1200px;
            margin: 0 auto;
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            padding: 30px;
        }
        
        .header {
            margin-bottom: 30px;
            padding-bottom: 20px;
            border-bottom: 2px solid #e0e0e0;
        }
        
        h1 {
            color: #333;
            font-size: 28px;
            margin-bottom: 10px;
        }
        
        .breadcrumb {
            color: #6c757d;
            font-size: 14px;
        }
        
        .breadcrumb a {
            color: #007bff;
            text-decoration: none;
        }
        
        .form-section {
            margin-bottom: 30px;
        }
        
        .form-section h2 {
            font-size: 20px;
            color: #333;
            margin-bottom: 15px;
            padding-bottom: 10px;
            border-bottom: 1px solid #e0e0e0;
        }
        
        .form-group {
            margin-bottom: 20px;
        }
        
        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 600;
            color: #333;
        }
        
        .form-group input,
        .form-group select,
        .form-group textarea {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 14px;
        }
        
        .form-group textarea {
            resize: vertical;
            min-height: 80px;
        }
        
        .form-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
        }
        
        .steps-container {
            margin-top: 30px;
        }
        
        .step-card {
            border: 1px solid #ddd;
            border-radius: 8px;
            padding: 20px;
            margin-bottom: 15px;
            background-color: #f8f9fa;
        }
        
        .step-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 15px;
        }
        
        .step-number {
            font-size: 18px;
            font-weight: 600;
            color: #007bff;
        }
        
        .step-actions {
            display: flex;
            gap: 8px;
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
        
        .btn-primary:hover {
            background-color: #0056b3;
        }
        
        .btn-success {
            background-color: #28a745;
            color: white;
        }
        
        .btn-success:hover {
            background-color: #218838;
        }
        
        .btn-danger {
            background-color: #dc3545;
            color: white;
        }
        
        .btn-danger:hover {
            background-color: #c82333;
        }
        
        .btn-secondary {
            background-color: #6c757d;
            color: white;
        }
        
        .btn-sm {
            padding: 6px 12px;
            font-size: 12px;
        }
        
        .empty-steps {
            text-align: center;
            padding: 40px;
            color: #6c757d;
            border: 2px dashed #ddd;
            border-radius: 8px;
        }
        
        .form-actions {
            margin-top: 30px;
            padding-top: 20px;
            border-top: 2px solid #e0e0e0;
            display: flex;
            gap: 10px;
        }
        
        .info-box {
            background-color: #e7f3ff;
            border-left: 4px solid #007bff;
            padding: 15px;
            margin-bottom: 20px;
            border-radius: 4px;
        }
        
        .info-box p {
            color: #004085;
            font-size: 14px;
            line-height: 1.6;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>📋 실행 계획 생성</h1>
            <div class="breadcrumb">
                <a href="${pageContext.request.contextPath}/wizmig/session/list">세션 관리</a> &gt;
                <a href="${pageContext.request.contextPath}/wizmig/execution-plan/list">실행 계획</a> &gt;
                생성
            </div>
        </div>
        
        <div class="info-box">
            <p>
                📌 실행 계획은 여러 스크립트를 순차적으로 실행하는 워크플로우입니다.<br>
                각 단계마다 타임아웃, 에러 처리, 재시도 등을 설정할 수 있습니다.
            </p>
        </div>
        
        <!-- 기본 정보 -->
        <div class="form-section">
            <h2>📝 기본 정보</h2>
            
            <div class="form-group">
                <label>계획명 *</label>
                <input type="text" id="planName" placeholder="예: 일일 백업 및 배포" required>
            </div>
            
            <div class="form-group">
                <label>세션 *</label>
                <select id="sessionName" required>
                    <option value="">-- 세션 선택 --</option>
                </select>
            </div>
            
            <div class="form-group">
                <label>설명</label>
                <textarea id="description" placeholder="실행 계획에 대한 설명을 입력하세요"></textarea>
            </div>
        </div>
        
        <!-- 실행 단계 -->
        <div class="form-section">
            <h2>🔢 실행 단계</h2>
            
            <button onclick="addStep()" class="btn btn-success" style="margin-bottom: 20px;">
                ➕ 단계 추가
            </button>
            
            <div id="stepsContainer" class="steps-container">
                <div class="empty-steps">
                    <div style="font-size: 48px; margin-bottom: 10px;">📋</div>
                    <p>아직 추가된 단계가 없습니다</p>
                    <p style="font-size: 12px; margin-top: 5px;">위 버튼을 클릭하여 단계를 추가하세요</p>
                </div>
            </div>
        </div>
        
        <!-- 액션 버튼 -->
        <div class="form-actions">
            <button onclick="savePlan()" class="btn btn-primary">
                💾 저장
            </button>
            <a href="${pageContext.request.contextPath}/wizmig/execution-plan/list" class="btn btn-secondary">
                ❌ 취소
            </a>
        </div>
    </div>
    
    <script>
        let stepCounter = 0;
        const steps = [];
        
        // 페이지 로드 시 세션 목록 가져오기
        window.onload = function() {
            loadSessions();
            
            // URL 파라미터에서 세션명 가져오기
            const urlParams = new URLSearchParams(window.location.search);
            const sessionName = urlParams.get('sessionName');
            if (sessionName) {
                setTimeout(() => {
                    document.getElementById('sessionName').value = sessionName;
                    loadScripts(sessionName);
                }, 500);
            }
        };
        
        // 세션 목록 로드
        function loadSessions() {
            fetch('${pageContext.request.contextPath}/wizmig/session/api/list')
                .then(response => response.json())
                .then(data => {
                    if (data.success) {
                        const select = document.getElementById('sessionName');
                        data.sessions.forEach(session => {
                            const option = document.createElement('option');
                            option.value = session.sessionName;
                            option.textContent = session.sessionName;
                            select.appendChild(option);
                        });
                    }
                })
                .catch(error => {
                    console.error('세션 목록 로드 실패:', error);
                });
        }
        
        // 세션 변경 시 스크립트 목록 로드
        document.addEventListener('DOMContentLoaded', function() {
            const sessionSelect = document.getElementById('sessionName');
            if (sessionSelect) {
                sessionSelect.addEventListener('change', function() {
                    loadScripts(this.value);
                });
            }
        });
        
        let availableScripts = [];
        
        // 스크립트 목록 로드
        function loadScripts(sessionName) {
            if (!sessionName) {
                availableScripts = [];
                return;
            }
            
            fetch('${pageContext.request.contextPath}/wizmig/script/api/list?session=' + sessionName)
                .then(response => response.json())
                .then(data => {
                    if (data.success) {
                        availableScripts = data.scripts;
                    }
                })
                .catch(error => {
                    console.error('스크립트 목록 로드 실패:', error);
                });
        }
        
        // 단계 추가
        function addStep() {
            stepCounter++;
            const stepId = 'step_' + stepCounter;
            
            const stepHtml = `
                <div class="step-card" id="\${stepId}">
                    <div class="step-header">
                        <div class="step-number">📍 단계 \${stepCounter}</div>
                        <div class="step-actions">
                            <button onclick="moveStepUp('\${stepId}')" class="btn btn-secondary btn-sm" title="위로">
                                ⬆
                            </button>
                            <button onclick="moveStepDown('\${stepId}')" class="btn btn-secondary btn-sm" title="아래로">
                                ⬇
                            </button>
                            <button onclick="removeStep('\${stepId}')" class="btn btn-danger btn-sm">
                                🗑️ 삭제
                            </button>
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <label>스크립트 선택 *</label>
                        <select class="step-script" required>
                            <option value="">-- 스크립트 선택 --</option>
                        </select>
                    </div>
                    
                    <div class="form-row">
                        <div class="form-group">
                            <label>타임아웃 (분)</label>
                            <input type="number" class="step-timeout" value="10" min="1">
                        </div>
                        <div class="form-group">
                            <label>타임아웃 시 동작</label>
                            <select class="step-timeout-action">
                                <option value="FAIL">실패 처리</option>
                                <option value="SKIP">다음 단계로</option>
                                <option value="CONTINUE">계속 진행</option>
                            </select>
                        </div>
                    </div>
                    
                    <div class="form-row">
                        <div class="form-group">
                            <label>에러 발생 시 동작</label>
                            <select class="step-error-action">
                                <option value="FAIL">실패 처리</option>
                                <option value="SKIP">다음 단계로</option>
                                <option value="RETRY">재시도</option>
                                <option value="CONTINUE">계속 진행</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label>최대 재시도 횟수</label>
                            <input type="number" class="step-max-retries" value="3" min="0">
                        </div>
                    </div>
                </div>
            `;
            
            const container = document.getElementById('stepsContainer');
            if (container.querySelector('.empty-steps')) {
                container.innerHTML = '';
            }
            container.insertAdjacentHTML('beforeend', stepHtml);
            
            // 스크립트 옵션 추가
            updateScriptOptions();
        }
        
        // 스크립트 옵션 업데이트
        function updateScriptOptions() {
            const scriptSelects = document.querySelectorAll('.step-script');
            scriptSelects.forEach(select => {
                if (select.options.length <= 1) {
                    availableScripts.forEach(script => {
                        const option = document.createElement('option');
                        option.value = script.path;
                        option.textContent = script.name;
                        select.appendChild(option);
                    });
                }
            });
        }
        
        // 단계 제거
        function removeStep(stepId) {
            if (confirm('이 단계를 삭제하시겠습니까?')) {
                document.getElementById(stepId).remove();
                
                const container = document.getElementById('stepsContainer');
                if (container.children.length === 0) {
                    container.innerHTML = `
                        <div class="empty-steps">
                            <div style="font-size: 48px; margin-bottom: 10px;">📋</div>
                            <p>아직 추가된 단계가 없습니다</p>
                            <p style="font-size: 12px; margin-top: 5px;">위 버튼을 클릭하여 단계를 추가하세요</p>
                        </div>
                    `;
                }
                
                renumberSteps();
            }
        }
        
        // 단계 순서 변경
        function moveStepUp(stepId) {
            const step = document.getElementById(stepId);
            const prev = step.previousElementSibling;
            if (prev) {
                step.parentNode.insertBefore(step, prev);
                renumberSteps();
            }
        }
        
        function moveStepDown(stepId) {
            const step = document.getElementById(stepId);
            const next = step.nextElementSibling;
            if (next) {
                step.parentNode.insertBefore(next, step);
                renumberSteps();
            }
        }
        
        // 단계 번호 다시 매기기
        function renumberSteps() {
            const steps = document.querySelectorAll('.step-card');
            steps.forEach((step, index) => {
                step.querySelector('.step-number').textContent = '📍 단계 ' + (index + 1);
            });
        }
        
        // 실행 계획 저장
        function savePlan() {
            const planName = document.getElementById('planName').value.trim();
            const sessionName = document.getElementById('sessionName').value;
            const description = document.getElementById('description').value.trim();
            
            if (!planName) {
                alert('계획명을 입력하세요.');
                return;
            }
            
            if (!sessionName) {
                alert('세션을 선택하세요.');
                return;
            }
            
            // 단계 수집
            const stepCards = document.querySelectorAll('.step-card');
            if (stepCards.length === 0) {
                alert('최소 1개 이상의 단계를 추가하세요.');
                return;
            }
            
            const steps = [];
            let isValid = true;
            
            stepCards.forEach((card, index) => {
                const scriptPath = card.querySelector('.step-script').value;
                if (!scriptPath) {
                    alert('단계 ' + (index + 1) + '의 스크립트를 선택하세요.');
                    isValid = false;
                    return;
                }
                
                const scriptName = card.querySelector('.step-script').selectedOptions[0].text;
                
                steps.push({
                    stepOrder: index + 1,
                    scriptName: scriptName,
                    scriptPath: scriptPath,
                    timeoutMinutes: parseInt(card.querySelector('.step-timeout').value),
                    onTimeout: card.querySelector('.step-timeout-action').value,
                    onError: card.querySelector('.step-error-action').value,
                    maxRetries: parseInt(card.querySelector('.step-max-retries').value)
                });
            });
            
            if (!isValid) return;
            
            const planData = {
                planName: planName,
                sessionName: sessionName,
                description: description,
                steps: steps
            };
            
            fetch('${pageContext.request.contextPath}/wizmig/execution-plan/api/create', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify(planData)
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    alert('✅ 실행 계획이 생성되었습니다.');
                    window.location.href = '${pageContext.request.contextPath}/wizmig/execution-plan/list';
                } else {
                    alert('❌ 생성 실패: ' + data.message);
                }
            })
            .catch(error => {
                alert('저장 오류: ' + error);
            });
        }
    </script>
</body>
</html>
