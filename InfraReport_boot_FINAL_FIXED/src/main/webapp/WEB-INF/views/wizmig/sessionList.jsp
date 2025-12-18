<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SSH 세션 관리 - WIZMIG</title>
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
            max-width: 1200px;
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
        
        .toolbar {
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
            margin-bottom: 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        
        .btn {
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 14px;
            transition: all 0.3s;
            text-decoration: none;
            display: inline-block;
        }
        
        .btn-primary {
            background: #667eea;
            color: white;
        }
        
        .btn-primary:hover {
            background: #5568d3;
        }
        
        .btn-success {
            background: #48bb78;
            color: white;
        }
        
        .btn-success:hover {
            background: #38a169;
        }
        
        .btn-danger {
            background: #f56565;
            color: white;
        }
        
        .btn-danger:hover {
            background: #e53e3e;
        }
        
        .btn-warning {
            background: #ed8936;
            color: white;
        }
        
        .btn-warning:hover {
            background: #dd6b20;
        }
        
        .sessions-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(350px, 1fr));
            gap: 20px;
        }
        
        .session-card {
            background: white;
            padding: 25px;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
            transition: transform 0.3s, box-shadow 0.3s;
        }
        
        .session-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 12px rgba(0,0,0,0.2);
        }
        
        .session-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 15px;
            padding-bottom: 15px;
            border-bottom: 2px solid #e2e8f0;
        }
        
        .session-name {
            font-size: 20px;
            font-weight: bold;
            color: #2d3748;
        }
        
        .session-status {
            padding: 5px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: bold;
        }
        
        .status-active {
            background: #c6f6d5;
            color: #22543d;
        }
        
        .session-info {
            margin-bottom: 15px;
        }
        
        .info-row {
            display: flex;
            margin-bottom: 8px;
            font-size: 14px;
        }
        
        .info-label {
            font-weight: bold;
            color: #4a5568;
            width: 80px;
        }
        
        .info-value {
            color: #718096;
        }
        
        .session-actions {
            display: flex;
            gap: 10px;
            margin-top: 15px;
            padding-top: 15px;
            border-top: 1px solid #e2e8f0;
        }
        
        .empty-state {
            background: white;
            padding: 60px;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
            text-align: center;
        }
        
        .empty-state-icon {
            font-size: 64px;
            margin-bottom: 20px;
        }
        
        .empty-state h2 {
            color: #2d3748;
            margin-bottom: 10px;
        }
        
        .empty-state p {
            color: #718096;
            margin-bottom: 20px;
        }
        
        .search-box {
            padding: 10px 15px;
            border: 2px solid #e2e8f0;
            border-radius: 5px;
            font-size: 14px;
            width: 300px;
        }
        
        .search-box:focus {
            outline: none;
            border-color: #667eea;
        }
        
        .badge {
            display: inline-block;
            padding: 3px 8px;
            border-radius: 3px;
            font-size: 11px;
            font-weight: bold;
        }
        
        .badge-info {
            background: #bee3f8;
            color: #2c5282;
        }
    </style>
