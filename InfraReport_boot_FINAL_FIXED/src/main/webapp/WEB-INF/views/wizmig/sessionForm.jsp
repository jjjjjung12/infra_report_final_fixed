<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${mode == 'edit' ? '세션 수정' : '새 세션 등록'} - WIZMIG</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            padding: 20px;
        }
        
        .container {
            max-width: 800px;
            margin: 0 auto;
        }
        
        .header {
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
            margin-bottom: 30px;
        }
        
        .header h1 {
            color: #333;
            margin-bottom: 10px;
        }
        
        .header p {
            color: #666;
        }
        
        .form-container {
            background: white;
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
        }
        
        .form-group {
            margin-bottom: 25px;
        }
        
        .form-group label {
            display: block;
            font-weight: bold;
            color: #2d3748;
            margin-bottom: 8px;
        }
        
        .form-group label .required {
            color: #f56565;
        }
        
        .form-group input,
        .form-group select {
            width: 100%;
            padding: 12px 15px;
            border: 2px solid #e2e8f0;
            border-radius: 5px;
            font-size: 14px;
            transition: border-color 0.3s;
        }
        
        .form-group input:focus,
        .form-group select:focus {
            outline: none;
            border-color: #667eea;
        }
        
        .form-group small {
            display: block;
            color: #718096;
            margin-top: 5px;
            font-size: 12px;
        }
        
        .form-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
        }
        
        .auth-section {
            background: #f7fafc;
            padding: 20px;
            border-radius: 5px;
            border-left: 4px solid #667eea;
        }
        
        .auth-section h3 {
            color: #2d3748;
            margin-bottom: 15px;
            font-size: 16px;
        }
        
        .form-actions {
            display: flex;
            gap: 15px;
            margin-top: 30px;
            padding-top: 30px;
            border-top: 2px solid #e2e8f0;
        }
        
        .btn {
            padding: 12px 30px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 14px;
            font-weight: bold;
            transition: all 0.3s;
            text-decoration: none;
            display: inline-block;
        }
        
        .btn-primary {
            background: #667eea;
            color: white;
            flex: 1;
        }
        
        .btn-primary:hover {
            background: #5568d3;
        }
        
        .btn-secondary {
            background: #e2e8f0;
            color: #2d3748;
        }
        
        .btn-secondary:hover {
            background: #cbd5e0;
        }
        
        .btn-success {
            background: #48bb78;
            color: white;
        }
        
        .btn-success:hover {
            background: #38a169;
        }
        
        .info-box {
            background: #ebf8ff;
            border-left: 4px solid #4299e1;
            padding: 15px;
            border-radius: 5px;
            margin-bottom: 25px;
        }
        
        .info-box h4 {
            color: #2c5282;
            margin-bottom: 8px;
            font-size: 14px;
        }
        
        .info-box p {
            color: #2c5282;
            font-size: 13px;
            line-height: 1.6;
        }
        
        .radio-group {
            display: flex;
            gap: 20px;
        }
        
        .radio-group label {
            display: flex;
            align-items: center;
            cursor: pointer;
        }
        
        .radio-group input[type="radio"] {
            width: auto;
            margin-right: 8px;
        }
    </style>
