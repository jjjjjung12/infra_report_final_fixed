<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>실행 계획 목록 - WIZMIG Scheduler</title>
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
        
        .btn-danger {
            background-color: #dc3545;
            color: white;
        }
        
        .btn-secondary {
            background-color: #6c757d;
            color: white;
        }
        
        .table-container {
            overflow-x: auto;
        }
        
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        
        th, td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        
        th {
            background-color: #f8f9fa;
            font-weight: 600;
            color: #495057;
        }
        
        tr:hover {
            background-color: #f8f9fa;
        }
        
        .status-badge {
            padding: 4px 12px;
            border-radius: 12px;
            font-size: 12px;
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
        
        .actions {
            display: flex;
            gap: 8px;
        }
        
        .btn-sm {
            padding: 6px 12px;
            font-size: 12px;
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
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>📋 실행 계획 목록</h1>
            <a href="/wizmig/execution-plan/create?sessionName=${sessionName}" class="btn btn-primary">
                ➕ 새 실행 계획
            </a>
        </div>
        
        <c:choose>
            <c:when test="${empty plans}">
                <div class="empty-state">
                    <div class="empty-state-icon">📝</div>
                    <h3>등록된 실행 계획이 없습니다</h3>
                    <p style="margin-top: 10px;">새 실행 계획을 생성하여 스크립트를 순차적으로 실행하세요.</p>
                </div>
            </c:when>
            <c:otherwise>
                <div class="table-container">
                    <table>
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>계획명</th>
                                <th>세션</th>
                                <th>상태</th>
                                <th>생성일시</th>
                                <th>시작일시</th>
                                <th>완료일시</th>
                                <th>작업</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${plans}" var="plan">
                                <tr>
                                    <td>${plan.planId}</td>
                                    <td>
                                        <a href="/wizmig/execution-plan/${plan.planId}" style="color: #007bff; text-decoration: none;">
                                            <strong>${plan.planName}</strong>
                                        </a>
                                        <c:if test="${not empty plan.description}">
                                            <br><small style="color: #6c757d;">${plan.description}</small>
                                        </c:if>
                                    </td>
                                    <td>${plan.sessionName}</td>
                                    <td>
                                        <span class="status-badge status-${fn:toLowerCase(plan.status)}">
                                            ${plan.status}
                                        </span>
                                    </td>
                                    <td>
                                        <fmt:formatDate value="${plan.createdAt}" pattern="yyyy-MM-dd HH:mm:ss" />
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${not empty plan.startedAt}">
                                                <fmt:formatDate value="${plan.startedAt}" pattern="yyyy-MM-dd HH:mm:ss" />
                                            </c:when>
                                            <c:otherwise>-</c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${not empty plan.completedAt}">
                                                <fmt:formatDate value="${plan.completedAt}" pattern="yyyy-MM-dd HH:mm:ss" />
                                            </c:when>
                                            <c:otherwise>-</c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <div class="actions">
                                            <c:choose>
                                                <c:when test="${plan.status == 'READY' || plan.status == 'PAUSED'}">
                                                    <button onclick="startPlan(${plan.planId})" class="btn btn-success btn-sm">
                                                        ▶ 실행
                                                    </button>
                                                </c:when>
                                                <c:when test="${plan.status == 'RUNNING'}">
                                                    <button onclick="stopPlan(${plan.planId})" class="btn btn-danger btn-sm">
                                                        ⏸ 중지
                                                    </button>
                                                </c:when>
                                            </c:choose>
                                            <a href="/wizmig/execution-plan/${plan.planId}" class="btn btn-secondary btn-sm">
                                                👁 상세
                                            </a>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
    
    <script>
        function startPlan(planId) {
            if (confirm('실행 계획을 시작하시겠습니까?')) {
                fetch('/wizmig/execution-plan/api/' + planId + '/start', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json'
                    }
                })
                .then(response => response.json())
                .then(data => {
                    if (data.success) {
                        alert('실행 계획이 시작되었습니다.');
                        location.reload();
                    } else {
                        alert('오류: ' + data.message);
                    }
                })
                .catch(error => {
                    alert('실행 중 오류가 발생했습니다: ' + error);
                });
            }
        }
        
        function stopPlan(planId) {
            if (confirm('실행 계획을 중지하시겠습니까?')) {
                fetch('/wizmig/execution-plan/api/' + planId + '/stop', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json'
                    }
                })
                .then(response => response.json())
                .then(data => {
                    if (data.success) {
                        alert('실행 계획이 중지되었습니다.');
                        location.reload();
                    } else {
                        alert('오류: ' + data.message);
                    }
                })
                .catch(error => {
                    alert('중지 중 오류가 발생했습니다: ' + error);
                });
            }
        }
        
        // 실행 중인 계획이 있으면 5초마다 상태 업데이트
        <c:if test="${not empty plans}">
            <c:forEach items="${plans}" var="plan">
                <c:if test="${plan.status == 'RUNNING'}">
                    setInterval(function() {
                        location.reload();
                    }, 5000);
                </c:if>
            </c:forEach>
        </c:if>
    </script>
</body>
</html>