</head>
<body>
    <div class="container">
        <!-- Header -->
        <div class="header">
            <h1>🖥️ SSH 세션 관리</h1>
            <p>원격 서버 SSH 연결 정보를 관리합니다</p>
        </div>
        
        <!-- Toolbar -->
        <div class="toolbar">
            <input type="text" class="search-box" id="searchBox" placeholder="세션명으로 검색...">
            <div>
                <a href="${pageContext.request.contextPath}/wizmig/session/new" class="btn btn-primary">
                    ➕ 새 세션 등록
                </a>
                <button onclick="refreshList()" class="btn btn-success">
                    🔄 새로고침
                </button>
            </div>
        </div>
        
        <!-- Sessions Grid -->
        <c:choose>
            <c:when test="${empty sessions}">
                <div class="empty-state">
                    <div class="empty-state-icon">📭</div>
                    <h2>등록된 세션이 없습니다</h2>
                    <p>새 SSH 세션을 등록하여 원격 서버를 관리하세요</p>
                    <a href="${pageContext.request.contextPath}/wizmig/session/new" class="btn btn-primary">
                        첫 세션 등록하기
                    </a>
                </div>
            </c:when>
            <c:otherwise>
                <div class="sessions-grid" id="sessionsGrid">
                    <c:forEach var="entry" items="${sessions}">
                        <div class="session-card" data-session-name="${entry.key}">
                            <div class="session-header">
                                <div class="session-name">${entry.key}</div>
                                <div class="session-status status-active">활성</div>
                            </div>
                            
                            <div class="session-info">
                                <div class="info-row">
                                    <div class="info-label">호스트:</div>
                                    <div class="info-value">${entry.value.host}</div>
                                </div>
                                <div class="info-row">
                                    <div class="info-label">포트:</div>
                                    <div class="info-value">${entry.value.port}</div>
                                </div>
                                <div class="info-row">
                                    <div class="info-label">사용자:</div>
                                    <div class="info-value">${entry.value.username}</div>
                                </div>
                                <div class="info-row">
                                    <div class="info-label">디렉토리:</div>
                                    <div class="info-value">${entry.value.directory}</div>
                                </div>
                                <c:if test="${not empty entry.value.dbProfile}">
                                    <div class="info-row">
                                        <div class="info-label">DB Profile:</div>
                                        <div class="info-value">
                                            <span class="badge badge-info">설정됨</span>
                                        </div>
                                    </div>
                                </c:if>
                            </div>
                            
                            <div class="session-actions">
                                <button onclick="testConnection('${entry.key}')" class="btn btn-success" style="flex: 1;">
                                    🔌 연결 테스트
                                </button>
                                <a href="${pageContext.request.contextPath}/wizmig/session/edit/${entry.key}" class="btn btn-warning">
                                    ✏️ 수정
                                </a>
                                <button onclick="deleteSession('${entry.key}')" class="btn btn-danger">
                                    🗑️ 삭제
                                </button>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
    
    <script>
        // 검색 기능
        document.getElementById('searchBox').addEventListener('input', function(e) {
            const searchTerm = e.target.value.toLowerCase();
            const cards = document.querySelectorAll('.session-card');
            
            cards.forEach(card => {
                const sessionName = card.dataset.sessionName.toLowerCase();
                if (sessionName.includes(searchTerm)) {
                    card.style.display = 'block';
                } else {
                    card.style.display = 'none';
                }
            });
        });
        
        // 연결 테스트
        function testConnection(sessionName) {
            const btn = event.target;
            btn.disabled = true;
            btn.textContent = '⏳ 테스트 중...';
            
            fetch('${pageContext.request.contextPath}/wizmig/session/api/info/' + sessionName)
                .then(response => response.json())
                .then(data => {
                    if (data.success) {
                        return fetch('${pageContext.request.contextPath}/wizmig/session/api/test', {
                            method: 'POST',
                            headers: {
                                'Content-Type': 'application/json'
                            },
                            body: JSON.stringify(data.session)
                        });
                    } else {
                        throw new Error(data.message);
                    }
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
        
        // 세션 삭제
        function deleteSession(sessionName) {
            if (!confirm('세션 "' + sessionName + '"을(를) 정말 삭제하시겠습니까?')) {
                return;
            }
            
            fetch('${pageContext.request.contextPath}/wizmig/session/api/delete/' + sessionName, {
                method: 'DELETE'
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    alert('✅ ' + data.message);
                    location.reload();
                } else {
                    alert('❌ ' + data.message);
                }
            })
            .catch(error => {
                alert('❌ 삭제 실패: ' + error.message);
            });
        }
        
        // 새로고침
        function refreshList() {
            location.reload();
        }
    </script>
</body>
</html>
