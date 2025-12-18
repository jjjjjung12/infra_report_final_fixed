<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>스크립트 관리 - WIZMIG</title>
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
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            padding: 30px;
        }
        
        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
            padding-bottom: 20px;
            border-bottom: 2px solid #e0e0e0;
        }
        
        h1 {
            color: #333;
            font-size: 28px;
        }
        
        .session-selector {
            margin-bottom: 20px;
            padding: 15px;
            background-color: #f8f9fa;
            border-radius: 4px;
        }
        
        .session-selector label {
            font-weight: 600;
            margin-right: 10px;
        }
        
        .session-selector select {
            padding: 8px 12px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 14px;
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
        
        .btn-warning {
            background-color: #ffc107;
            color: #212529;
        }
        
        .btn-danger {
            background-color: #dc3545;
            color: white;
        }
        
        .btn-sm {
            padding: 6px 12px;
            font-size: 12px;
        }
        
        .scripts-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 20px;
            margin-top: 20px;
        }
        
        .script-card {
            border: 1px solid #ddd;
            border-radius: 8px;
            padding: 20px;
            background-color: #fff;
            transition: transform 0.2s, box-shadow 0.2s;
        }
        
        .script-card:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0,0,0,0.15);
        }
        
        .script-name {
            font-size: 18px;
            font-weight: 600;
            color: #333;
            margin-bottom: 10px;
            word-break: break-all;
        }
        
        .script-path {
            font-size: 12px;
            color: #6c757d;
            margin-bottom: 15px;
            word-break: break-all;
        }
        
        .script-actions {
            display: flex;
            gap: 8px;
            flex-wrap: wrap;
        }
        
        .empty-state {
            text-align: center;
            padding: 60px 20px;
            color: #6c757d;
        }
        
        .empty-state-icon {
            font-size: 64px;
            margin-bottom: 20px;
        }
        
        .modal {
            display: none;
            position: fixed;
            z-index: 1000;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0,0,0,0.5);
        }
        
        .modal-content {
            background-color: white;
            margin: 50px auto;
            padding: 30px;
            border-radius: 8px;
            width: 80%;
            max-width: 800px;
            max-height: 80vh;
            overflow-y: auto;
        }
        
        .modal-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
            padding-bottom: 15px;
            border-bottom: 2px solid #e0e0e0;
        }
        
        .close {
            font-size: 28px;
            font-weight: bold;
            color: #aaa;
            cursor: pointer;
        }
        
        .close:hover {
            color: #000;
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
        .form-group textarea {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 14px;
        }
        
        .form-group textarea {
            font-family: 'Courier New', monospace;
            min-height: 300px;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>📄 스크립트 관리</h1>
            <div>
                <a href="${pageContext.request.contextPath}/wizmig/session/list" class="btn btn-primary">
                    🖥️ 세션 관리
                </a>
            </div>
        </div>
        
        <!-- 세션 선택 -->
        <div class="session-selector">
            <label>세션 선택:</label>
            <select id="sessionSelect" onchange="loadScripts()">
                <option value="">-- 세션을 선택하세요 --</option>
            </select>
            <button onclick="showCreateModal()" class="btn btn-success" id="createBtn" style="display: none;">
                ➕ 새 스크립트
            </button>
        </div>
        
        <!-- 스크립트 목록 -->
        <div id="scriptsContainer">
            <div class="empty-state">
                <div class="empty-state-icon">📝</div>
                <h3>세션을 선택하세요</h3>
                <p style="margin-top: 10px;">스크립트를 관리할 세션을 선택해주세요.</p>
            </div>
        </div>
    </div>
    
    <!-- 스크립트 생성/수정 모달 -->
    <div id="scriptModal" class="modal">
        <div class="modal-content">
            <div class="modal-header">
                <h2 id="modalTitle">새 스크립트</h2>
                <span class="close" onclick="closeModal()">&times;</span>
            </div>
            <form id="scriptForm">
                <div class="form-group">
                    <label>스크립트 이름 *</label>
                    <input type="text" id="scriptName" placeholder="script.sh" required>
                </div>
                <div class="form-group">
                    <label>스크립트 내용 *</label>
                    <textarea id="scriptContent" placeholder="#!/bin/bash&#10;echo 'Hello World'" required></textarea>
                </div>
                <div style="display: flex; gap: 10px;">
                    <button type="submit" class="btn btn-primary">💾 저장</button>
                    <button type="button" onclick="closeModal()" class="btn btn-danger">❌ 취소</button>
                </div>
            </form>
        </div>
    </div>
    
    <!-- 스크립트 내용 보기 모달 -->
    <div id="viewModal" class="modal">
        <div class="modal-content">
            <div class="modal-header">
                <h2 id="viewModalTitle">스크립트 내용</h2>
                <span class="close" onclick="closeViewModal()">&times;</span>
            </div>
            <pre id="viewModalContent" style="background: #f8f9fa; padding: 20px; border-radius: 4px; overflow-x: auto;"></pre>
            <button onclick="closeViewModal()" class="btn btn-primary" style="margin-top: 20px;">닫기</button>
        </div>
    </div>
    
    <script>
        let currentSession = null;
        let editingScript = null;
        
        // 페이지 로드 시 세션 목록 가져오기
        window.onload = function() {
            loadSessions();
        };
        
        // 세션 목록 로드
        function loadSessions() {
            fetch('${pageContext.request.contextPath}/wizmig/session/api/list')
                .then(response => response.json())
                .then(data => {
                    if (data.success) {
                        const select = document.getElementById('sessionSelect');
                        select.innerHTML = '<option value="">-- 세션을 선택하세요 --</option>';
                        
                        data.sessions.forEach(session => {
                            const option = document.createElement('option');
                            option.value = session.sessionName;
                            option.textContent = session.sessionName + ' (' + session.host + ')';
                            select.appendChild(option);
                        });
                    }
                })
                .catch(error => {
                    console.error('세션 목록 로드 실패:', error);
                });
        }
        
        // 스크립트 목록 로드
        function loadScripts() {
            const sessionName = document.getElementById('sessionSelect').value;
            if (!sessionName) {
                document.getElementById('scriptsContainer').innerHTML = `
                    <div class="empty-state">
                        <div class="empty-state-icon">📝</div>
                        <h3>세션을 선택하세요</h3>
                        <p style="margin-top: 10px;">스크립트를 관리할 세션을 선택해주세요.</p>
                    </div>
                `;
                document.getElementById('createBtn').style.display = 'none';
                return;
            }
            
            currentSession = sessionName;
            document.getElementById('createBtn').style.display = 'inline-block';
            
            fetch('${pageContext.request.contextPath}/wizmig/script/api/list?session=' + sessionName)
                .then(response => response.json())
                .then(data => {
                    if (data.success) {
                        displayScripts(data.scripts);
                    } else {
                        alert('오류: ' + data.message);
                    }
                })
                .catch(error => {
                    alert('스크립트 목록 로드 실패: ' + error);
                });
        }
        
        // 스크립트 목록 표시
        function displayScripts(scripts) {
            const container = document.getElementById('scriptsContainer');
            
            if (scripts.length === 0) {
                container.innerHTML = `
                    <div class="empty-state">
                        <div class="empty-state-icon">📝</div>
                        <h3>스크립트가 없습니다</h3>
                        <p style="margin-top: 10px;">새 스크립트를 생성하세요.</p>
                    </div>
                `;
                return;
            }
            
            let html = '<div class="scripts-grid">';
            scripts.forEach(script => {
                html += `
                    <div class="script-card">
                        <div class="script-name">📄 \${script.name}</div>
                        <div class="script-path">\${script.path}</div>
                        <div class="script-actions">
                            <button onclick="executeScript('\${script.path}')" class="btn btn-success btn-sm">
                                ▶ 실행
                            </button>
                            <button onclick="viewScript('\${script.name}', '\${script.path}')" class="btn btn-primary btn-sm">
                                👁 보기
                            </button>
                            <button onclick="editScript('\${script.name}', '\${script.path}')" class="btn btn-warning btn-sm">
                                ✏️ 수정
                            </button>
                            <button onclick="deleteScript('\${script.path}')" class="btn btn-danger btn-sm">
                                🗑️ 삭제
                            </button>
                        </div>
                    </div>
                `;
            });
            html += '</div>';
            
            container.innerHTML = html;
        }
        
        // 스크립트 실행
        function executeScript(scriptPath) {
            if (!confirm('스크립트를 실행하시겠습니까?')) {
                return;
            }
            
            fetch('${pageContext.request.contextPath}/wizmig/script/api/execute', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({
                    sessionName: currentSession,
                    scriptPath: scriptPath
                })
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    alert('✅ 스크립트 실행 완료\n\n' + data.output);
                } else {
                    alert('❌ 실행 실패: ' + data.message);
                }
            })
            .catch(error => {
                alert('실행 오류: ' + error);
            });
        }
        
        // 스크립트 보기
        function viewScript(name, path) {
            fetch('${pageContext.request.contextPath}/wizmig/script/api/content?session=' + currentSession + '&path=' + encodeURIComponent(path))
                .then(response => response.json())
                .then(data => {
                    if (data.success) {
                        document.getElementById('viewModalTitle').textContent = name;
                        document.getElementById('viewModalContent').textContent = data.content;
                        document.getElementById('viewModal').style.display = 'block';
                    } else {
                        alert('오류: ' + data.message);
                    }
                })
                .catch(error => {
                    alert('내용 로드 실패: ' + error);
                });
        }
        
        // 스크립트 수정
        function editScript(name, path) {
            fetch('${pageContext.request.contextPath}/wizmig/script/api/content?session=' + currentSession + '&path=' + encodeURIComponent(path))
                .then(response => response.json())
                .then(data => {
                    if (data.success) {
                        editingScript = path;
                        document.getElementById('modalTitle').textContent = '스크립트 수정';
                        document.getElementById('scriptName').value = name;
                        document.getElementById('scriptName').readOnly = true;
                        document.getElementById('scriptContent').value = data.content;
                        document.getElementById('scriptModal').style.display = 'block';
                    } else {
                        alert('오류: ' + data.message);
                    }
                })
                .catch(error => {
                    alert('내용 로드 실패: ' + error);
                });
        }
        
        // 스크립트 삭제
        function deleteScript(path) {
            if (!confirm('스크립트를 삭제하시겠습니까?')) {
                return;
            }
            
            fetch('${pageContext.request.contextPath}/wizmig/script/api/delete', {
                method: 'DELETE',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({
                    sessionName: currentSession,
                    scriptPath: path
                })
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    alert('✅ 삭제되었습니다.');
                    loadScripts();
                } else {
                    alert('❌ 삭제 실패: ' + data.message);
                }
            })
            .catch(error => {
                alert('삭제 오류: ' + error);
            });
        }
        
        // 생성 모달 열기
        function showCreateModal() {
            editingScript = null;
            document.getElementById('modalTitle').textContent = '새 스크립트';
            document.getElementById('scriptName').value = '';
            document.getElementById('scriptName').readOnly = false;
            document.getElementById('scriptContent').value = '#!/bin/bash\n\necho "Hello World"\n';
            document.getElementById('scriptModal').style.display = 'block';
        }
        
        // 모달 닫기
        function closeModal() {
            document.getElementById('scriptModal').style.display = 'none';
        }
        
        function closeViewModal() {
            document.getElementById('viewModal').style.display = 'none';
        }
        
        // 스크립트 폼 제출
        document.getElementById('scriptForm').addEventListener('submit', function(e) {
            e.preventDefault();
            
            const name = document.getElementById('scriptName').value;
            const content = document.getElementById('scriptContent').value;
            
            const url = editingScript 
                ? '${pageContext.request.contextPath}/wizmig/script/api/update'
                : '${pageContext.request.contextPath}/wizmig/script/api/create';
            
            fetch(url, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({
                    sessionName: currentSession,
                    scriptName: name,
                    content: content
                })
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    alert('✅ 저장되었습니다.');
                    closeModal();
                    loadScripts();
                } else {
                    alert('❌ 저장 실패: ' + data.message);
                }
            })
            .catch(error => {
                alert('저장 오류: ' + error);
            });
        });
    </script>
</body>
</html>
