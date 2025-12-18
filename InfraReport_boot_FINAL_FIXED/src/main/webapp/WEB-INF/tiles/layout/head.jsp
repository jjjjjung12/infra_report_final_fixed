<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>

<c:set var="ctx" value="${pageContext.request.contextPath}"/>

<meta name="_csrfToken" content="${_csrf.token}"/>
<meta name="_csrfName" content="${_csrf.parameterName}"/>
<meta id="_contextPath" name="_contextPath" content="${ctx}" />

<!-- 아이콘 설정 -->
<link rel="icon" type="image/x-icon" href="data:image/x-icon;," >

<meta name="viewport" content="width=device-width, initial-scale=1.0">

<link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">

<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/3.9.1/chart.min.js"></script>

<!-- common.js -->
<script type="text/javascript" src="${ctx}/js/common.js"></script>

<style>
    body {
        background-color: #f8f9fa;
        font-family: 'Malgun Gothic', sans-serif;
    }
    .header-section {
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        color: white;
        padding: 20px 0;
        margin-bottom: 30px;
    }
    /* 탭 스타일 */
    .nav-tabs {
        border-bottom: 3px solid #667eea;
        margin-bottom: 20px;
    }
    .nav-tabs .nav-link {
        color: #495057;
        border: none;
        padding: 12px 24px;
        font-weight: 500;
    }
    .nav-tabs .nav-link.active {
        color: #667eea;
        background-color: white;
        border-bottom: 3px solid #667eea;
        margin-bottom: -3px;
    }
    /* 카드 스타일 */
    .card {
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        border: none;
        margin-bottom: 20px;
        border-radius: 10px;
    }
    /* 카테고리 배지 */
    .category-neis { background-color: #e3f2fd; color: #1976d2; }
    .category-edufine { background-color: #f3e5f5; color: #7b1fa2; }
    .category-common { background-color: #e8f5e9; color: #388e3c; }
    /* 상태 배지 */
    .status-normal { background-color: #d4edda; color: #155724; }
    .status-warning { background-color: #fff3cd; color: #856404; }
    .status-error { background-color: #f8d7da; color: #721c24; }
    /* 점검 결과 표시 */
    .result-success { color: #28a745; font-weight: bold; }
    .result-fail { color: #dc3545; font-weight: bold; }
    /* 통계 카드 */
    .stat-card {
        text-align: center;
        padding: 20px;
        border-radius: 10px;
    }
    .stat-number {
        font-size: 2.5rem;
        font-weight: bold;
        margin-bottom: 5px;
    }
    /* 엑셀 업로드 영역 */
    .upload-area {
        border: 2px dashed #667eea;
        border-radius: 10px;
        padding: 30px;
        text-align: center;
        background-color: #f8f9fa;
        cursor: pointer;
    }
    .upload-area:hover {
        background-color: #e9ecef;
        border-color: #764ba2;
    }
    .table th {
        background-color: #495057;
        color: white;
        font-weight: 600;
        position: relative;
        user-select: none;
        cursor: pointer;
    }
    
    .table td {
    	max-width: 200px;        /* 셀의 최대 너비 지정 */
	  	white-space: nowrap;     /* 줄바꿈 방지 */
	  	overflow: hidden;        /* 넘치는 부분 숨기기 */
	  	text-overflow: ellipsis; /* 넘친 텍스트를 ...으로 표시 */
	}

    /* 정렬 아이콘 */
    .sort-icon {
        position: absolute;
        right: 8px;
        top: 50%;
        transform: translateY(-50%);
        opacity: 0.5;
        transition: opacity 0.2s;
    }
    .table th:hover .sort-icon {
        opacity: 1;
    }
    .sort-asc .sort-icon::before {
        content: "▲";
        color: #ffc107;
    }
    .sort-desc .sort-icon::before {
        content: "▼";
        color: #ffc107;
    }
    
    /* 검색 폼 개선 - 가로 배치 */
    .search-form {
        background: #f8f9fa;
        padding: 15px;
        border-radius: 10px;
        margin-bottom: 20px;
    }
    .search-form .form-control,
    .search-form .form-select {
        border: 1px solid #ced4da;
        border-radius: 6px;
    }
    .search-form .btn {
        border-radius: 6px;
    }
    
    /* 그래프 컨테이너 */
    .chart-container {
        position: relative;
        height: 400px;
        margin-bottom: 20px;
    }
    
    /* 자원 사용률 프로그레스 바 */
    .usage-progress {
        height: 20px;
        border-radius: 10px;
        overflow: hidden;
    }
    .usage-progress .progress-bar {
        border-radius: 10px;
        transition: width 0.6s ease;
    }
    
    /* 반응형 테이블 */
    @media (max-width: 768px) {
        .search-form {
            padding: 10px;
        }
        .search-form .form-control,
        .search-form .form-select,
        .search-form .btn {
            margin-bottom: 10px;
        }
    }
</style>