</head>
<body>
    <div class="container">
        <!-- Header -->
        <div class="header">
            <h1>${mode == 'edit' ? '✏️ 세션 수정' : '➕ 새 세션 등록'}</h1>
            <p>${mode == 'edit' ? '기존 세션 정보를 수정합니다' : '원격 서버에 SSH로 연결할 세션을 등록합니다'}</p>
        </div>
        
        <!-- Form -->
        <div class="form-container">
            <div class="info-box">
                <h4>💡 SSH 연결 정보</h4>
                <p>
                    원격 서버에 SSH로 접속하여 스크립트를 실행합니다. 
                    원격 서버에는 <strong>SSH 서버만 실행 중</strong>이면 되며, 별도 에이전트 설치가 필요 없습니다.
                </p>
            </div>
            
            <form id="sessionForm">
                <!-- 기본 정보 -->
                <div class="form-group">
                    <label>세션명 <span class="required">*</span></label>
                    <input type="text" id="sessionName" name="sessionName" 
                           value="${session.sessionName}" 
                           placeholder="예: 운영서버1" 
                           required ${mode == 'edit' ? 'readonly' : ''}>
                    <small>세션을 구분할 고유한 이름을 입력하세요</small>
                </div>
                
                <div class="form-row">
                    <div class="form-group">
                        <label>호스트 <span class="required">*</span></label>
                        <input type="text" id="host" name="host" 
                               value="${session.host}" 
                               placeholder="192.168.1.100" 
                               required>
                        <small>원격 서버의 IP 또는 도메인</small>
                    </div>
                    
                    <div class="form-group">
                        <label>포트 <span class="required">*</span></label>
                        <input type="number" id="port" name="port" 
                               value="${session.port != null ? session.port : 22}" 
                               placeholder="22" 
                               required>
                        <small>SSH 포트 (기본: 22)</small>
                    </div>
                </div>
                
                <!-- 인증 정보 -->
                <div class="auth-section">
                    <h3>🔐 인증 정보</h3>
                    
                    <div class="form-group">
                        <label>사용자명 <span class="required">*</span></label>
                        <input type="text" id="username" name="username" 
                               value="${session.username}" 
                               placeholder="user" 
                               required>
                    </div>
                    
                    <div class="form-group">
                        <label>인증 방식</label>
                        <div class="radio-group">
                            <label>
                                <input type="radio" name="authType" value="password" checked>
                                비밀번호
                            </label>
                            <label>
                                <input type="radio" name="authType" value="key">
                                SSH 키
                            </label>
                        </div>
                    </div>
                    
                    <div class="form-group" id="passwordGroup">
                        <label>비밀번호</label>
                        <input type="password" id="password" name="password" 
                               value="${session.password}" 
                               placeholder="비밀번호 입력">
                        <small>비밀번호를 입력하세요</small>
                    </div>
                    
                    <div class="form-group" id="keyGroup" style="display: none;">
                        <label>SSH 키 파일 경로</label>
                        <input type="text" id="privateKeyPath" name="privateKeyPath" 
                               value="${session.privateKeyPath}" 
                               placeholder="/home/user/.ssh/id_rsa">
                        <small>개인 키 파일의 절대 경로를 입력하세요</small>
                    </div>
                </div>
                
                <!-- 스크립트 디렉토리 -->
                <div class="form-group">
                    <label>스크립트 디렉토리 <span class="required">*</span></label>
                    <input type="text" id="directory" name="directory" 
                           value="${session.directory}" 
                           placeholder="/home/user/scripts" 
                           required>
                    <small>스크립트 파일이 저장된 디렉토리 경로</small>
                </div>
                
                <!-- DB Profile (선택사항) -->
                <div class="form-group">
                    <label>DB2 Profile 경로 (선택사항)</label>
                    <input type="text" id="dbProfile" name="dbProfile" 
                           value="${session.dbProfile}" 
                           placeholder="/home/db2inst1/sqllib/db2profile">
                    <small>DB2 환경이 필요한 경우 프로파일 경로를 입력하세요</small>
                </div>
                
                <!-- Actions -->
                <div class="form-actions">
                    <button type="button" onclick="testConnection()" class="btn btn-success">
                        🔌 연결 테스트
                    </button>
                    <button type="submit" class="btn btn-primary">
                        💾 저장
                    </button>
                    <a href="${pageContext.request.contextPath}/wizmig/session/list" class="btn btn-secondary">
                        ❌ 취소
                    </a>
                </div>
            </form>
        </div>
    </div>
    
    <script>
        const mode = '${mode}';
        const originalSessionName = '${session.sessionName}';
        
        // 인증 방식 변경
        document.querySelectorAll('input[name="authType"]').forEach(radio => {
            radio.addEventListener('change', function() {
                const passwordGroup = document.getElementById('passwordGroup');
                const keyGroup = document.getElementById('keyGroup');
                
                if (this.value === 'password') {
                    passwordGroup.style.display = 'block';
                    keyGroup.style.display = 'none';
                } else {
                    passwordGroup.style.display = 'none';
                    keyGroup.style.display = 'block';
                }
            });
        });
        
        // 연결 테스트
        function testConnection() {
            const formData = getFormData();
            
            if (!validateForm(formData)) {
                return;
            }
            
            const btn = event.target;
            btn.disabled = true;
            btn.textContent = '⏳ 테스트 중...';
            
            fetch('${pageContext.request.contextPath}/wizmig/session/api/test', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify(formData)
            })
            .then(response => response.json())
            .then(data => {
                btn.disabled = false;
                btn.textContent = '🔌 연결 테스트';
                
                if (data.success) {
                    alert('✅ ' + data.message);
                } else {
                    alert('❌ ' + data.message);
                }
            })
            .catch(error => {
                btn.disabled = false;
                btn.textContent = '🔌 연결 테스트';
                alert('❌ 연결 테스트 실패: ' + error.message);
            });
        }
        
        // 폼 제출
        document.getElementById('sessionForm').addEventListener('submit', function(e) {
            e.preventDefault();
            
            const formData = getFormData();
            
            if (!validateForm(formData)) {
                return;
            }
            
            const url = mode === 'edit' 
                ? '${pageContext.request.contextPath}/wizmig/session/api/update/' + originalSessionName
                : '${pageContext.request.contextPath}/wizmig/session/api/save';
            
            const method = mode === 'edit' ? 'PUT' : 'POST';
            
            fetch(url, {
                method: method,
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify(formData)
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    alert('✅ ' + data.message);
                    window.location.href = '${pageContext.request.contextPath}/wizmig/session/list';
                } else {
                    alert('❌ ' + data.message);
                }
            })
            .catch(error => {
                alert('❌ 저장 실패: ' + error.message);
            });
        });
        
        // 폼 데이터 가져오기
        function getFormData() {
            const authType = document.querySelector('input[name="authType"]:checked').value;
            
            return {
                sessionName: document.getElementById('sessionName').value.trim(),
                host: document.getElementById('host').value.trim(),
                port: parseInt(document.getElementById('port').value),
                username: document.getElementById('username').value.trim(),
                password: authType === 'password' ? document.getElementById('password').value : '',
                privateKeyPath: authType === 'key' ? document.getElementById('privateKeyPath').value.trim() : '',
                directory: document.getElementById('directory').value.trim(),
                dbProfile: document.getElementById('dbProfile').value.trim()
            };
        }
        
        // 폼 유효성 검사
        function validateForm(formData) {
            if (!formData.sessionName) {
                alert('세션명을 입력하세요.');
                return false;
            }
            
            if (!formData.host) {
                alert('호스트를 입력하세요.');
                return false;
            }
            
            if (!formData.port || formData.port < 1 || formData.port > 65535) {
                alert('올바른 포트 번호를 입력하세요 (1-65535).');
                return false;
            }
            
            if (!formData.username) {
                alert('사용자명을 입력하세요.');
                return false;
            }
            
            const authType = document.querySelector('input[name="authType"]:checked').value;
            if (authType === 'password' && !formData.password) {
                alert('비밀번호를 입력하세요.');
                return false;
            }
            
            if (authType === 'key' && !formData.privateKeyPath) {
                alert('SSH 키 파일 경로를 입력하세요.');
                return false;
            }
            
            if (!formData.directory) {
                alert('스크립트 디렉토리를 입력하세요.');
                return false;
            }
            
            return true;
        }
    </script>
</body>
</html>
